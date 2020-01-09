using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;

namespace FtpClient
{
	/// <summary>
	/// Summary description for fileDlg.
	/// </summary>
	public class FileExistsDialog : System.Windows.Forms.Form
	{
		private System.Windows.Forms.Label lblCaption;
		private System.Windows.Forms.Button btnReplace;
		private System.Windows.Forms.Button btnResume;
		private System.Windows.Forms.Button btnCancel;
		/// <summary>
		/// Required designer variable.
		/// </summary>
		private System.ComponentModel.Container components = null;

		public FileExistsDialog()
		{
			//
			// Required for Windows Form Designer support
			//
			InitializeComponent();

			//
			// TODO: Add any constructor code after InitializeComponent call
			//
		}

		/// <summary>
		/// Clean up any resources being used.
		/// </summary>
		protected override void Dispose( bool disposing )
		{
			if( disposing )
			{
				if(components != null)
				{
					components.Dispose();
				}
			}
			base.Dispose( disposing );
		}

		#region Windows Form Designer generated code
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
			this.lblCaption = new System.Windows.Forms.Label();
			this.btnReplace = new System.Windows.Forms.Button();
			this.btnResume = new System.Windows.Forms.Button();
			this.btnCancel = new System.Windows.Forms.Button();
			this.SuspendLayout();
			// 
			// lblCaption
			// 
			this.lblCaption.Location = new System.Drawing.Point(19, 18);
			this.lblCaption.Name = "lblCaption";
			this.lblCaption.Size = new System.Drawing.Size(384, 56);
			this.lblCaption.TabIndex = 0;
			this.lblCaption.Text = "label1";
			// 
			// btnReplace
			// 
			this.btnReplace.DialogResult = System.Windows.Forms.DialogResult.Yes;
			this.btnReplace.Location = new System.Drawing.Point(19, 83);
			this.btnReplace.Name = "btnReplace";
			this.btnReplace.Size = new System.Drawing.Size(90, 27);
			this.btnReplace.TabIndex = 1;
			this.btnReplace.Text = "Replace";
			// 
			// btnResume
			// 
			this.btnResume.DialogResult = System.Windows.Forms.DialogResult.No;
			this.btnResume.Location = new System.Drawing.Point(125, 83);
			this.btnResume.Name = "btnResume";
			this.btnResume.Size = new System.Drawing.Size(90, 27);
			this.btnResume.TabIndex = 2;
			this.btnResume.Text = "Resume";
			// 
			// btnCancel
			// 
			this.btnCancel.DialogResult = System.Windows.Forms.DialogResult.Cancel;
			this.btnCancel.Location = new System.Drawing.Point(317, 83);
			this.btnCancel.Name = "btnCancel";
			this.btnCancel.Size = new System.Drawing.Size(90, 27);
			this.btnCancel.TabIndex = 3;
			this.btnCancel.Text = "Cancel";
			// 
			// FileExistsDialog
			// 
			this.AutoScaleBaseSize = new System.Drawing.Size(6, 15);
			this.ClientSize = new System.Drawing.Size(434, 124);
			this.Controls.Add(this.btnCancel);
			this.Controls.Add(this.btnResume);
			this.Controls.Add(this.btnReplace);
			this.Controls.Add(this.lblCaption);
			this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
			this.Name = "FileExistsDialog";
			this.ShowInTaskbar = false;
			this.Text = "File Exists Dialog";
			this.ResumeLayout(false);

		}
		#endregion
		public static DialogResult ShowFileDialog(string fileName) {
			FileExistsDialog dlg = new FileExistsDialog();
			dlg.lblCaption.Text = string.Format("File already exists {0}", fileName);
			return dlg.ShowDialog();
		}
	}
}
