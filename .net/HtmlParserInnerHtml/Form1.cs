using System;
using System.ComponentModel;
using System.Data;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using CleverComponents.InetSuite;

namespace HtmlParserInnerHtml
{
	public partial class Form1 : Form
	{
		public Form1()
		{
			InitializeComponent();
		}
		private string GetTagSource(HtmlTag tag) 
		{
			string result;
			if (tag.IsClosingTag)
			{
				result = "</" + tag.Name + ">";
			}
			else
			if(tag.IsText)
			{
				result = tag.TagSource;
			}
			else
			{
				result = "<" + tag.TagSource + ">";
			}
			return result;
		}

		private string GetInnerHtml(HtmlTag owner, HtmlTag tag)
		{
			string result;
			if (tag.NextTag != null && tag.NextTag.Owner != owner)
			{
				if (owner != tag.Owner)
				{
					result = GetTagSource(tag);
				}
				else
				{
					result = "";
				}

				result += GetInnerHtml(owner, tag.NextTag);
			}
			else
			{
				result = GetTagSource(tag);
			}
			return result;
		}
		private void button1_Click(object sender, EventArgs e)
		{
			textBox2.Clear();

			htmlParser1.IncludeClosingTags = true;
			htmlParser1.ParseMethod = ParseMethod.All;
			htmlParser1.Parse(textBox1.Lines);

			for (int i = 0; i < htmlParser1.Tags.Count - 1; i++)
			{
				HtmlTag tag = htmlParser1.Tags[i];
				if (tag.Name == "div" &&  tag.Attributes.AttributeValue("class") == "tvRow tvFirst hasLabel tvFirst")
				{
					textBox2.Text += GetInnerHtml(tag.Owner, tag) + "\r\n";
				}
			}
		}
	}
}
