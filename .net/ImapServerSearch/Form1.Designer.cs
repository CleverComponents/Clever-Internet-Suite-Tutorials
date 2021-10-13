
namespace ImapServerSearch
{
	partial class MainForm
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
			CleverComponents.InetSuite.MailUserAccountItem mailUserAccountItem3 = new CleverComponents.InetSuite.MailUserAccountItem();
			this.pictureBox1 = new System.Windows.Forms.PictureBox();
			this.imap4Server1 = new CleverComponents.InetSuite.Imap4Server();
			this.imap4FileHandler1 = new CleverComponents.InetSuite.Imap4FileHandler();
			this.memLog = new System.Windows.Forms.TextBox();
			this.label5 = new System.Windows.Forms.Label();
			this.btnStop = new System.Windows.Forms.Button();
			this.btnStart = new System.Windows.Forms.Button();
			this.edtRootDir = new System.Windows.Forms.TextBox();
			this.label4 = new System.Windows.Forms.Label();
			this.edtPort = new System.Windows.Forms.TextBox();
			this.label3 = new System.Windows.Forms.Label();
			this.label2 = new System.Windows.Forms.Label();
			this.label1 = new System.Windows.Forms.Label();
			((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).BeginInit();
			this.SuspendLayout();
			// 
			// pictureBox1
			// 
			this.pictureBox1.Dock = System.Windows.Forms.DockStyle.Top;
			this.pictureBox1.Image = global::ImapServerSearch.Properties.Resources.background_net;
			this.pictureBox1.Location = new System.Drawing.Point(0, 0);
			this.pictureBox1.Name = "pictureBox1";
			this.pictureBox1.Size = new System.Drawing.Size(623, 78);
			this.pictureBox1.SizeMode = System.Windows.Forms.PictureBoxSizeMode.CenterImage;
			this.pictureBox1.TabIndex = 29;
			this.pictureBox1.TabStop = false;
			// 
			// imap4Server1
			// 
			mailUserAccountItem3.Password = "clevertester";
			mailUserAccountItem3.UserName = "CleverTester";
			this.imap4Server1.UserAccounts.AddRange(new CleverComponents.InetSuite.UserAccountItem[] {
            mailUserAccountItem3});
			this.imap4Server1.Authenticate += new CleverComponents.InetSuite.Imap4AuthenticateEventHandler(this.imap4Server1_Authenticate);
			this.imap4Server1.SearchMessage += new CleverComponents.InetSuite.Imap4SearchMessageEventHandler(this.imap4Server1_SearchMessage);
			this.imap4Server1.CommandReceived += new CleverComponents.InetSuite.TcpCommandEventHandler(this.imap4Server1_CommandReceived);
			this.imap4Server1.ResponseSent += new CleverComponents.InetSuite.TcpResponseEventHandler(this.imap4Server1_ResponseSent);
			this.imap4Server1.Started += new System.EventHandler(this.imap4Server1_Started);
			this.imap4Server1.Stopped += new System.EventHandler(this.imap4Server1_Stopped);
			this.imap4Server1.ConnectionAccepted += new CleverComponents.InetSuite.ConnectionAcceptedEventHandler(this.imap4Server1_ConnectionAccepted);
			this.imap4Server1.ConnectionClosed += new CleverComponents.InetSuite.ConnectionEventHandler(this.imap4Server1_ConnectionClosed);
			// 
			// imap4FileHandler1
			// 
			this.imap4FileHandler1.Server = this.imap4Server1;
			// 
			// memLog
			// 
			this.memLog.Location = new System.Drawing.Point(12, 273);
			this.memLog.Multiline = true;
			this.memLog.Name = "memLog";
			this.memLog.ReadOnly = true;
			this.memLog.ScrollBars = System.Windows.Forms.ScrollBars.Both;
			this.memLog.Size = new System.Drawing.Size(599, 167);
			this.memLog.TabIndex = 39;
			// 
			// label5
			// 
			this.label5.Location = new System.Drawing.Point(28, 249);
			this.label5.Name = "label5";
			this.label5.Size = new System.Drawing.Size(48, 23);
			this.label5.TabIndex = 38;
			this.label5.Text = "Log";
			// 
			// btnStop
			// 
			this.btnStop.Location = new System.Drawing.Point(188, 225);
			this.btnStop.Name = "btnStop";
			this.btnStop.Size = new System.Drawing.Size(75, 23);
			this.btnStop.TabIndex = 37;
			this.btnStop.Text = "Stop";
			this.btnStop.Click += new System.EventHandler(this.btnStop_Click);
			// 
			// btnStart
			// 
			this.btnStart.Location = new System.Drawing.Point(92, 225);
			this.btnStart.Name = "btnStart";
			this.btnStart.Size = new System.Drawing.Size(75, 23);
			this.btnStart.TabIndex = 36;
			this.btnStart.Text = "Start";
			this.btnStart.Click += new System.EventHandler(this.btnStart_Click);
			// 
			// edtRootDir
			// 
			this.edtRootDir.Location = new System.Drawing.Point(92, 193);
			this.edtRootDir.Name = "edtRootDir";
			this.edtRootDir.Size = new System.Drawing.Size(460, 20);
			this.edtRootDir.TabIndex = 35;
			this.edtRootDir.Text = "C:\\CleverMailBox\\";
			// 
			// label4
			// 
			this.label4.Location = new System.Drawing.Point(28, 193);
			this.label4.Name = "label4";
			this.label4.Size = new System.Drawing.Size(56, 23);
			this.label4.TabIndex = 34;
			this.label4.Text = "Root Dir";
			// 
			// edtPort
			// 
			this.edtPort.Location = new System.Drawing.Point(92, 161);
			this.edtPort.Name = "edtPort";
			this.edtPort.Size = new System.Drawing.Size(168, 20);
			this.edtPort.TabIndex = 33;
			this.edtPort.Text = "143";
			// 
			// label3
			// 
			this.label3.Location = new System.Drawing.Point(28, 161);
			this.label3.Name = "label3";
			this.label3.Size = new System.Drawing.Size(32, 23);
			this.label3.TabIndex = 32;
			this.label3.Text = "Port";
			// 
			// label2
			// 
			this.label2.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
			this.label2.ForeColor = System.Drawing.SystemColors.ControlText;
			this.label2.Location = new System.Drawing.Point(28, 135);
			this.label2.Name = "label2";
			this.label2.Size = new System.Drawing.Size(408, 23);
			this.label2.TabIndex = 31;
			this.label2.Text = "Please use the \"CleverTester\" user name and \"clevertester\" password to log-in.";
			// 
			// label1
			// 
			this.label1.Location = new System.Drawing.Point(9, 90);
			this.label1.Name = "label1";
			this.label1.Size = new System.Drawing.Size(602, 29);
			this.label1.TabIndex = 30;
			this.label1.Text = "This is a sample IMAP server, which shows how to handle the SEARCH UNDELETED SINC" +
    "E command in the IMAP4 server for C# .NET. You can use any mail client with IMAP" +
    " support to connect to this server.";
			// 
			// MainForm
			// 
			this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			this.ClientSize = new System.Drawing.Size(623, 452);
			this.Controls.Add(this.memLog);
			this.Controls.Add(this.label5);
			this.Controls.Add(this.btnStop);
			this.Controls.Add(this.btnStart);
			this.Controls.Add(this.edtRootDir);
			this.Controls.Add(this.label4);
			this.Controls.Add(this.edtPort);
			this.Controls.Add(this.label3);
			this.Controls.Add(this.label2);
			this.Controls.Add(this.label1);
			this.Controls.Add(this.pictureBox1);
			this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
			this.Name = "MainForm";
			this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
			this.Text = "IMAP Server";
			((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).EndInit();
			this.ResumeLayout(false);
			this.PerformLayout();

		}

		#endregion

		private System.Windows.Forms.PictureBox pictureBox1;
		private CleverComponents.InetSuite.Imap4Server imap4Server1;
		private CleverComponents.InetSuite.Imap4FileHandler imap4FileHandler1;
		private System.Windows.Forms.TextBox memLog;
		private System.Windows.Forms.Label label5;
		private System.Windows.Forms.Button btnStop;
		private System.Windows.Forms.Button btnStart;
		private System.Windows.Forms.TextBox edtRootDir;
		private System.Windows.Forms.Label label4;
		private System.Windows.Forms.TextBox edtPort;
		private System.Windows.Forms.Label label3;
		private System.Windows.Forms.Label label2;
		private System.Windows.Forms.Label label1;
	}
}

