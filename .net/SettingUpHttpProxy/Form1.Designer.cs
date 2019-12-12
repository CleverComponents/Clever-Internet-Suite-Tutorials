namespace SettingUpHttpProxy
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
			this.btnHttp = new System.Windows.Forms.Button();
			this.btnFptProxy = new System.Windows.Forms.Button();
			this.btnSMPT = new System.Windows.Forms.Button();
			this.http1 = new CleverComponents.InetSuite.Http();
			this.ftp1 = new CleverComponents.InetSuite.Ftp();
			this.httpProxy1 = new CleverComponents.InetSuite.HttpProxy();
			this.smtp1 = new CleverComponents.InetSuite.Smtp();
			((System.ComponentModel.ISupportInitialize)(this.ftp1)).BeginInit();
			((System.ComponentModel.ISupportInitialize)(this.smtp1)).BeginInit();
			this.SuspendLayout();
			// 
			// btnHttp
			// 
			this.btnHttp.Location = new System.Drawing.Point(500, 13);
			this.btnHttp.Name = "btnHttp";
			this.btnHttp.Size = new System.Drawing.Size(119, 52);
			this.btnHttp.TabIndex = 1;
			this.btnHttp.Text = "Http Client";
			this.btnHttp.UseVisualStyleBackColor = true;
			this.btnHttp.Click += new System.EventHandler(this.btnHttp_Click);
			// 
			// btnFptProxy
			// 
			this.btnFptProxy.Location = new System.Drawing.Point(500, 80);
			this.btnFptProxy.Name = "btnFptProxy";
			this.btnFptProxy.Size = new System.Drawing.Size(119, 52);
			this.btnFptProxy.TabIndex = 2;
			this.btnFptProxy.Text = "Ftp Client";
			this.btnFptProxy.UseVisualStyleBackColor = true;
			this.btnFptProxy.Click += new System.EventHandler(this.btnFptProxy_Click);
			// 
			// btnSMPT
			// 
			this.btnSMPT.Location = new System.Drawing.Point(500, 147);
			this.btnSMPT.Name = "btnSMPT";
			this.btnSMPT.Size = new System.Drawing.Size(119, 52);
			this.btnSMPT.TabIndex = 3;
			this.btnSMPT.Text = "SMPT Client";
			this.btnSMPT.UseVisualStyleBackColor = true;
			this.btnSMPT.Click += new System.EventHandler(this.btnSMPT_Click);
			// 
			// http1
			// 
			this.http1.CharSet = null;
			// 
			// Form1
			// 
			this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			this.ClientSize = new System.Drawing.Size(631, 211);
			this.Controls.Add(this.btnSMPT);
			this.Controls.Add(this.btnFptProxy);
			this.Controls.Add(this.btnHttp);
			this.Name = "Form1";
			this.Text = "Setting Up HTTP Proxy Parameters in TCP-based Client Components";
			((System.ComponentModel.ISupportInitialize)(this.ftp1)).EndInit();
			((System.ComponentModel.ISupportInitialize)(this.smtp1)).EndInit();
			this.ResumeLayout(false);

		}

		#endregion

		private System.Windows.Forms.Button btnHttp;
		private System.Windows.Forms.Button btnFptProxy;
		private System.Windows.Forms.Button btnSMPT;
		private CleverComponents.InetSuite.Http http1;
		private CleverComponents.InetSuite.Ftp ftp1;
		private CleverComponents.InetSuite.HttpProxy httpProxy1;
		private CleverComponents.InetSuite.Smtp smtp1;
	}
}

