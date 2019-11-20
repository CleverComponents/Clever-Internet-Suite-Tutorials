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

namespace Client {
	public partial class Form1 : Form {
		public Form1() {
			InitializeComponent();
		}

		private void button1_Click(object sender, EventArgs e) {
			using (TcpClientConnection client = new TcpClientConnection()) {
				client.NetworkStream = new NetworkStream();

				client.TimeOut = 60000;
				client.Open(HostResolver.GetIPAddress("127.0.0.1"), 2110);
				MessageBox.Show("Client connected");

				using (StringStream data = new StringStream("Data to be sent")) {
					client.WriteData(data);
					data.SetLength(0);
					client.IsReadUntilClose = true;
					client.ReadData(data);

					MessageBox.Show(data.DataString);
				}

				client.Close(true);
				MessageBox.Show("Client disconnected");
			}
		}
	}
}
