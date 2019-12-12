namespace WindowsFormsApp1
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
			this.button1 = new System.Windows.Forms.Button();
			this.label2 = new System.Windows.Forms.Label();
			this.label3 = new System.Windows.Forms.Label();
			this.textBox1 = new System.Windows.Forms.TextBox();
			this.textBox2 = new System.Windows.Forms.TextBox();
			this.textBox3 = new System.Windows.Forms.TextBox();
			this.button2 = new System.Windows.Forms.Button();
			this.label1 = new System.Windows.Forms.Label();
			this.SuspendLayout();
			// 
			// button1
			// 
			this.button1.Location = new System.Drawing.Point(12, 136);
			this.button1.Margin = new System.Windows.Forms.Padding(4, 4, 4, 4);
			this.button1.Name = "button1";
			this.button1.Size = new System.Drawing.Size(135, 51);
			this.button1.TabIndex = 2;
			this.button1.Text = "Convert";
			this.button1.UseVisualStyleBackColor = true;
			this.button1.Click += new System.EventHandler(this.button1_Click);
			// 
			// label2
			// 
			this.label2.AutoSize = true;
			this.label2.Location = new System.Drawing.Point(9, 9);
			this.label2.Name = "label2";
			this.label2.Size = new System.Drawing.Size(106, 17);
			this.label2.TabIndex = 2;
			this.label2.Text = "RSA Public Key";
			// 
			// label3
			// 
			this.label3.AutoSize = true;
			this.label3.Location = new System.Drawing.Point(414, 9);
			this.label3.Name = "label3";
			this.label3.Size = new System.Drawing.Size(139, 17);
			this.label3.TabIndex = 3;
			this.label3.Text = "RSA Public PEM Key";
			// 
			// textBox1
			// 
			this.textBox1.Location = new System.Drawing.Point(12, 35);
			this.textBox1.Multiline = true;
			this.textBox1.Name = "textBox1";
			this.textBox1.Size = new System.Drawing.Size(386, 94);
			this.textBox1.TabIndex = 1;
			this.textBox1.Text = "MEgCQQDCiZulctu\r\n+Tp2pZ7wfTyKhpSkYzqkRAwdmvNdvUVwgh8mwBAOdt9Mvhx\r\n+OVokrzfLIJqeBB" +
    "kbwTzxfgVeU6CL3AgMBAAE=";
			// 
			// textBox2
			// 
			this.textBox2.Location = new System.Drawing.Point(417, 35);
			this.textBox2.Multiline = true;
			this.textBox2.Name = "textBox2";
			this.textBox2.Size = new System.Drawing.Size(403, 94);
			this.textBox2.TabIndex = 3;
			this.textBox2.Text = "-----BEGIN RSA PUBLIC KEY-----\r\nMEgCQQDCiZulctu\r\n+Tp2pZ7wfTyKhpSkYzqkRAwdmvNdvUVw" +
    "gh8mwBAOdt9Mvhx+O\r\nVokrzfLIJqeBBkbwTzxfgVeU6CL3AgMBAAE=\r\n-----END RSA PUBLIC KEY" +
    "-----";
			// 
			// textBox3
			// 
			this.textBox3.Location = new System.Drawing.Point(12, 223);
			this.textBox3.Multiline = true;
			this.textBox3.Name = "textBox3";
			this.textBox3.ReadOnly = true;
			this.textBox3.Size = new System.Drawing.Size(808, 136);
			this.textBox3.TabIndex = 5;
			// 
			// button2
			// 
			this.button2.Location = new System.Drawing.Point(417, 136);
			this.button2.Name = "button2";
			this.button2.Size = new System.Drawing.Size(135, 52);
			this.button2.TabIndex = 4;
			this.button2.Text = "Convert";
			this.button2.UseVisualStyleBackColor = true;
			this.button2.Click += new System.EventHandler(this.button2_Click);
			// 
			// label1
			// 
			this.label1.AutoSize = true;
			this.label1.Location = new System.Drawing.Point(12, 195);
			this.label1.Name = "label1";
			this.label1.Size = new System.Drawing.Size(147, 17);
			this.label1.TabIndex = 8;
			this.label1.Text = "X509 Subject Key Info";
			// 
			// Form1
			// 
			this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			this.ClientSize = new System.Drawing.Size(832, 371);
			this.Controls.Add(this.label1);
			this.Controls.Add(this.button2);
			this.Controls.Add(this.textBox3);
			this.Controls.Add(this.textBox2);
			this.Controls.Add(this.textBox1);
			this.Controls.Add(this.label3);
			this.Controls.Add(this.label2);
			this.Controls.Add(this.button1);
			this.Margin = new System.Windows.Forms.Padding(4, 4, 4, 4);
			this.Name = "Form1";
			this.Text = "RSA Public Key converter";
			this.ResumeLayout(false);
			this.PerformLayout();

		}

		#endregion
		private System.Windows.Forms.Button button1;
		private System.Windows.Forms.Label label2;
		private System.Windows.Forms.Label label3;
		private System.Windows.Forms.TextBox textBox1;
		private System.Windows.Forms.TextBox textBox2;
		private System.Windows.Forms.TextBox textBox3;
		private System.Windows.Forms.Button button2;
		private System.Windows.Forms.Label label1;
	}
}

