using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.IO;
using CleverComponents.InetSuite;

namespace Server {
	public partial class Form1 : Form {
		public Form1() {
			InitializeComponent();
		}

		private void button1_Click(object sender, EventArgs e) {
			using (TcpServerConnection server = new TcpServerConnection()) {
				server.NetworkStream = new NetworkStream();

				server.TimeOut = 60000;
				server.BatchSize = 8192;
				server.Listen(2110);
				server.Accept();
				textBox1.Text += "connected\r\n";

				using (StringStream data = new StringStream()) {
					server.ReadData(data);
					data.Position = 0;
					server.WriteData(data);
				}

				textBox1.Text += "read done\r\n";

				server.Close(false);
				textBox1.Text += "closed\r\n";
			}
		}
	}
}
