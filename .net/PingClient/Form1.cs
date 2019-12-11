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

namespace PingClient
{
	public partial class Form1 : Form
	{
		public Form1()
		{
			InitializeComponent();
		}

		private void btnPing_Click(object sender, EventArgs e)
		{
			using (var client = new IcmpConnection())
			{
				client.NetworkStream = new NetworkStream();
				client.TimeOut = 1000;
				client.Open(HostResolver.GetIPAddress(txtHost.Text));

				txtResult.Text = "";

				for (int i = 0; i < 4; i++)
				{
					try
					{
						client.SendEchoRequest();
						var response = client.ReceiveResponse();
						if (!(response.IcmpPacket is IcmpEchoPacket))
						{
							throw new Exception("Invalid ICMP reply");
						}

						txtResult.Text += String.Format("Reply from {0}: seq={1} received bytes={2} time={3}ms TTL={4}\r\n",
							txtHost.Text,
							(response.IcmpPacket as IcmpEchoPacket).SequenceNumber,
							(response.IcmpPacket as IcmpEchoPacket).Data.Length,
							response.RoundTripTime,
							response.IpHeader.Ttl);

						System.Threading.Thread.Sleep(1000);
					}
					catch (Exception ex)
					{
						  txtResult.Text += " Error: " + ex.Message + "\r\n";
					}
				}
			}
		}
	}
}
