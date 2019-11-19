using System;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using CleverComponents.InetSuite;

namespace Server {
	public partial class Form1 : Form {
		MyServer server;

		void DoConnect(object sender, ConnectionAcceptedEventArgs e) {
			PutLogMessage("Accept Connection. Host: " + e.Connection.PeerIP);
		}

		void DoDisconnect(object sender, ConnectionEventArgs e) {
			PutLogMessage("Close Connection. Host: " + e.Connection.PeerIP);
			PutLogMessage("");
		}

		void DoLinesSent(object sender, MyLinesSentEventArgs e) {
			PutLogMessage("Received Lines:");

			foreach (string s in e.Lines) {
				PutLogMessage(s);
			}
		}

		delegate void PutLogMessageDelegate(string logMessage);

		void PutLogMessage(string logMessage) {
			if (this.IsDisposed) return;

			if (this.InvokeRequired) {
				this.Invoke(new PutLogMessageDelegate(PutLogMessage), new object[] { logMessage });
			}
			else {
				textBox1.Text += logMessage + "\r\n";
				textBox1.Select(textBox1.Text.Length, 0);
				textBox1.ScrollToCaret();
			}
		}

		public Form1() {
			InitializeComponent();

			components = new Container();

			server = new MyServer();
			components.Add(server);
			server.Port = 2110;

			server.ConnectionAccepted += new ConnectionAcceptedEventHandler(DoConnect);
			server.ConnectionClosed += new ConnectionEventHandler(DoDisconnect);
			server.LinesSent += new MyLinesSentEventHandler(DoLinesSent);

			server.Start();
		}
	}
}
