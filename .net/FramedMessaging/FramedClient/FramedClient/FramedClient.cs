using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;
using CleverComponents.InetSuite;

namespace FramedClient
{
	public class FramedClient : TcpClient
	{
		protected override int GetDefaultPort()
		{
			return 2110;
		}
		
		public void SendMessage(string message)
		{
			byte[] data = Translator.GetBytes(message, "utf-8");
			SendFramedData(data);
		}
		public void SendFramedData(byte[] data)
		{
			if (data == null) throw new Exception("No data to send.");

			Connection.InitProgress(0, 0);
			Connection.BytesToProceed = -1;
			byte[] buffer = new byte[4];
			int index = 0;
			Utils.ByteArrayWriteDWord((uint)data.Length, buffer, ref index);
			Connection.WriteBytes(buffer, 0, buffer.Length);

			Connection.WriteBytes(data, 0, data.Length);
		}
		
		public string ReceiveReply()
		{
			byte[] buffer = ReceiveFramedData();
			return Translator.GetString(buffer, "utf-8");
		}
		public byte[] ReceiveFramedData()
		{
			using (var frame = new MemoryStream())
			{
				Connection.InitProgress(0, 0);
				Connection.BytesToProceed = 4;
				do
				{
					Connection.ReadData(frame);
				}
				while (frame.Length < 4);

				frame.Position = 0;
				byte[] buffer = new byte[4];
				frame.Read(buffer, 0, buffer.Length);
				int index = 0;
				uint size = Utils.ByteArrayReadDWord(buffer, ref index);

				Connection.BytesToProceed += size;
				while (size > frame.Length - 4)
				{
					Connection.ReadData(frame);
				}

				frame.Position = 4;
				buffer = new byte[size];
				frame.Read(buffer, 0, (int)size);
				return buffer;
			}
		}
	}
}
