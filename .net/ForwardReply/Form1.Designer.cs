namespace ForwardReply
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
			this.btnReceive = new System.Windows.Forms.Button();
			this.btnReply = new System.Windows.Forms.Button();
			this.btnForward = new System.Windows.Forms.Button();
			this.label1 = new System.Windows.Forms.Label();
			this.label2 = new System.Windows.Forms.Label();
			this.label3 = new System.Windows.Forms.Label();
			this.edtPop3Server = new System.Windows.Forms.TextBox();
			this.edtUser = new System.Windows.Forms.TextBox();
			this.edtPassword = new System.Windows.Forms.TextBox();
			this.listBox1 = new System.Windows.Forms.ListBox();
			this.htmlParser = new CleverComponents.InetSuite.HtmlParser();
			this.htmlTextParser = new CleverComponents.InetSuite.HtmlParser();
			this.pop3 = new CleverComponents.InetSuite.Pop3();
			this.smtp = new CleverComponents.InetSuite.Smtp();
			this.mailMessage = new CleverComponents.InetSuite.MailMessage();
			this.label4 = new System.Windows.Forms.Label();
			this.label5 = new System.Windows.Forms.Label();
			this.label6 = new System.Windows.Forms.Label();
			this.edtPop3Port = new System.Windows.Forms.TextBox();
			this.edtStmpServer = new System.Windows.Forms.TextBox();
			this.edtStpmPort = new System.Windows.Forms.TextBox();
			((System.ComponentModel.ISupportInitialize)(this.pop3)).BeginInit();
			((System.ComponentModel.ISupportInitialize)(this.smtp)).BeginInit();
			((System.ComponentModel.ISupportInitialize)(this.mailMessage)).BeginInit();
			this.SuspendLayout();
			// 
			// btnReceive
			// 
			this.btnReceive.Location = new System.Drawing.Point(469, 119);
			this.btnReceive.Name = "btnReceive";
			this.btnReceive.Size = new System.Drawing.Size(104, 44);
			this.btnReceive.TabIndex = 8;
			this.btnReceive.Text = "Receive";
			this.btnReceive.UseVisualStyleBackColor = true;
			this.btnReceive.Click += new System.EventHandler(this.btnReceive_Click);
			// 
			// btnReply
			// 
			this.btnReply.Location = new System.Drawing.Point(469, 208);
			this.btnReply.Name = "btnReply";
			this.btnReply.Size = new System.Drawing.Size(104, 44);
			this.btnReply.TabIndex = 9;
			this.btnReply.Text = "Reply";
			this.btnReply.UseVisualStyleBackColor = true;
			this.btnReply.Click += new System.EventHandler(this.btnReply_Click);
			// 
			// btnForward
			// 
			this.btnForward.Location = new System.Drawing.Point(469, 303);
			this.btnForward.Name = "btnForward";
			this.btnForward.Size = new System.Drawing.Size(104, 44);
			this.btnForward.TabIndex = 10;
			this.btnForward.Text = "Forward";
			this.btnForward.UseVisualStyleBackColor = true;
			this.btnForward.Click += new System.EventHandler(this.btnForward_Click);
			// 
			// label1
			// 
			this.label1.AutoSize = true;
			this.label1.Location = new System.Drawing.Point(12, 9);
			this.label1.Name = "label1";
			this.label1.Size = new System.Drawing.Size(91, 17);
			this.label1.TabIndex = 3;
			this.label1.Text = "Server POP3";
			// 
			// label2
			// 
			this.label2.AutoSize = true;
			this.label2.Location = new System.Drawing.Point(12, 66);
			this.label2.Name = "label2";
			this.label2.Size = new System.Drawing.Size(38, 17);
			this.label2.TabIndex = 4;
			this.label2.Text = "User";
			// 
			// label3
			// 
			this.label3.AutoSize = true;
			this.label3.Location = new System.Drawing.Point(12, 94);
			this.label3.Name = "label3";
			this.label3.Size = new System.Drawing.Size(69, 17);
			this.label3.TabIndex = 5;
			this.label3.Text = "Password";
			// 
			// edtPop3Server
			// 
			this.edtPop3Server.Location = new System.Drawing.Point(114, 6);
			this.edtPop3Server.Name = "edtPop3Server";
			this.edtPop3Server.Size = new System.Drawing.Size(159, 22);
			this.edtPop3Server.TabIndex = 1;
			// 
			// edtUser
			// 
			this.edtUser.Location = new System.Drawing.Point(114, 63);
			this.edtUser.Name = "edtUser";
			this.edtUser.Size = new System.Drawing.Size(159, 22);
			this.edtUser.TabIndex = 5;
			// 
			// edtPassword
			// 
			this.edtPassword.Location = new System.Drawing.Point(114, 91);
			this.edtPassword.Name = "edtPassword";
			this.edtPassword.PasswordChar = '*';
			this.edtPassword.Size = new System.Drawing.Size(159, 22);
			this.edtPassword.TabIndex = 6;
			// 
			// listBox1
			// 
			this.listBox1.FormattingEnabled = true;
			this.listBox1.ItemHeight = 16;
			this.listBox1.Location = new System.Drawing.Point(15, 119);
			this.listBox1.Name = "listBox1";
			this.listBox1.Size = new System.Drawing.Size(448, 228);
			this.listBox1.TabIndex = 7;
			// 
			// htmlParser
			// 
			this.htmlParser.IncludeClosingTags = true;
			this.htmlParser.ParseMethod = CleverComponents.InetSuite.ParseMethod.All;
			// 
			// htmlTextParser
			// 
			this.htmlTextParser.ParseMethod = CleverComponents.InetSuite.ParseMethod.TextOnly;
			this.htmlTextParser.ParseTag += new CleverComponents.InetSuite.ParseTagEventHandler(this.htmlTextParser_ParseTag);
			// 
			// pop3
			// 
			this.pop3.ConnectTimeOut = 0;
			// 
			// smtp
			// 
			this.smtp.ConnectTimeOut = 0;
			// 
			// mailMessage
			// 
			this.mailMessage.Date = new System.DateTime(2020, 3, 20, 13, 10, 50, 167);
			this.mailMessage.From.Email = "";
			this.mailMessage.From.Name = "";
			// 
			// label4
			// 
			this.label4.AutoSize = true;
			this.label4.Location = new System.Drawing.Point(12, 35);
			this.label4.Name = "label4";
			this.label4.Size = new System.Drawing.Size(34, 17);
			this.label4.TabIndex = 10;
			this.label4.Text = "Port";
			// 
			// label5
			// 
			this.label5.AutoSize = true;
			this.label5.Location = new System.Drawing.Point(302, 11);
			this.label5.Name = "label5";
			this.label5.Size = new System.Drawing.Size(92, 17);
			this.label5.TabIndex = 11;
			this.label5.Text = "Server SMTP";
			// 
			// label6
			// 
			this.label6.AutoSize = true;
			this.label6.Location = new System.Drawing.Point(302, 35);
			this.label6.Name = "label6";
			this.label6.Size = new System.Drawing.Size(34, 17);
			this.label6.TabIndex = 12;
			this.label6.Text = "Port";
			// 
			// edtPop3Port
			// 
			this.edtPop3Port.Location = new System.Drawing.Point(114, 35);
			this.edtPop3Port.Name = "edtPop3Port";
			this.edtPop3Port.Size = new System.Drawing.Size(100, 22);
			this.edtPop3Port.TabIndex = 3;
			// 
			// edtStmpServer
			// 
			this.edtStmpServer.Location = new System.Drawing.Point(414, 6);
			this.edtStmpServer.Name = "edtStmpServer";
			this.edtStmpServer.Size = new System.Drawing.Size(159, 22);
			this.edtStmpServer.TabIndex = 2;
			// 
			// edtStpmPort
			// 
			this.edtStpmPort.Location = new System.Drawing.Point(414, 35);
			this.edtStpmPort.Name = "edtStpmPort";
			this.edtStpmPort.Size = new System.Drawing.Size(100, 22);
			this.edtStpmPort.TabIndex = 4;
			// 
			// Form1
			// 
			this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			this.AutoSize = true;
			this.ClientSize = new System.Drawing.Size(585, 356);
			this.Controls.Add(this.edtStpmPort);
			this.Controls.Add(this.edtStmpServer);
			this.Controls.Add(this.edtPop3Port);
			this.Controls.Add(this.label6);
			this.Controls.Add(this.label5);
			this.Controls.Add(this.label4);
			this.Controls.Add(this.listBox1);
			this.Controls.Add(this.edtPassword);
			this.Controls.Add(this.edtUser);
			this.Controls.Add(this.edtPop3Server);
			this.Controls.Add(this.label3);
			this.Controls.Add(this.label2);
			this.Controls.Add(this.label1);
			this.Controls.Add(this.btnForward);
			this.Controls.Add(this.btnReply);
			this.Controls.Add(this.btnReceive);
			this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
			this.MaximizeBox = false;
			this.MinimizeBox = false;
			this.Name = "Form1";
			this.Text = "ForwardReply";
			((System.ComponentModel.ISupportInitialize)(this.pop3)).EndInit();
			((System.ComponentModel.ISupportInitialize)(this.smtp)).EndInit();
			((System.ComponentModel.ISupportInitialize)(this.mailMessage)).EndInit();
			this.ResumeLayout(false);
			this.PerformLayout();

		}

		#endregion

		private System.Windows.Forms.Button btnReceive;
		private System.Windows.Forms.Button btnReply;
		private System.Windows.Forms.Button btnForward;
		private System.Windows.Forms.Label label1;
		private System.Windows.Forms.Label label2;
		private System.Windows.Forms.Label label3;
		private System.Windows.Forms.TextBox edtPop3Server;
		private System.Windows.Forms.TextBox edtUser;
		private System.Windows.Forms.TextBox edtPassword;
		private System.Windows.Forms.ListBox listBox1;
		private CleverComponents.InetSuite.HtmlParser htmlParser;
		private CleverComponents.InetSuite.HtmlParser htmlTextParser;
		private CleverComponents.InetSuite.Pop3 pop3;
		private CleverComponents.InetSuite.Smtp smtp;
		private CleverComponents.InetSuite.MailMessage mailMessage;
		private System.Windows.Forms.Label label4;
		private System.Windows.Forms.Label label5;
		private System.Windows.Forms.Label label6;
		private System.Windows.Forms.TextBox edtPop3Port;
		private System.Windows.Forms.TextBox edtStmpServer;
		private System.Windows.Forms.TextBox edtStpmPort;
	}
}

