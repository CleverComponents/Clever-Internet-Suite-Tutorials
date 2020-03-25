using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.ServiceProcess;
using System.Text;
using CleverComponents.InetSuite;
using System.IO;

namespace SmtpServerService {
	public partial class Service1 : ServiceBase {
		public Service1() {
			InitializeComponent();
		}

		protected override void OnStart(string[] args) {
			smtpServer1.Start();
			timer1.Enabled = true;
		}

		protected override void OnStop() {
			smtpServer1.Stop();
		}

		private string[] ExtractRelayTo(string[] envelope) {
			string[] result = new string[envelope.Length - 1];
			Array.Copy(envelope, 1, result, 0, envelope.Length - 1);
			return result;
		}

		private void timer1_Tick(object sender, EventArgs e) {
			timer1.Enabled = false;
			try {
				string path = FileUtils.AddTrailingBackSlash(smtpFileHandler1.RelayDir);
				string[] envelopeList = Directory.GetFiles(path, "*" + SmtpFileHandler.EnvelopeFileExt);
				foreach (string env in envelopeList) {
					string[] envelope = File.ReadAllLines(env);
					if (envelope.Length < 2) continue;

					smtpRelay1.MailFrom = envelope[0];
					smtpRelay1.MailToList = ExtractRelayTo(envelope);

					string msg = Path.ChangeExtension(env, SmtpFileHandler.MessageFileExt);
					using (Stream stream = File.OpenRead(msg)) {
						smtpRelay1.MailData.LoadFromStream(stream, "");
					}

					smtpRelay1.Send();

					File.Delete(msg);
					File.Delete(env);
				}
			}
			finally {
				timer1.Enabled = true;
			}
		}
	}
}
