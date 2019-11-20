using System;
using System.IO;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using CleverComponents.InetSuite;

namespace MailQueue {
	public partial class Form1 : Form {
		public Form1() {
			InitializeComponent();
		}

		private void btnStart_Click(object sender, EventArgs e) {
			this.watcher.EnableRaisingEvents = false;
			this.watcher.Path = FileUtils.AddTrailingBackSlash(edtQueueFolder.Text);
			this.watcher.EnableRaisingEvents = true;

			relay.DnsServer = edtDNS.Text;

			this.Text = "Mail Sending Queue - Started";
		}

		private void btnStop_Click(object sender, EventArgs e) {
			this.watcher.EnableRaisingEvents = false;

			this.Text = "Mail Sending Queue";
		}

		private void watcher_Created(object sender, System.IO.FileSystemEventArgs e) {
			lock (this) {
				edtLog.Text += e.Name + "\r\n";

				StringCollectionEx src = new StringCollectionEx();

				using (Stream stream = File.OpenRead(e.FullPath)) {
					src.LoadFromStream(stream, "");
				}

				relay.Send(src);

				foreach (SmtpRelayStatus item in relay.StatusList) {
					edtLog.Text += item.Domain;
					if (item.IsSent) {
						edtLog.Text += " - Sent\r\n";
					}
					else {
						edtLog.Text += " - Error: " + item.ErrorText + "\r\n";
					}
				}
			}
		}
	}
}
