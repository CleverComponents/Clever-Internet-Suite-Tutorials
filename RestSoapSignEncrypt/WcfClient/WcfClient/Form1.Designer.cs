namespace WcfClient
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
			this.label1 = new System.Windows.Forms.Label();
			this.edtCelsium = new System.Windows.Forms.TextBox();
			this.btnC2F = new System.Windows.Forms.Button();
			this.edtFahr = new System.Windows.Forms.TextBox();
			this.cbTransport = new System.Windows.Forms.CheckBox();
			this.cbSign = new System.Windows.Forms.CheckBox();
			this.cbEncrypt = new System.Windows.Forms.CheckBox();
			this.label2 = new System.Windows.Forms.Label();
			this.SuspendLayout();
			// 
			// label1
			// 
			this.label1.AutoSize = true;
			this.label1.Location = new System.Drawing.Point(6, 17);
			this.label1.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
			this.label1.Name = "label1";
			this.label1.Size = new System.Drawing.Size(57, 17);
			this.label1.TabIndex = 0;
			this.label1.Text = "Celsium";
			// 
			// edtCelsium
			// 
			this.edtCelsium.Location = new System.Drawing.Point(92, 13);
			this.edtCelsium.Margin = new System.Windows.Forms.Padding(4);
			this.edtCelsium.Name = "edtCelsium";
			this.edtCelsium.Size = new System.Drawing.Size(124, 22);
			this.edtCelsium.TabIndex = 1;
			this.edtCelsium.Text = "0";
			// 
			// btnC2F
			// 
			this.btnC2F.Location = new System.Drawing.Point(9, 94);
			this.btnC2F.Margin = new System.Windows.Forms.Padding(4);
			this.btnC2F.Name = "btnC2F";
			this.btnC2F.Size = new System.Drawing.Size(124, 40);
			this.btnC2F.TabIndex = 2;
			this.btnC2F.Text = "Convert";
			this.btnC2F.UseVisualStyleBackColor = true;
			this.btnC2F.Click += new System.EventHandler(this.btnC2F_Click);
			// 
			// edtFahr
			// 
			this.edtFahr.Location = new System.Drawing.Point(92, 43);
			this.edtFahr.Margin = new System.Windows.Forms.Padding(4);
			this.edtFahr.Name = "edtFahr";
			this.edtFahr.Size = new System.Drawing.Size(124, 22);
			this.edtFahr.TabIndex = 3;
			// 
			// cbTransport
			// 
			this.cbTransport.AutoSize = true;
			this.cbTransport.Location = new System.Drawing.Point(234, 12);
			this.cbTransport.Name = "cbTransport";
			this.cbTransport.Size = new System.Drawing.Size(147, 21);
			this.cbTransport.TabIndex = 5;
			this.cbTransport.Text = "Transport Security";
			this.cbTransport.UseVisualStyleBackColor = true;
			// 
			// cbSign
			// 
			this.cbSign.AutoSize = true;
			this.cbSign.Location = new System.Drawing.Point(234, 39);
			this.cbSign.Name = "cbSign";
			this.cbSign.Size = new System.Drawing.Size(113, 21);
			this.cbSign.TabIndex = 6;
			this.cbSign.Text = "Sign Security";
			this.cbSign.UseVisualStyleBackColor = true;
			// 
			// cbEncrypt
			// 
			this.cbEncrypt.AutoSize = true;
			this.cbEncrypt.Location = new System.Drawing.Point(234, 66);
			this.cbEncrypt.Name = "cbEncrypt";
			this.cbEncrypt.Size = new System.Drawing.Size(186, 21);
			this.cbEncrypt.TabIndex = 7;
			this.cbEncrypt.Text = "EnrcyptAndSign Security";
			this.cbEncrypt.UseVisualStyleBackColor = true;
			// 
			// label2
			// 
			this.label2.AutoSize = true;
			this.label2.Location = new System.Drawing.Point(6, 47);
			this.label2.Name = "label2";
			this.label2.Size = new System.Drawing.Size(76, 17);
			this.label2.TabIndex = 8;
			this.label2.Text = "Fahrenheit";
			// 
			// Form1
			// 
			this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			this.ClientSize = new System.Drawing.Size(424, 147);
			this.Controls.Add(this.label2);
			this.Controls.Add(this.cbEncrypt);
			this.Controls.Add(this.cbSign);
			this.Controls.Add(this.cbTransport);
			this.Controls.Add(this.edtFahr);
			this.Controls.Add(this.btnC2F);
			this.Controls.Add(this.edtCelsium);
			this.Controls.Add(this.label1);
			this.Margin = new System.Windows.Forms.Padding(4);
			this.Name = "Form1";
			this.Text = "Form1";
			this.ResumeLayout(false);
			this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TextBox edtCelsium;
        private System.Windows.Forms.Button btnC2F;
        private System.Windows.Forms.TextBox edtFahr;
		private System.Windows.Forms.CheckBox cbTransport;
		private System.Windows.Forms.CheckBox cbSign;
		private System.Windows.Forms.CheckBox cbEncrypt;
		private System.Windows.Forms.Label label2;
	}
}

