using System;
using System.Text;
using System.Windows.Forms;
using CleverComponents.InetSuite;

namespace ForwardReply
{
	public partial class Form1 : Form
	{
		public Form1()
		{
			InitializeComponent();
		}

		private const string BlockQuoteStart = "<BLOCKQUOTE "+ "style= " + "PADDING-RIGHT: 0px; PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #000000 2px solid; MARGIN-RIGHT: 0px >";
		private const string BlockQuoteEnd = "</BLOCKQUOTE>";
		private const string ReplyText = "Reply follows here";
		private StringBuilder textLines = new StringBuilder();

		private string[] MakeTextReply(TextBody body)
		{
			StringCollectionEx newTextLines = new StringCollectionEx();

			newTextLines.Add(ReplyText);
			newTextLines.Add("");
			newTextLines.Add("");

			foreach (string s in body.Strings)
			{
				newTextLines.Add("> " + s);
			}

			return newTextLines.ToArray();
		}
		private string[] MakeHtmlReply(TextBody body)
		{
			string reply = "<DIV>" + ReplyText + "</DIV";
			string s = StringUtils.GetStringsAsString(body.Strings);
			string text2insert = reply + BlockQuoteStart;

			htmlParser.Parse(s);

			HtmlTag tag = htmlParser.Tags.TagByName("BODY");
			if (tag == null)
			{
				s = text2insert + s + BlockQuoteEnd;
			}
			else
			{
				s = s.Insert(tag.InnerTextPos, text2insert);

				HtmlTag tagEnd = htmlParser.Tags.TagByName("BODY", tag.NextTag);
				s = s.Insert(tagEnd.InnerTextPos + text2insert.Length, BlockQuoteEnd);
			}
			return StringUtils.GetStringArray(s);
		}

		private string GetMessageText(string[] AHtml)
		{
			textLines.Clear();
			htmlTextParser.Parse(AHtml);
			return textLines.ToString();
		}

		private bool SendEmailMessage(string AToAddress, string ASubject)
		{
			using (MessageForm dlg = new MessageForm()) 
			{
				dlg.edtTo.Text = AToAddress;
				dlg.edtSubject.Text = ASubject;

				if (mailMessage.Html != null)
				{
					dlg.memText.Lines =	MakeHtmlReply(mailMessage.Html);
					
				}
				else if (mailMessage.Text != null)
				{
					dlg.memText.Lines = MakeTextReply(mailMessage.Text);
				}

				var result = (dlg.ShowDialog() == DialogResult.OK);

				if (result)
				{

					if (mailMessage.Html != null)
					{
						string text = "";
						if (mailMessage.Text != null)
						{
							text = GetMessageText(dlg.memText.Lines);
						}
						mailMessage.BuildMessage(text, dlg.memText.Text);
					}
					else
					{
						mailMessage.BuildMessage(dlg.memText.Text, "");
					}

					mailMessage.From.FullAddress = dlg.edtFrom.Text;
					mailMessage.ToList.EmailAddresses = dlg.edtTo.Text;
					mailMessage.Subject = dlg.edtSubject.Text;

					smtp.Server = edtStmpServer.Text;
					smtp.Port = Convert.ToInt32(edtStpmPort.Text);
					smtp.UseTls = ClientTlsMode.Automatic;
					smtp.UserName = edtUser.Text;
					smtp.Password = edtPassword.Text;
					smtp.Open();

					try
					{
						smtp.Send(mailMessage);
					}
					finally
					{
						smtp.Close();

					}
				}
				return true;
			}
		}

		private void btnReceive_Click(object sender, EventArgs e)
		{
			pop3.Server = edtPop3Server.Text;
			pop3.UseTls = ClientTlsMode.Automatic;
			pop3.Port = Convert.ToInt32(edtPop3Port.Text);
			pop3.UserName = edtUser.Text;
			pop3.Password = edtPassword.Text;
			pop3.Open();

			listBox1.Items.Clear();

			try
			{
				for (int i = 1; i <= pop3.MessageCount; i++)
				{
					pop3.RetrieveHeader(i, mailMessage);

					listBox1.Items.Add(mailMessage.Subject + ", " + mailMessage.From.FullAddress);
				}
			}
			finally
			{
				pop3.Close();
			}
		}

		private void btnReply_Click(object sender, EventArgs e)
		{
			if (listBox1.SelectedIndex < 0)
			{
				MessageBox.Show("No messages selected");
				return;
			}

			pop3.Server = edtPop3Server.Text;
			pop3.UseTls = ClientTlsMode.Automatic;
			pop3.Port = Convert.ToInt32(edtPop3Port.Text);
			pop3.UserName = edtUser.Text;
			pop3.Password = edtPassword.Text;
			pop3.Open();


			try
			{
				pop3.Retrieve(listBox1.SelectedIndex + 1, mailMessage);
			}
			finally
			{
				pop3.Close();
			}
			

			if (SendEmailMessage(mailMessage.From.FullAddress, "Re: " + mailMessage.Subject))
			{
				MessageBox.Show("Message was replied");
			}
		}

		private void btnForward_Click(object sender, EventArgs e)
		{
			if (listBox1.SelectedIndex < 0)
			{
				MessageBox.Show("No messages selected");
				return;
			}

			pop3.Server = edtPop3Server.Text;
			pop3.UseTls = ClientTlsMode.Automatic;
			pop3.Port = Convert.ToInt32(edtPop3Port.Text);
			pop3.UserName = edtUser.Text;
			pop3.Password = edtPassword.Text;
			pop3.Open();

			try
			{
				pop3.Retrieve(listBox1.SelectedIndex + 1, mailMessage);
			}
			finally
			{
				pop3.Close();
			}

			if (SendEmailMessage("", "Fw: " + mailMessage.Subject))
			{
				MessageBox.Show("Message was forwarded");
				return;
			}
		}

		private void htmlTextParser_ParseTag(object sender, ParseTagEventArgs e)
		{
			if (e.Tag.IsText)
			{
				textLines.Append(e.Tag.Text).ToString();
			}
		}
	}
}

