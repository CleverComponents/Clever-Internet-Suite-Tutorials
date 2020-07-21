using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace FramedClient
{
	public partial class MainForm : Form
	{
		public MainForm()
		{
			InitializeComponent();
			client = new FramedClient();
		}

		private void btnConnect_Click(object sender, EventArgs e)
		{
			if (client.Active)
			{
				MessageBox.Show("Already connected.");
				return;
			}

			client.Server = txtHost.Text;
			client.Port = Convert.ToInt32(txtPort.Text);
			client.TimeOut = 5000;
			client.Open();
			this.Text = "Framed Client - Connected.";
		}

		private void btnDisconnect_Click(object sender, EventArgs e)
		{
			client.Close();
			this.Text = "Framed Client";
		}

		private void btnSend_Click(object sender, EventArgs e)
		{
			if (!client.Active)
			{
				MessageBox.Show("Not connected.");
				return;
			}

			client.SendMessage(txtMessage.Text);
			string reply = client.ReceiveReply();

			txtReplice.Text += reply + "\r\n";
			txtReplice.Select(txtReplice.Text.Length, 0);
			txtReplice.ScrollToCaret();
		}
	}

	public class ExceptionHandler
	{
		public void OnThreadException(object sender, System.Threading.ThreadExceptionEventArgs t)
		{
			MessageBox.Show(t.Exception.Message);
		}
	}
}
