namespace MailQueue {
	partial class Form1 {
		/// <summary>
		/// Required designer variable.
		/// </summary>
		private System.ComponentModel.IContainer components = null;

		/// <summary>
		/// Clean up any resources being used.
		/// </summary>
		/// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
		protected override void Dispose(bool disposing) {
			if (disposing && (components != null)) {
				components.Dispose();
			}
			base.Dispose(disposing);
		}

		#region Windows Form Designer generated code

		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent() {
			this.label1 = new System.Windows.Forms.Label();
			this.edtQueueFolder = new System.Windows.Forms.TextBox();
			this.btnStart = new System.Windows.Forms.Button();
			this.btnStop = new System.Windows.Forms.Button();
			this.label2 = new System.Windows.Forms.Label();
			this.edtLog = new System.Windows.Forms.TextBox();
			this.watcher = new System.IO.FileSystemWatcher();
			this.relay = new CleverComponents.InetSuite.SmtpRelay();
			this.label3 = new System.Windows.Forms.Label();
			this.edtDNS = new System.Windows.Forms.TextBox();
			((System.ComponentModel.ISupportInitialize)(this.watcher)).BeginInit();
			this.SuspendLayout();
			// 
			// label1
			// 
			this.label1.AutoSize = true;
			this.label1.Location = new System.Drawing.Point(25, 22);
			this.label1.Name = "label1";
			this.label1.Size = new System.Drawing.Size(68, 13);
			this.label1.TabIndex = 0;
			this.label1.Text = "Queue folder";
			// 
			// edtQueueFolder
			// 
			this.edtQueueFolder.Location = new System.Drawing.Point(99, 19);
			this.edtQueueFolder.Name = "edtQueueFolder";
			this.edtQueueFolder.Size = new System.Drawing.Size(326, 20);
			this.edtQueueFolder.TabIndex = 1;
			this.edtQueueFolder.Text = "c:\\MailQueue";
			// 
			// btnStart
			// 
			this.btnStart.Location = new System.Drawing.Point(99, 98);
			this.btnStart.Name = "btnStart";
			this.btnStart.Size = new System.Drawing.Size(75, 23);
			this.btnStart.TabIndex = 2;
			this.btnStart.Text = "Start";
			this.btnStart.UseVisualStyleBackColor = true;
			this.btnStart.Click += new System.EventHandler(this.btnStart_Click);
			// 
			// btnStop
			// 
			this.btnStop.Location = new System.Drawing.Point(199, 98);
			this.btnStop.Name = "btnStop";
			this.btnStop.Size = new System.Drawing.Size(75, 23);
			this.btnStop.TabIndex = 3;
			this.btnStop.Text = "Stop";
			this.btnStop.UseVisualStyleBackColor = true;
			this.btnStop.Click += new System.EventHandler(this.btnStop_Click);
			// 
			// label2
			// 
			this.label2.AutoSize = true;
			this.label2.Location = new System.Drawing.Point(30, 135);
			this.label2.Name = "label2";
			this.label2.Size = new System.Drawing.Size(25, 13);
			this.label2.TabIndex = 4;
			this.label2.Text = "Log";
			// 
			// edtLog
			// 
			this.edtLog.Location = new System.Drawing.Point(28, 151);
			this.edtLog.Multiline = true;
			this.edtLog.Name = "edtLog";
			this.edtLog.ReadOnly = true;
			this.edtLog.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
			this.edtLog.Size = new System.Drawing.Size(397, 241);
			this.edtLog.TabIndex = 5;
			// 
			// watcher
			// 
			this.watcher.EnableRaisingEvents = true;
			this.watcher.SynchronizingObject = this;
			this.watcher.Created += new System.IO.FileSystemEventHandler(this.watcher_Created);
			// 
			// relay
			// 
			this.relay.DnsServer = null;
			this.relay.Port = 25;
			// 
			// label3
			// 
			this.label3.AutoSize = true;
			this.label3.Location = new System.Drawing.Point(63, 54);
			this.label3.Name = "label3";
			this.label3.Size = new System.Drawing.Size(30, 13);
			this.label3.TabIndex = 6;
			this.label3.Text = "DNS";
			// 
			// edtDNS
			// 
			this.edtDNS.Location = new System.Drawing.Point(99, 51);
			this.edtDNS.Name = "edtDNS";
			this.edtDNS.Size = new System.Drawing.Size(136, 20);
			this.edtDNS.TabIndex = 7;
			// 
			// Form1
			// 
			this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			this.ClientSize = new System.Drawing.Size(455, 404);
			this.Controls.Add(this.edtDNS);
			this.Controls.Add(this.label3);
			this.Controls.Add(this.edtLog);
			this.Controls.Add(this.label2);
			this.Controls.Add(this.btnStop);
			this.Controls.Add(this.btnStart);
			this.Controls.Add(this.edtQueueFolder);
			this.Controls.Add(this.label1);
			this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
			this.Name = "Form1";
			this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
			this.Text = "Mail Sending Queue";
			((System.ComponentModel.ISupportInitialize)(this.watcher)).EndInit();
			this.ResumeLayout(false);
			this.PerformLayout();

		}

		#endregion

		private System.Windows.Forms.Label label1;
		private System.Windows.Forms.TextBox edtQueueFolder;
		private System.Windows.Forms.Button btnStart;
		private System.Windows.Forms.Button btnStop;
		private System.Windows.Forms.Label label2;
		private System.Windows.Forms.TextBox edtLog;
		private System.IO.FileSystemWatcher watcher;
		private CleverComponents.InetSuite.SmtpRelay relay;
		private System.Windows.Forms.Label label3;
		private System.Windows.Forms.TextBox edtDNS;
	}
}

