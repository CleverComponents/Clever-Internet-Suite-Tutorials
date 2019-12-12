namespace PingClient
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
			this.btnPing = new System.Windows.Forms.Button();
			this.label1 = new System.Windows.Forms.Label();
			this.txtHost = new System.Windows.Forms.TextBox();
			this.txtResult = new System.Windows.Forms.TextBox();
			this.SuspendLayout();
			// 
			// btnPing
			// 
			this.btnPing.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
			this.btnPing.Location = new System.Drawing.Point(454, 16);
			this.btnPing.Name = "btnPing";
			this.btnPing.Size = new System.Drawing.Size(118, 36);
			this.btnPing.TabIndex = 0;
			this.btnPing.Text = "Ping";
			this.btnPing.UseVisualStyleBackColor = true;
			this.btnPing.Click += new System.EventHandler(this.btnPing_Click);
			// 
			// label1
			// 
			this.label1.AutoSize = true;
			this.label1.Location = new System.Drawing.Point(12, 26);
			this.label1.Name = "label1";
			this.label1.Size = new System.Drawing.Size(37, 17);
			this.label1.TabIndex = 1;
			this.label1.Text = "Host";
			// 
			// txtHost
			// 
			this.txtHost.Location = new System.Drawing.Point(55, 23);
			this.txtHost.Name = "txtHost";
			this.txtHost.Size = new System.Drawing.Size(242, 22);
			this.txtHost.TabIndex = 2;
			this.txtHost.Text = "google.com";
			// 
			// txtResult
			// 
			this.txtResult.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
			this.txtResult.Location = new System.Drawing.Point(12, 78);
			this.txtResult.Multiline = true;
			this.txtResult.Name = "txtResult";
			this.txtResult.ReadOnly = true;
			this.txtResult.Size = new System.Drawing.Size(560, 171);
			this.txtResult.TabIndex = 3;
			// 
			// Form1
			// 
			this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			this.ClientSize = new System.Drawing.Size(584, 261);
			this.Controls.Add(this.txtResult);
			this.Controls.Add(this.txtHost);
			this.Controls.Add(this.label1);
			this.Controls.Add(this.btnPing);
			this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedToolWindow;
			this.Name = "Form1";
			this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
			this.Text = "Ping Client";
			this.ResumeLayout(false);
			this.PerformLayout();

		}

		#endregion

		private System.Windows.Forms.Button btnPing;
		private System.Windows.Forms.Label label1;
		private System.Windows.Forms.TextBox txtHost;
		private System.Windows.Forms.TextBox txtResult;
	}
}

