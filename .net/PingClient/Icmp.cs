using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Globalization;
using CleverComponents.InetSuite;
using System.Net.Sockets;
using System.IO;
using System.Net;

namespace PingClient
{
	public class IcmpPacket
	{
		public virtual void Build(byte[] destination, ref int index)
		{
			destination[index] = PacketType;
			index++;
			destination[index] = PacketCode;
			index++;
			Utils.ByteArrayWriteWord(Checksum, destination, ref index);
		}

		public virtual void Parse(byte[] source, ref int index)
		{
			PacketType = source[index];
			index++;
			PacketCode = source[index];
			index++;
			Checksum = Utils.ByteArrayReadWord(source, ref index);
		}

		public byte PacketType { get; set; }
		public byte PacketCode { get; set; }
		public ushort Checksum { get; set; }
	}

	public class IcmpEchoPacket : IcmpPacket
	{
		public IcmpEchoPacket() : base()
		{
			PacketType = 8;
			PacketCode = 0;
		}

		public override void Build(byte[] destination, ref int index)
		{
			base.Build(destination, ref index);

			Utils.ByteArrayWriteWord(Identifier, destination, ref index);
			Utils.ByteArrayWriteWord(SequenceNumber, destination, ref index);
			var buf = Translator.GetBytes(Data, "us-ascii");
			Array.Copy(buf, 0, destination, index, 32);
			index += 32;
		}

		public override void Parse(byte[] source, ref int index)
		{
			base.Parse(source, ref index);

			Identifier = Utils.ByteArrayReadWord(source, ref index);
			SequenceNumber = Utils.ByteArrayReadWord(source, ref index);
			Data = Translator.GetString(source, index, source.Length - index, "us-ascii");
			index = source.Length;
		}
		public ushort Identifier { get; set; }
		public ushort SequenceNumber { get; set; }
		public string Data { get; set; }
	}

	public class RawIPHeader
	{
		public virtual void Parse(byte[] source, ref int index)
		{
			Version = (byte)((source[index] & 0xF0) >> 4);

			HeaderLength = (byte)((source[index] & 0x0F) * 4);
			index++;

			ToS = source[index];
			index++;

			Length = Utils.ByteArrayReadWord(source, ref index);

			Identification = Utils.ByteArrayReadWord(source, ref index);

			Flags = (byte)((source[index] & 0xE000) >> 13);
			FragmentOffset = (byte)((Utils.ByteArrayReadWord(source, ref index) & 0x1FFF));

			Ttl = source[index]; 
			index++;

			Protocol = source[index];
			index++;

			Checksum = Utils.ByteArrayReadWord(source, ref index);

			Source = String.Format("{0}.{1}.{2}.{3}", source[index], source[index + 1], source[index + 2], source[index + 3]);
			index += 4;

			Destination = String.Format("{0}.{1}.{2}.{3}", source[index], source[index + 1], source[index + 2], source[index + 3]);
			index += 4;

			index = HeaderLength;
		}

		public byte Version { get; set; }
		public byte HeaderLength { get; set; }
		public byte ToS { get; set; }
		public byte Ttl { get; set; }
		public byte Protocol { get; set; }
		public byte Flags { get; set; }
		public ushort Length { get; set; }
		public ushort Identification { get; set; }
		public ushort FragmentOffset { get; set; }
		public ushort Checksum { get; set; }
		public string Source { get; set; }
		public string Destination { get; set; }
	}

	public class IcmpResponse
	{
 		protected IcmpPacket CreatePacket(byte[] source, int index)
		{
			var packet = new IcmpPacket();

			packet.Parse(source, ref index);
			return CreatePacketByType(packet.PacketType);
		}
		protected virtual IcmpPacket CreatePacketByType(ushort packetType)
		{
			switch (packetType)
			{
				case 8: return new IcmpEchoPacket();
				case 0: return new IcmpEchoPacket();
				default: return new IcmpPacket();
			} 
		}

