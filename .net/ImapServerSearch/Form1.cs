using System;
using System.Windows.Forms;
using System.Globalization;
using System.IO;
using CleverComponents.InetSuite;

namespace ImapServerSearch
{
	public partial class MainForm : Form
	{
		public MainForm()
		{
			InitializeComponent();
		}

		delegate void PutLogMessageDelegate(string logMessage);

		void PutLogMessage(string logMessage)
		{
			if (this.IsDisposed) return;

			if (this.InvokeRequired)
			{
				this.Invoke(new PutLogMessageDelegate(PutLogMessage), new object[] { logMessage });
			}
			else
			{
				memLog.Text += logMessage + "\r\n";
				memLog.Select(memLog.Text.Length, 0);
				memLog.ScrollToCaret();
			}
		}

		private void btnStart_Click(object sender, EventArgs e)
		{
			try
			{
				imap4Server1.Port = Convert.ToInt32(edtPort.Text);
				imap4FileHandler1.MailBoxDir = edtRootDir.Text;
				Directory.CreateDirectory(FileUtils.AddTrailingBackSlash(imap4FileHandler1.MailBoxDir));
				Directory.CreateDirectory(FileUtils.AddTrailingBackSlash(imap4FileHandler1.MailBoxDir) + "CleverTester\\");
				imap4Server1.Start();
			}
			catch (Exception ex)
			{
				MessageBox.Show(ex.Message);
			}
		}

		private void btnStop_Click(object sender, EventArgs e)
		{
			imap4Server1.Stop();
		}

		private void imap4Server1_Authenticate(object sender, CleverComponents.InetSuite.Imap4AuthenticateEventArgs e)
		{
			PutLogMessage("Authenticate user: " + e.Account?.UserName ?? "unknown");
		}

		private void imap4Server1_CommandReceived(object sender, CleverComponents.InetSuite.TcpCommandEventArgs e)
		{
			PutLogMessage("Command: " + e.CommandParams.Command + " " + e.CommandParams.Parameters);
		}

		private void imap4Server1_ConnectionAccepted(object sender, CleverComponents.InetSuite.ConnectionAcceptedEventArgs e)
		{
			PutLogMessage("Accept Connection. Host: " + e.Connection.PeerIP);
		}

		private void imap4Server1_ConnectionClosed(object sender, CleverComponents.InetSuite.ConnectionEventArgs e)
		{
			PutLogMessage("Close Connection. Host: " + e.Connection.PeerIP);
		}

		private void imap4Server1_ResponseSent(object sender, CleverComponents.InetSuite.TcpResponseEventArgs e)
		{
			PutLogMessage("Reply: " + e.Response);
		}

		private void imap4Server1_Started(object sender, EventArgs e)
		{
			PutLogMessage("==================\r\nStart Server");
		}

		private void imap4Server1_Stopped(object sender, EventArgs e)
		{
			PutLogMessage("Stop Server");
		}

		private void imap4Server1_SearchMessage(object sender, Imap4SearchMessageEventArgs e)
		{
			if (e.Criteria.IndexOf("UNDELETED SINCE") > -1)
			{
				string dateCriteria = e.Criteria.Substring("UNDELETED SINCE".Length).Trim();
				if (DateTime.TryParseExact(dateCriteria, "d-MMM-yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out DateTime date))
				{
					e.Matches = ((e.Message.Flags & MailMessageFlags.Deleted) == 0) && (e.Message.Date > date);
					e.Handled = true;
				}
			}
		}
	}
}
