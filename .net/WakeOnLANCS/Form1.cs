using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using CleverComponents.InetSuite;

namespace WakeOnLANCS {
	public partial class Form1 : Form {
		public Form1() {
			InitializeComponent();
		}

		private byte[] GetWakeUpPacket(string s) {
			List<byte> arr = new List<byte>(102);

			string[] macs = s.Split(' ', ':', '-');

			for (int i = 0; i < 6; i++) {
				arr.Add(0xff);
			}

			for (int j = 0; j < 16; j++) {
				for (int i = 0; i < 6; i++) {
					arr.Add(Convert.ToByte(macs[i], 16));
				}
			}

			return arr.ToArray();
		}

		private void btnWakeUp_Click(object sender, EventArgs e) {
			using (UdpClientConnection client = new UdpClientConnection()) {
				client.NetworkStream = new NetworkStream();

				client.Open(System.Net.IPAddress.Broadcast, 9);
				client.Broadcast();

				byte[] buf = GetWakeUpPacket(edtMAC.Text);
				client.WriteBytes(buf, 0, buf.Length);
			}

			MessageBox.Show("Done");
		}
	}
}
