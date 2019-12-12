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

namespace FtpDirTree
{
	public partial class Form1 : Form
	{
		private string m_level;

		public Form1()
		{
			InitializeComponent();
		}
		private void GetRecursiveList(string dirName, string level)
		{
			string old = m_level;
			try
			{
				m_level += level;
				ftp1.ChangeCurrentDir(dirName);
				ftp1.GetDirectoryListing();
				ftp1.ChangeToParentDir();
			}
			finally
			{
				m_level = old;
			}
		}
		private void ftp1_DirectoryListing(object sender, DirectoryListingEventArgs e)
		{
			txtGetDirTree.AppendText(m_level + e.FileInfo.FileName + "\r\n");
			if (e.FileInfo.IsDirectory)
			{
				GetRecursiveList(e.FileInfo.FileName, "\t");
			}
		}
		private void btnClick_Click(object sender, EventArgs e)
		{
			txtGetDirTree.Text = "";

			ftp1.Server = txtHost.Text;
			ftp1.Port = Convert.ToInt32(txtPort.Text);
			ftp1.UserName = txtUser.Text;
			ftp1.Password = txtPassword.Text;

			ftp1.Open();
			try
			{
				m_level = "";
				GetRecursiveList(txtRootDir.Text, "");
			}
			finally
			{					
				ftp1.Close();
				MessageBox.Show("Done");
			}
		}
	}
}
