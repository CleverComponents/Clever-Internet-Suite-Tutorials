using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using CleverComponents.InetSuite;

namespace ParseTableCellValues
{
	public partial class Form1 : Form
	{
		public Form1()
		{
			InitializeComponent();
		}

		private string GetCellText(HtmlTableCell tableCell)
		{
			string result = "";
			foreach (HtmlTag tag in tableCell.Tags)
			{
				if (tag.IsText)
				{
					result += tag.Text;
				}
			}

			return result.Trim();
		}
		private void button1_Click(object sender, EventArgs e)
		{
			htmlParser1.ParseMethod = ParseMethod.All;
			htmlParser1.Parse(textBox1.Lines);

			textBox2.Clear();

			for (int i = 0; i < htmlParser1.Tables.Count; i++)
			{
				textBox2.AppendText(String.Format("table {0}\r\n", i));

				HtmlTable table = htmlParser1.Tables[i];
				for (int j = 0; j < table.Rows.Count; j++)
				{
					textBox2.AppendText(String.Format("row {0}\r\n", j));
					HtmlTableRow row = table.Rows[j];

					for (int k = 0; k < row.Cells.Count; k++)
					{
						HtmlTableCell cell = row.Cells[k];
						textBox2.AppendText(GetCellText(cell) + "\r\n");
					}
				}
			}
		}
	}
}
