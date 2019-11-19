using System;

namespace ConsoleApp1
{
	class Program
	{
		static void Main(string[] args)
		{
			try
			{
				var s = ImapUtf7Encoder.Decode("Test &ANw-bung Stra&AN8-e");
				System.Diagnostics.Debug.Assert(s == "Test Übung Straße");

				s = ImapUtf7Encoder.Decode("[Gmail]/&BBIEMAQ2BD0EPgQ1-");
				System.Diagnostics.Debug.Assert(s == "[Gmail]/Важное");

				s = ImapUtf7Encoder.Decode("[Gmail]/&BB4EQgQ,BEAEMAQyBDsENQQ9BD0ESwQ1-");
				System.Diagnostics.Debug.Assert(s == "[Gmail]/Отправленные");

				s = ImapUtf7Encoder.Decode("Test-&A5EDwAOsA70DxAO3A8MDtw-");
				System.Diagnostics.Debug.Assert(s == "Test-Απάντηση");

				s = ImapUtf7Encoder.Decode("&A5EDwAOsA70DxAO3A8MDtw-");
				System.Diagnostics.Debug.Assert(s == "Απάντηση");

				s = ImapUtf7Encoder.Decode("Test &-");
				System.Diagnostics.Debug.Assert(s == "Test &");

				s = ImapUtf7Encoder.Decode("&-Test");
				System.Diagnostics.Debug.Assert(s == "&Test");

				s = ImapUtf7Encoder.Decode("&-Test&-");
				System.Diagnostics.Debug.Assert(s == "&Test&");

				s = ImapUtf7Encoder.Decode("&-");
				System.Diagnostics.Debug.Assert(s == "&");

				s = ImapUtf7Encoder.Decode("&-&-");
				System.Diagnostics.Debug.Assert(s == "&&");

				s = ImapUtf7Encoder.Decode("&-&-s");
				System.Diagnostics.Debug.Assert(s == "&&s");

				s = ImapUtf7Encoder.Decode("Test-");
				System.Diagnostics.Debug.Assert(s == "Test-");

				s = ImapUtf7Encoder.Decode("Test-After");
				System.Diagnostics.Debug.Assert(s == "Test-After");

				s = ImapUtf7Encoder.Decode("Test After");
				System.Diagnostics.Debug.Assert(s == "Test After");

				s = ImapUtf7Encoder.Decode("-Test After");
				System.Diagnostics.Debug.Assert(s == "-Test After");

				s = ImapUtf7Encoder.Decode("-&-Test After");
				System.Diagnostics.Debug.Assert(s == "-&Test After");

				s = ImapUtf7Encoder.Decode("Test After-&-");
				System.Diagnostics.Debug.Assert(s == "Test After-&");

				s = ImapUtf7Encoder.Decode("");
				System.Diagnostics.Debug.Assert(s == "");

				Console.WriteLine("Done.");
			}
			catch (Exception ex)
			{
				Console.WriteLine(ex.Message);
			}

			Console.WriteLine("Press Enter to Exit.");
			Console.ReadLine();
		}
	}
}
