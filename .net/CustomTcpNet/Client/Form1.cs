using System;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using CleverComponents.InetSuite;

namespace Client {
	public partial class Form1 : Form {
		public Form1() {
			InitializeComponent();
		}

		private void button1_Click(object sender, EventArgs e) {
			using (MyClient client = new MyClient()) {
				client.Server = "localhost";
				client.Port = 2110;
				client.TimeOut = 1000;
				client.UserName = "testuser";
				client.Open();

				client.Login();

				string[] lines = client.GetLines();
				textBox1.Text += StringUtils.GetStringsAsString(lines);

				lines = new string[] {
					"<root>",
					"<somedata>data</somedata>",
					"</root>"
				};
				client.SendLines(lines);

				client.Close();

				textBox1.Text += "Done\r\n\r\n";
			}
		}
	}
}
