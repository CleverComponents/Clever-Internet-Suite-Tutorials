using System;
using CleverComponents.InetSuite;

//http://www.faqs.org/rfcs/rfc2060.html

namespace ConsoleApp1
{
	public class ImapUtf7Encoder
	{
		private static string DecodeBase64Imap(string value)
		{
			using (var enc = new Encoder())
			{
				enc.EncodeMethod = EncodeMethod.Base64;

				enc.CharSet = "UTF-7";
				var b = enc.DecodeToBytes(value.Replace(',', '/'));
				return Translator.GetString(b, "UTF-16BE");
			}
		}

		public static string Decode(string value)
		{
			string result = "";
			int n = value.Length;
			int h = 0;

			while (h < n)
			{
				int t = value.IndexOf('&', h);
				if (t < 0)
				{
					t = n;
				}

				result += value.Substring(h, t - h);
				h = t + 1;
				if (h >= n) break;

				t = value.IndexOf('-', h);
				if (t < 0)
				{
					t = n;
				}

				int k = t - h;

				if (k == 0)
				{
					result += '&';
				}
				else
				{
					result += DecodeBase64Imap(value.Substring(h, k));
				}
				h = t + 1;
			}

			return result;
		}
	}
}
