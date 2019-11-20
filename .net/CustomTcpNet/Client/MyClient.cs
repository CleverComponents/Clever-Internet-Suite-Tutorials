using System;
using System.Text;
using CleverComponents.InetSuite;

namespace Client {
	public class MyClient : TcpCommandClient {
		public const int OkResponse = 100;

		protected override int GetDefaultPort() {
			return 2110;
		}

		protected override int GetResponseCode(string response) {
			if (StringUtils.IsEmpty(response))
				return SOCKET_WAIT_RESPONSE;

			if (response.Trim() == ".") {
				return SOCKET_DOT_RESPONSE;
			}
			else {
				return StringUtils.StrToIntDef(response.Trim(), SOCKET_WAIT_RESPONSE);
			}
		}

		protected override void CloseSession() {
			SendCommandSync("CLOSE", new int[] { OkResponse });
		}

		protected override void OpenSession() {
			WaitResponse(new int[] { OkResponse });
		}

		public void Login() {
			SendCommandSync("LOGIN {0}", new int[] { OkResponse }, new object[] { UserName });
		}

		public string[] GetLines() {
			SendCommandSync("GETLINES", new int[] { OkResponse });
			WaitMultipleLines(0);
			return Response.ToArray();
		}

		public void SendLines(string[] lines) {
			SendCommandSync("SENDLINES", new int[] { OkResponse });
			SendMultipleLines(lines, ".");
			WaitResponse(new int[] { OkResponse });
		}
	}
}