		public IcmpResponse() : base()
		{
			IpHeader = new RawIPHeader();
			IcmpPacket = null;
			RoundTripTime = 0;
		}
		public virtual void Parse(byte[] source, ref int index)
		{
			IpHeader.Parse(source, ref index);

			IcmpPacket = CreatePacket(source, index);
			try
			{
				IcmpPacket.Parse(source, ref index);
			}
			catch (Exception)
			{
				IcmpPacket = null;
				throw;
			}
		}

		public RawIPHeader IpHeader { get; }
		public IcmpPacket IcmpPacket { get; private set; }
		public int RoundTripTime { get; set; }
	}

	public class IcmpConnection : UdpConnection
	{
		private int startTicks;
		private void NextSequenceNumber()
		{
			SequenceNumber++;
			if (SequenceNumber == 0)
			{
				SequenceNumber = 1;
			}
		}

		private void SetTtl()
		{
			Socket.SetSocketOption(SocketOptionLevel.IP, SocketOptionName.IpTimeToLive, Ttl);
		}
		private ushort CalculateChecksum(byte[] data, int index, int size)
		{
			uint checksum = 0;
			int i = index;

			if (size > data.Length - index)
			{
				size = data.Length - index;
			}

			while (size > 1)
			{
				checksum += Utils.ByteArrayReadWord(data, ref i);
				size -= 2;
			}

			if (size > 0)
			{
				checksum += data[i];
			}

			checksum = (checksum >> 16) + (checksum & 0xffff);
			checksum += (checksum >> 16);
			return (ushort)(~checksum);
		}

		public IcmpConnection() : base()
		{
			Identifier = (ushort)(System.Diagnostics.Process.GetCurrentProcess().Id);
			SequenceNumber = 1;
			Ttl = 128;
			startTicks = 0;
		}

		public void Open(IPAddress ip)
		{
			CreateSocket(ip.AddressFamily, SocketType.Raw, ProtocolType.Icmp);

			if (!StringUtils.IsEmpty(LocalBinding))
			{
				NetworkStream.Bind(IpAddressUtils.GetBindingIPAddress(LocalBinding, ip.AddressFamily), 0);
			}

			NetworkStream.SetPeerInfo(ip, 0);
			SetActive(true);
			NetworkStream.StreamReady();
		}
		public void SendRequest(IcmpPacket request)
		{
			SetTtl();

			using (var stream = new MemoryStream())
			{
				var buf = new byte[1024];
				int ind = 0;

				request.Build(buf, ref ind);

				if (request.Checksum == 0)
				{
					ushort checksum = CalculateChecksum(buf, 0, ind);

					int checksumInd = 2;
					Utils.ByteArrayWriteWord(checksum, buf, ref checksumInd);
				}
				stream.Write(buf, 0, ind);
				stream.Position = 0;

				startTicks = System.Environment.TickCount;
				WriteData(stream);
			}
		}

		public IcmpResponse ReceiveResponse()
		{
			using (var stream = new MemoryStream())
			{
				ReadData(stream);
				stream.Position = 0;

				int ticks = System.Environment.TickCount - startTicks;

				int ind = (int)(stream.Length);
				var buf = new byte[ind];
				stream.Read(buf, 0, ind);
				ind = 0;

				IcmpResponse result = new IcmpResponse();
	
				result.Parse(buf, ref ind);
				result.RoundTripTime = ticks;
				return result;
			}
		}

		public void SendEchoRequest()
		{
			try
			{
				var echo = new IcmpEchoPacket();

				echo.Identifier = Identifier;
				echo.SequenceNumber = SequenceNumber;
				echo.Data = "abcdefghijklmnopqrstuvwabcdefghi";

				SendRequest(echo);
			}
			finally
			{
				NextSequenceNumber();
			}
		}

		public int Ttl { get; set; }
		public ushort Identifier { get; set; }
		public ushort SequenceNumber { get; set; }	
	}
}
