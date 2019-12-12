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

namespace SettingUpHttpProxy
{
	public partial class Form1 : Form
	{
		public Form1()
		{
			InitializeComponent();
		}

		private void btnHttp_Click(object sender, EventArgs e)
		{
			string response;

			http1.ProxySettings.UserName = "user";
			http1.ProxySettings.Password = "psw";
			http1.ProxySettings.Server = "proxy-domain.com";
			http1.ProxySettings.Port = 8080;

			response = http1.Get("https://www.clevercomponents.com/checknews/clnews.html");
		}

		private void btnFptProxy_Click(object sender, EventArgs e)
		{
			ftp1.ProxySettings.UserName = "user";
			ftp1.ProxySettings.Password = "psw";
			ftp1.ProxySettings.Server = "proxy-domain.com";
			ftp1.ProxySettings.Port = 8080;
			ftp1.ProxySettings.ProxyType = FtpProxyType.HttpConnect;

			ftp1.UserName = "ftp-user";
			ftp1.Password = "secret";
			ftp1.Server = "ftp-host";
			ftp1.Port = 21;
			ftp1.Open();
		}

		private void btnSMPT_Click(object sender, EventArgs e)
		{
			httpProxy1.UserName = "user";
			httpProxy1.Password = "psw";
			httpProxy1.Server = "proxy-domain.com";
			httpProxy1.Port = 8080;

			smtp1.Proxy= httpProxy1;

			smtp1.UserName ="mail-user";
			smtp1.Password = "secret";
			smtp1.Server = "mail-host";
			smtp1.Port = 25;
			smtp1.Open();
		}
	}
}
