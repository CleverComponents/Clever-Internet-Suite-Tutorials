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
			this.label2 = new System.Windows.Forms.Label();
			this.cbSecurity = new System.Windows.Forms.ComboBox();
			this.label3 = new System.Windows.Forms.Label();
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
			this.btnC2F.Location = new System.Drawing.Point(92, 103);
			this.btnC2F.Margin = new System.Windows.Forms.Padding(4);
			this.btnC2F.Name = "btnC2F";
			this.btnC2F.Size = new System.Drawing.Size(124, 40);
			this.btnC2F.TabIndex = 4;
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
			this.edtFahr.TabIndex = 2;
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
			// cbSecurity
			// 
			this.cbSecurity.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
			this.cbSecurity.FormattingEnabled = true;
			this.cbSecurity.Items.AddRange(new object[] {
            "None",
            "Sign",
            "SignEncrypt"});
			this.cbSecurity.Location = new System.Drawing.Point(92, 72);
			this.cbSecurity.Name = "cbSecurity";
			this.cbSecurity.Size = new System.Drawing.Size(124, 24);
			this.cbSecurity.TabIndex = 3;
			this.cbSecurity.Tag = "";
			// 
			// label3
			// 
			this.label3.AutoSize = true;
			this.label3.Location = new System.Drawing.Point(6, 79);
			this.label3.Name = "label3";
			this.label3.Size = new System.Drawing.Size(59, 17);
			this.label3.TabIndex = 10;
			this.label3.Tag = "";
			this.label3.Text = "Security";
			// 
			// Form1
			// 
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.None;
			this.ClientSize = new System.Drawing.Size(234, 178);
			this.Controls.Add(this.label3);
			this.Controls.Add(this.cbSecurity);
			this.Controls.Add(this.label2);
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
		private System.Windows.Forms.Label label2;
		private System.Windows.Forms.ComboBox cbSecurity;
		private System.Windows.Forms.Label label3;
	}
}

