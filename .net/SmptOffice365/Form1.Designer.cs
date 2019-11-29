namespace SmptOffice365
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
			this.lbServer = new System.Windows.Forms.Label();
			this.lbUser = new System.Windows.Forms.Label();
			this.lbTo = new System.Windows.Forms.Label();
			this.lbSubject = new System.Windows.Forms.Label();
			this.lbPassword = new System.Windows.Forms.Label();
			this.tbServer = new System.Windows.Forms.TextBox();
			this.tbPort = new System.Windows.Forms.TextBox();
			this.tbUser = new System.Windows.Forms.TextBox();
			this.tbTo = new System.Windows.Forms.TextBox();
			this.tbSubject = new System.Windows.Forms.TextBox();
			this.tbPassword = new System.Windows.Forms.TextBox();
			this.tbBild = new System.Windows.Forms.TextBox();
			this.button1 = new System.Windows.Forms.Button();
			this.smtp1 = new CleverComponents.InetSuite.Smtp();
			this.mailMessage1 = new CleverComponents.InetSuite.MailMessage();
			this.lbPort = new System.Windows.Forms.Label();
			((System.ComponentModel.ISupportInitialize)(this.smtp1)).BeginInit();
			((System.ComponentModel.ISupportInitialize)(this.mailMessage1)).BeginInit();
			this.SuspendLayout();
			// 
			// lbServer
			// 
			this.lbServer.AutoSize = true;
			this.lbServer.Location = new System.Drawing.Point(10, 15);
			this.lbServer.Name = "lbServer";
			this.lbServer.Size = new System.Drawing.Size(50, 17);
			this.lbServer.TabIndex = 0;
			this.lbServer.Text = "Server";
			// 
			// lbUser
			// 
			this.lbUser.AutoSize = true;
			this.lbUser.Location = new System.Drawing.Point(10, 69);
			this.lbUser.Name = "lbUser";
			this.lbUser.Size = new System.Drawing.Size(38, 17);
			this.lbUser.TabIndex = 2;
			this.lbUser.Text = "User";
			// 
			// lbTo
			// 
			this.lbTo.AutoSize = true;
			this.lbTo.Location = new System.Drawing.Point(10, 113);
			this.lbTo.Name = "lbTo";
			this.lbTo.Size = new System.Drawing.Size(25, 17);
			this.lbTo.TabIndex = 3;
			this.lbTo.Text = "To";
			// 
			// lbSubject
			// 
			this.lbSubject.AutoSize = true;
			this.lbSubject.Location = new System.Drawing.Point(10, 141);
			this.lbSubject.Name = "lbSubject";
			this.lbSubject.Size = new System.Drawing.Size(55, 17);
			this.lbSubject.TabIndex = 4;
			this.lbSubject.Text = "Subject";
			// 
			// lbPassword
			// 
			this.lbPassword.AutoSize = true;
			this.lbPassword.Location = new System.Drawing.Point(230, 71);
			this.lbPassword.Name = "lbPassword";
			this.lbPassword.Size = new System.Drawing.Size(69, 17);
			this.lbPassword.TabIndex = 5;
			this.lbPassword.Text = "Password";
			// 
			// tbServer
			// 
			this.tbServer.Location = new System.Drawing.Point(73, 12);
			this.tbServer.Name = "tbServer";
			this.tbServer.Size = new System.Drawing.Size(377, 22);
			this.tbServer.TabIndex = 6;
			this.tbServer.Text = "smtp.office365.com";
			// 
			// tbPort
			// 
			this.tbPort.Location = new System.Drawing.Point(73, 40);
			this.tbPort.Name = "tbPort";
			this.tbPort.Size = new System.Drawing.Size(100, 22);
			this.tbPort.TabIndex = 7;
			this.tbPort.Text = "587";
			// 
			// tbUser
			// 
			this.tbUser.Location = new System.Drawing.Point(73, 68);
			this.tbUser.Name = "tbUser";
			this.tbUser.Size = new System.Drawing.Size(145, 22);
			this.tbUser.TabIndex = 8;
			// 
			// tbTo
			// 
			this.tbTo.Location = new System.Drawing.Point(73, 110);
			this.tbTo.Name = "tbTo";
			this.tbTo.Size = new System.Drawing.Size(377, 22);
			this.tbTo.TabIndex = 10;
			this.tbTo.Text = "recipient@sample.com";
			// 
			// tbSubject
			// 
			this.tbSubject.Location = new System.Drawing.Point(73, 138);
			this.tbSubject.Name = "tbSubject";
			this.tbSubject.Size = new System.Drawing.Size(377, 22);
			this.tbSubject.TabIndex = 11;
			this.tbSubject.Text = "Sample message";
			// 
			// tbPassword
			// 
			this.tbPassword.Location = new System.Drawing.Point(305, 69);
			this.tbPassword.Name = "tbPassword";
			this.tbPassword.PasswordChar = '*';
			this.tbPassword.Size = new System.Drawing.Size(145, 22);
			this.tbPassword.TabIndex = 9;
			// 
			// tbBild
			// 
			this.tbBild.Location = new System.Drawing.Point(14, 166);
			this.tbBild.Multiline = true;
			this.tbBild.Name = "tbBild";
			this.tbBild.Size = new System.Drawing.Size(437, 213);
			this.tbBild.TabIndex = 12;
			this.tbBild.Text = "This is a sample email";
			// 
			// button1
			// 
			this.button1.Location = new System.Drawing.Point(306, 396);
			this.button1.Name = "button1";
			this.button1.Size = new System.Drawing.Size(145, 32);
			this.button1.TabIndex = 13;
			this.button1.Text = "Send";
			this.button1.UseVisualStyleBackColor = true;
			this.button1.Click += new System.EventHandler(this.button1_Click);
			// 
			// smtp1
			// 
			this.smtp1.VerifyServer += new CleverComponents.InetSuite.VerifyPeerEventHandler(this.smtp1_VerifyServer);
			// 
			// mailMessage1
			// 
			this.mailMessage1.Date = new System.DateTime(2019, 11, 28, 18, 25, 43, 583);
			this.mailMessage1.From.Email = "";
			this.mailMessage1.From.Name = "";
			// 
			// lbPort
			// 
			this.lbPort.AutoSize = true;
			this.lbPort.Location = new System.Drawing.Point(10, 43);
			this.lbPort.Name = "lbPort";
			this.lbPort.Size = new System.Drawing.Size(34, 17);
			this.lbPort.TabIndex = 1;
			this.lbPort.Text = "Port";
			// 
			// Form1
			// 
			this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			this.ClientSize = new System.Drawing.Size(467, 443);
			this.Controls.Add(this.button1);
			this.Controls.Add(this.tbBild);
			this.Controls.Add(this.tbPassword);
			this.Controls.Add(this.tbSubject);
			this.Controls.Add(this.tbTo);
			this.Controls.Add(this.tbUser);
			this.Controls.Add(this.tbPort);
			this.Controls.Add(this.tbServer);
			this.Controls.Add(this.lbPassword);
			this.Controls.Add(this.lbSubject);
			this.Controls.Add(this.lbTo);
			this.Controls.Add(this.lbUser);
			this.Controls.Add(this.lbPort);
			this.Controls.Add(this.lbServer);
			this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedToolWindow;
			this.Name = "Form1";
			this.Text = "SMTP Client with SSL / TLS support";
			((System.ComponentModel.ISupportInitialize)(this.smtp1)).EndInit();
			((System.ComponentModel.ISupportInitialize)(this.mailMessage1)).EndInit();
			this.ResumeLayout(false);
			this.PerformLayout();

		}

		#endregion

		private System.Windows.Forms.Label lbServer;
		private System.Windows.Forms.Label lbUser;
		private System.Windows.Forms.Label lbTo;
		private System.Windows.Forms.Label lbSubject;
		private System.Windows.Forms.Label lbPassword;
		private System.Windows.Forms.TextBox tbServer;
		private System.Windows.Forms.TextBox tbPort;
		private System.Windows.Forms.TextBox tbUser;
		private System.Windows.Forms.TextBox tbTo;
		private System.Windows.Forms.TextBox tbSubject;
		private System.Windows.Forms.TextBox tbPassword;
		private System.Windows.Forms.TextBox tbBild;
		private System.Windows.Forms.Button button1;
		private CleverComponents.InetSuite.Smtp smtp1;
		private CleverComponents.InetSuite.MailMessage mailMessage1;
		private System.Windows.Forms.Label lbPort;
	}
}

