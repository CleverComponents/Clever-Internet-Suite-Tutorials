namespace FramedClient
{
	partial class MainForm
	{
		/// <summary>
		/// Required designer variable.
		/// </summary>
		private System.ComponentModel.IContainer components = null;

		private FramedClient client;
		/// <summary>
		/// Clean up any resources being used.
		/// </summary>
		/// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
		protected override void Dispose(bool disposing)
		{
			if (disposing)
			{
				client?.Dispose();
				client = null;
			}

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
			this.btnConnect = new System.Windows.Forms.Button();
			this.btnDisconnect = new System.Windows.Forms.Button();
			this.btnSend = new System.Windows.Forms.Button();
			this.txtHost = new System.Windows.Forms.TextBox();
			this.txtPort = new System.Windows.Forms.TextBox();
			this.txtMessage = new System.Windows.Forms.TextBox();
			this.label1 = new System.Windows.Forms.Label();
			this.label2 = new System.Windows.Forms.Label();
			this.txtReplice = new System.Windows.Forms.TextBox();
			this.SuspendLayout();
			// 
			// btnConnect
			// 
			this.btnConnect.Location = new System.Drawing.Point(15, 45);
			this.btnConnect.Name = "btnConnect";
			this.btnConnect.Size = new System.Drawing.Size(97, 36);
			this.btnConnect.TabIndex = 0;
			this.btnConnect.Text = "Connect";
			this.btnConnect.UseVisualStyleBackColor = true;
			this.btnConnect.Click += new System.EventHandler(this.btnConnect_Click);
			// 
			// btnDisconnect
			// 
			this.btnDisconnect.Location = new System.Drawing.Point(157, 45);
			this.btnDisconnect.Name = "btnDisconnect";
			this.btnDisconnect.Size = new System.Drawing.Size(97, 36);
			this.btnDisconnect.TabIndex = 1;
			this.btnDisconnect.Text = "Disconnect";
			this.btnDisconnect.UseVisualStyleBackColor = true;
			this.btnDisconnect.Click += new System.EventHandler(this.btnDisconnect_Click);
			// 
			// btnSend
			// 
			this.btnSend.Location = new System.Drawing.Point(292, 45);
			this.btnSend.Name = "btnSend";
			this.btnSend.Size = new System.Drawing.Size(97, 36);
			this.btnSend.TabIndex = 2;
			this.btnSend.Text = "Send";
			this.btnSend.UseVisualStyleBackColor = true;
			this.btnSend.Click += new System.EventHandler(this.btnSend_Click);
			// 
			// txtHost
			// 
			this.txtHost.Location = new System.Drawing.Point(85, 17);
			this.txtHost.Name = "txtHost";
			this.txtHost.Size = new System.Drawing.Size(179, 22);
			this.txtHost.TabIndex = 3;
			this.txtHost.Text = "localhost";
			// 
			// txtPort
			// 
			this.txtPort.Location = new System.Drawing.Point(270, 17);
			this.txtPort.Name = "txtPort";
			this.txtPort.Size = new System.Drawing.Size(119, 22);
			this.txtPort.TabIndex = 4;
			this.txtPort.Text = "2110";
			// 
			// txtMessage
			// 
			this.txtMessage.Location = new System.Drawing.Point(83, 91);
			this.txtMessage.Name = "txtMessage";
			this.txtMessage.Size = new System.Drawing.Size(306, 22);
			this.txtMessage.TabIndex = 5;
			// 
			// label1
			// 
			this.label1.AutoSize = true;
			this.label1.Location = new System.Drawing.Point(12, 20);
			this.label1.Name = "label1";
			this.label1.Size = new System.Drawing.Size(67, 17);
			this.label1.TabIndex = 6;
			this.label1.Text = "Host/Port";
			// 
			// label2
			// 
			this.label2.AutoSize = true;
			this.label2.Location = new System.Drawing.Point(12, 94);
			this.label2.Name = "label2";
			this.label2.Size = new System.Drawing.Size(65, 17);
			this.label2.TabIndex = 7;
			this.label2.Text = "Message";
			// 
			// txtReplice
			// 
			this.txtReplice.Location = new System.Drawing.Point(15, 119);
			this.txtReplice.Multiline = true;
			this.txtReplice.Name = "txtReplice";
			this.txtReplice.ReadOnly = true;
			this.txtReplice.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
			this.txtReplice.Size = new System.Drawing.Size(374, 251);
			this.txtReplice.TabIndex = 8;
			// 
			// MainForm
			// 
			this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			this.ClientSize = new System.Drawing.Size(401, 380);
			this.Controls.Add(this.txtReplice);
			this.Controls.Add(this.label2);
			this.Controls.Add(this.label1);
			this.Controls.Add(this.txtMessage);
			this.Controls.Add(this.txtPort);
			this.Controls.Add(this.txtHost);
			this.Controls.Add(this.btnSend);
			this.Controls.Add(this.btnDisconnect);
			this.Controls.Add(this.btnConnect);
			this.Name = "MainForm";
			this.Text = "Framed Client";
			this.ResumeLayout(false);
			this.PerformLayout();

		}

		#endregion

		private System.Windows.Forms.Button btnConnect;
		private System.Windows.Forms.Button btnDisconnect;
		private System.Windows.Forms.Button btnSend;
		private System.Windows.Forms.TextBox txtHost;
		private System.Windows.Forms.TextBox txtPort;
		private System.Windows.Forms.TextBox txtMessage;
		private System.Windows.Forms.Label label1;
		private System.Windows.Forms.Label label2;
		private System.Windows.Forms.TextBox txtReplice;
	}
}

