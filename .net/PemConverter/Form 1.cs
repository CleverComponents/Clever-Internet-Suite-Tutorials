using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Linq;
using System.Threading.Tasks;
using System.Windows.Forms;
using CleverComponents.InetSuite;

namespace WindowsFormsApp1
{
	public partial class Form1 : Form
	{
		public Form1()
		{
			InitializeComponent();
		}
		//converts from RSA Public Key format to X509 Subject Key Info format
		private string Rsa2X509Convert(string rsaPublicKey)
		{
			using (RsaKey rsaKey = new CryptRsaKey())
			{
				rsaKey.Init();

				var key = Encoder.DecodeToBytes(rsaPublicKey, EncodeMethod.Base64);
				rsaKey.SetRsaPublicKey(key);
				key = rsaKey.GetPublicKeyInfo();

				var result = Encoder.Encode(key, EncodeMethod.Base64);
				return result;
			}			
		}

		//converts from RSA Public Key PEM format to X509 Subject Key Info PEM format
		private string Rsa2X509PemConvert(string rsaPublicKey)
		{
			using (RsaKey rsaKey = new CryptRsaKey())
			using (CryptEncoder encoder = new CryptEncoder())
			{
				rsaKey.Init();

				var key = encoder.Decode(rsaPublicKey);
				rsaKey.SetRsaPublicKey(key);
				key = rsaKey.GetPublicKeyInfo();

				var result = encoder.Encode(key);
				return result;
			}
		}
		private void button1_Click(object sender, EventArgs e)
		{
			string RsaKey, x509KeyInfo;
			RsaKey = textBox1.Text;
			x509KeyInfo = Rsa2X509Convert(RsaKey);

			textBox3.Text = x509KeyInfo;
		}
		private void button2_Click(object sender, EventArgs e)
		{
			string RsaKeyPem, x509KeyInfo;
			RsaKeyPem = textBox2.Text;
			x509KeyInfo = Rsa2X509PemConvert(RsaKeyPem);

			textBox3.Text = x509KeyInfo;
		}
	}
}
