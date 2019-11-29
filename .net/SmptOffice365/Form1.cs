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

namespace SmptOffice365
{
	public partial class Form1 : Form
	{
		public Form1()
		{
			InitializeComponent();
		}

		private void button1_Click(object sender, EventArgs e)
		{
			if (smtp1.Active) return;

			smtp1.Server = tbServer.Text;
			smtp1.Port = Convert.ToInt32(tbPort.Text);

			smtp1.UserName = tbUser.Text;
			smtp1.Password = tbPassword.Text;

			smtp1.UseTls = ClientTlsMode.Explicit;

			smtp1.Open();

			try
			{
				mailMessage1.BuildMessage(tbBild.Text, "");
				mailMessage1.From.FullAddress = tbUser.Text;
				mailMessage1.ToList.EmailAddresses = tbTo.Text;
				mailMessage1.Subject = tbSubject.Text;

				smtp1.Send(mailMessage1);

				MessageBox.Show("The message was sent successfully.");
			}
			finally
			{
				smtp1.Close();
			}
		}
		private void smtp1_VerifyServer(object sender, CleverComponents.InetSuite.VerifyPeerEventArgs e)
		{
			if (!e.Verified && (MessageBox.Show(e.StatusText + "\r\n Do you wish to proceed ?", "Verify certificate",
				MessageBoxButtons.YesNo) == DialogResult.Yes))
			{
				e.Verified = true;
			}
		}
	}
}
