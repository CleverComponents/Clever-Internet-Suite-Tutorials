using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;
using CleverComponents.InetSuite;

namespace FramedServer
{
    public class FramedConnection : UserConnection
    {
        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                Frame?.Close();
                Frame = null;
            }
            base.Dispose(disposing);
        }

        public FramedConnection() : base()
        {
            Frame = new MemoryStream();
        }

        public byte[] ReceiveFramedData()
        {
            //read the frame
            ReadData(Frame);

            if (!IsFrameData)
            {
                //extract the frame size
                if (Frame.Length >= 4)
                {
                    Frame.Position = 0;
                    byte[] buffer = new byte[4];
                    Frame.Read(buffer, 0, buffer.Length);
                    int index = 0;
                    Size = Utils.ByteArrayReadDWord(buffer, ref index);
                    IsFrameData = true;
                }
            }

            //extract and return data
            if (Size <= Frame.Length - 4)
            {
                Frame.Position = 4;
                byte[] buffer = new byte[Size];
                Frame.Read(buffer, 0, (int)Size);
                Frame.SetLength(0);
                IsFrameData = false;
                Size = 0;
                return buffer;
            }

            return null;
        }

        public void SendFramedData(byte[] data)
        {
            if (data == null) return;

            using (var frame = new MemoryStream())
            {
                //write the frame size
                byte[] buffer = new byte[4];
                int index = 0;
                Utils.ByteArrayWriteDWord((uint)data.Length, buffer, ref index);
                frame.Write(buffer, 0, buffer.Length);

                //write data
                frame.Write(data, 0, data.Length);

                //send frame
                frame.Position = 0;
                WriteData(frame);
            }
        }


        public Stream Frame { get; private set; }

        public bool IsFrameData { get; private set; }

        public uint Size { get; private set; }
    }

    public delegate void ConnectionFramedDataEventHandler(object sender, ConnectionFramedDataEventArgs e);

    public class ConnectionFramedDataEventArgs : ConnectionEventArgs
    {
        public ConnectionFramedDataEventArgs(UserConnection connection, byte[] data) : base(connection)
        {
            Data = data;
        }

        public byte[] Data { get; }

        new public FramedConnection Connection
        {
            get { return (FramedConnection)base.Connection; }
        }
    }

    public class FramedServer : TcpServer
    {
        static readonly object frameReceived = new object();

        protected override UserConnection CreateDefaultConnection()
        {
            return new FramedConnection();
        }

        protected override void ReadConnection(UserConnection connection)
        {
            try
            {
                byte[] data = ((FramedConnection)connection).ReceiveFramedData();
                if (data != null)
                {
                    OnFrameReceived(new ConnectionFramedDataEventArgs(connection, data));
                }
            }
            finally
            {
                BeginRead(connection);
            }
        }

        protected internal virtual void OnFrameReceived(ConnectionFramedDataEventArgs e)
        {
            ((ConnectionFramedDataEventHandler)Events[frameReceived])?.Invoke(this, e);
        }

        public event ConnectionFramedDataEventHandler FrameReceived
        {
            add
            {
                Events.AddHandler(frameReceived, value);
            }
            remove
            {
                Events.RemoveHandler(frameReceived, value);
            }
        }
    }
}
