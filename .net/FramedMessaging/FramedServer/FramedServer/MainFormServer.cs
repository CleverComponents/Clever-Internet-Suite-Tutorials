using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using CleverComponents.InetSuite;

namespace FramedServer
{
	public partial class MainFormServer : Form
	{
		public MainFormServer()
		{
			InitializeComponent();
			server = new FramedServer();

			server.FrameReceived += Server_FrameReceived;
		}

		delegate void PutMessageDelegate(string message);

		private void PutMessageToLog(string message)
		{
			if (this.IsDisposed) return;

			if (this.InvokeRequired)
			{
				this.Invoke(new PutMessageDelegate(PutMessageToLog), new object[] { message });
			}
			else
			{
				txtMessages.Text += message + "\r\n";
				txtMessages.Select(txtMessages.Text.Length, 0);
				txtMessages.ScrollToCaret();
			}
		}

		private void Server_FrameReceived(object sender, ConnectionFramedDataEventArgs e)
		{
			string message = Translator.GetString(e.Data, "utf-8");
			PutMessageToLog(message);

			byte[] reply = Translator.GetBytes(message, "utf-8");
			e.Connection.SendFramedData(reply);
		}

		private void btnStart_Click(object sender, EventArgs e)
		{
			if (server.Active)
			{
				MessageBox.Show("Already strated.");
				return;
			}

			server.Port = Convert.ToInt32(txtPort.Text);
			server.Start();

			Text = "Framed Server - Strated.";
		}

		private void btnStop_Click(object sender, EventArgs e)
		{
			server.Stop();
			Text = "Framed Server";
		}
	}
}
