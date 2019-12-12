namespace FtpDirTree
{
	partial class Form1
	{
		/// <summary>
		/// Required designer variable.
		/// </summary>
		private System.ComponentModel.IContainer components = null;

		/// <summary>
		/// Clean up any resources being used.
		/// </summary>
		/// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
		protected override void Dispose(bool disposing)
		{
			if (disposing && (components != null))
			{
				components.Dispose();
			}
			base.Dispose(disposing);
		}

		#region Windows Form Designer generated code

		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
			this.lblHost = new System.Windows.Forms.Label();
			this.lblUser = new System.Windows.Forms.Label();
			this.lblRootDir = new System.Windows.Forms.Label();
			this.txtHost = new System.Windows.Forms.TextBox();
			this.txtUser = new System.Windows.Forms.TextBox();
			this.txtRootDir = new System.Windows.Forms.TextBox();
			this.lblPort = new System.Windows.Forms.Label();
			this.lblPassword = new System.Windows.Forms.Label();
			this.txtPort = new System.Windows.Forms.TextBox();
			this.txtPassword = new System.Windows.Forms.TextBox();
			this.btnClick = new System.Windows.Forms.Button();
			this.txtGetDirTree = new System.Windows.Forms.TextBox();
			this.ftp1 = new CleverComponents.InetSuite.Ftp();
			((System.ComponentModel.ISupportInitialize)(this.ftp1)).BeginInit();
			this.SuspendLayout();
			// 
			// lblHost
			// 
			this.lblHost.AutoSize = true;
			this.lblHost.Location = new System.Drawing.Point(21, 19);
			this.lblHost.Name = "lblHost";
			this.lblHost.Size = new System.Drawing.Size(37, 17);
			this.lblHost.TabIndex = 0;
			this.lblHost.Text = "Host";
			// 
			// lblUser
			// 
			this.lblUser.AutoSize = true;
			this.lblUser.Location = new System.Drawing.Point(21, 56);
			this.lblUser.Name = "lblUser";
			this.lblUser.Size = new System.Drawing.Size(38, 17);
			this.lblUser.TabIndex = 1;
			this.lblUser.Text = "User";
			// 
			// lblRootDir
			// 
			this.lblRootDir.AutoSize = true;
			this.lblRootDir.Location = new System.Drawing.Point(21, 92);
			this.lblRootDir.Name = "lblRootDir";
			this.lblRootDir.Size = new System.Drawing.Size(60, 17);
			this.lblRootDir.TabIndex = 2;
			this.lblRootDir.Text = "Root Dir";
			// 
			// txtHost
			// 
			this.txtHost.Location = new System.Drawing.Point(87, 16);
			this.txtHost.Name = "txtHost";
			this.txtHost.Size = new System.Drawing.Size(259, 22);
			this.txtHost.TabIndex = 1;
			this.txtHost.Text = "localhost";
			// 
			// txtUser
			// 
			this.txtUser.Location = new System.Drawing.Point(87, 53);
			this.txtUser.Name = "txtUser";
			this.txtUser.Size = new System.Drawing.Size(133, 22);
			this.txtUser.TabIndex = 3;
			this.txtUser.Text = "CleverTester";
			// 
			// txtRootDir
			// 
			this.txtRootDir.Location = new System.Drawing.Point(87, 89);
			this.txtRootDir.Name = "txtRootDir";
			this.txtRootDir.Size = new System.Drawing.Size(259, 22);
			this.txtRootDir.TabIndex = 5;
			this.txtRootDir.Text = "/";
			// 
			// lblPort
			// 
			this.lblPort.AutoSize = true;
			this.lblPort.Location = new System.Drawing.Point(385, 19);
			this.lblPort.Name = "lblPort";
			this.lblPort.Size = new System.Drawing.Size(34, 17);
			this.lblPort.TabIndex = 6;
			this.lblPort.Text = "Port";
			// 
			// lblPassword
			// 
			this.lblPassword.AutoSize = true;
			this.lblPassword.Location = new System.Drawing.Point(385, 56);
			this.lblPassword.Name = "lblPassword";
			this.lblPassword.Size = new System.Drawing.Size(69, 17);
			this.lblPassword.TabIndex = 7;
			this.lblPassword.Text = "Password";
			// 
			// txtPort
			// 
			this.txtPort.Location = new System.Drawing.Point(460, 16);
			this.txtPort.Name = "txtPort";
			this.txtPort.Size = new System.Drawing.Size(133, 22);
			this.txtPort.TabIndex = 2;
			this.txtPort.Text = "21";
			// 
			// txtPassword
			// 
			this.txtPassword.Location = new System.Drawing.Point(460, 53);
			this.txtPassword.Name = "txtPassword";
			this.txtPassword.PasswordChar = '*';
			this.txtPassword.Size = new System.Drawing.Size(133, 22);
			this.txtPassword.TabIndex = 4;
			this.txtPassword.Text = "clevertester";
			// 
			// btnClick
			// 
			this.btnClick.Location = new System.Drawing.Point(460, 107);
			this.btnClick.Name = "btnClick";
			this.btnClick.Size = new System.Drawing.Size(133, 39);
			this.btnClick.TabIndex = 6;
			this.btnClick.Text = "Get Dir Tree";
			this.btnClick.UseVisualStyleBackColor = true;
			this.btnClick.Click += new System.EventHandler(this.btnClick_Click);
			// 
			// txtGetDirTree
			// 
			this.txtGetDirTree.Location = new System.Drawing.Point(12, 167);
			this.txtGetDirTree.Multiline = true;
			this.txtGetDirTree.Name = "txtGetDirTree";
			this.txtGetDirTree.ReadOnly = true;
			this.txtGetDirTree.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
			this.txtGetDirTree.Size = new System.Drawing.Size(581, 246);
			this.txtGetDirTree.TabIndex = 7;
			this.txtGetDirTree.WordWrap = false;
			// 
			// ftp1
			// 
			this.ftp1.DirectoryListing += new CleverComponents.InetSuite.DirectoryListingEventHandler(this.ftp1_DirectoryListing);
			// 
			// Form1
			// 
			this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			this.ClientSize = new System.Drawing.Size(605, 425);
			this.Controls.Add(this.txtGetDirTree);
			this.Controls.Add(this.btnClick);
			this.Controls.Add(this.txtPassword);
			this.Controls.Add(this.txtPort);
			this.Controls.Add(this.lblPassword);
			this.Controls.Add(this.lblPort);
			this.Controls.Add(this.txtRootDir);
			this.Controls.Add(this.txtUser);
			this.Controls.Add(this.txtHost);
			this.Controls.Add(this.lblRootDir);
			this.Controls.Add(this.lblUser);
			this.Controls.Add(this.lblHost);
			this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedToolWindow;
			this.Name = "Form1";
			this.Text = "Get FTP Directory Tree";
			((System.ComponentModel.ISupportInitialize)(this.ftp1)).EndInit();
			this.ResumeLayout(false);
			this.PerformLayout();

		}

		#endregion

		private System.Windows.Forms.Label lblHost;
		private System.Windows.Forms.Label lblUser;
		private System.Windows.Forms.Label lblRootDir;
		private System.Windows.Forms.TextBox txtHost;
		private System.Windows.Forms.TextBox txtUser;
		private System.Windows.Forms.TextBox txtRootDir;
		private System.Windows.Forms.Label lblPort;
		private System.Windows.Forms.Label lblPassword;
		private System.Windows.Forms.TextBox txtPort;
		private System.Windows.Forms.TextBox txtPassword;
		private System.Windows.Forms.Button btnClick;
		private System.Windows.Forms.TextBox txtGetDirTree;
		private CleverComponents.InetSuite.Ftp ftp1;
	}
}

