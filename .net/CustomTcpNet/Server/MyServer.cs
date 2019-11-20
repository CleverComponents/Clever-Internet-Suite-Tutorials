using System;
using System.Text;
using CleverComponents.InetSuite;

namespace Server {
	public delegate void MyCommandHandler(CommandConnection connection, TcpCommandParams parameters);

	public class MyCommandInfo : TcpCommandInfo {
		MyCommandHandler handler;

		public MyCommandInfo(string name, MyCommandHandler handler) : base(name) {
			this.handler = handler;
		}

		public override void Execute(CommandConnection connection, TcpCommandParams parameters) {
			handler((CommandConnection)connection, parameters);
		}
	}

	public class MyLinesSentEventArgs : EventArgs {
		CommandConnection connection;
		string[] lines;

		public MyLinesSentEventArgs(CommandConnection connection, string[] lines) : base() {
			this.connection = connection;
			this.lines = lines;
		}

		public CommandConnection Connection {
			get { return connection; }
		}

		public string[] Lines {
			get { return lines; }
		}
	}

	public delegate void MyLinesSentEventHandler(object sender, MyLinesSentEventArgs e);

	public class MyServer : TcpCommandServer {
		static readonly object linesSent = new object();

		void HandleLOGIN(CommandConnection connection, TcpCommandParams parameters) {
			SendResponse(connection, parameters.Command, "100");
		}

		void HandleCLOSE(CommandConnection connection, TcpCommandParams parameters) {
			try {
				SendResponseAndClose(connection, parameters.Command, "100");
			}
			catch (SocketError) { }
		}

		void HandleGETLINES(CommandConnection connection, TcpCommandParams parameters) {
			SendResponse(connection, parameters.Command, "100");

			StringCollectionEx lines = new StringCollectionEx();
			lines.Add("This is a first line of data");
			lines.Add("This is a second line of data");
			lines.Add("This is a third line of data");

			SendMultipleLines(connection, lines, ".");
		}

		void HandleSENDLINES(CommandConnection connection, TcpCommandParams parameters) {
			AcceptMultipleLines(connection, new MyCommandInfo(parameters.Command, new MyCommandHandler(HandleSENDLINESData)));
			SendResponse(connection, parameters.Command, "100");
		}

		void HandleSENDLINESData(CommandConnection connection, TcpCommandParams parameters) {
			AcceptCommands(connection);
			OnLinesSent(new MyLinesSentEventArgs(connection, parameters.RawData.ToArray()));
			SendResponse(connection, "SENDLINES", "100");
		}

		void HandleNullCommand(CommandConnection connection, TcpCommandParams parameters) {
			throw new TcpCommandServerError(parameters.Command, "101", -1, false);
		}

		protected override UserConnection CreateDefaultConnection() {
			return new CommandConnection();
		}

		protected override void OnConnectionAccepted(ConnectionAcceptedEventArgs e) {
			base.OnConnectionAccepted(e);
			SendResponse((CommandConnection)e.Connection, String.Empty, "100");
		}

		protected override void GetCommands() {
			Commands.Add(new MyCommandInfo("LOGIN", new MyCommandHandler(HandleLOGIN)));
			Commands.Add(new MyCommandInfo("CLOSE", new MyCommandHandler(HandleCLOSE)));
			Commands.Add(new MyCommandInfo("GETLINES", new MyCommandHandler(HandleGETLINES)));
			Commands.Add(new MyCommandInfo("SENDLINES", new MyCommandHandler(HandleSENDLINES)));
		}

		protected override void ProcessUnhandledError(CommandConnection connection,
			TcpCommandParams parameters, Exception ex) {
			SendResponse(connection, parameters.Command, "102");
		}

		protected override TcpCommandInfo GetNullCommand(TcpCommandParams parameters) {
			return new MyCommandInfo(parameters.Command, new MyCommandHandler(HandleNullCommand));
		}

		protected virtual void OnLinesSent(MyLinesSentEventArgs e) {
			MyLinesSentEventHandler handler = (MyLinesSentEventHandler)Events[linesSent];
			if (handler != null) {
				handler(this, e);
			}
		}

		public event MyLinesSentEventHandler LinesSent {
			add {
				Events.AddHandler(linesSent, value);
			}
			remove {
				Events.RemoveHandler(linesSent, value);
			}
		}
	}
}
