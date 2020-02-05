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
			this.button1 = new System.Windows.Forms.Button();
			this.SuspendLayout();
			// 
			// label1
			// 
			this.label1.AutoSize = true;
			this.label1.Location = new System.Drawing.Point(21, 38);
			this.label1.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
			this.label1.Name = "label1";
			this.label1.Size = new System.Drawing.Size(57, 17);
			this.label1.TabIndex = 0;
			this.label1.Text = "Celsium";
			// 
			// edtCelsium
			// 
			this.edtCelsium.Location = new System.Drawing.Point(87, 34);
			this.edtCelsium.Margin = new System.Windows.Forms.Padding(4, 4, 4, 4);
			this.edtCelsium.Name = "edtCelsium";
			this.edtCelsium.Size = new System.Drawing.Size(100, 22);
			this.edtCelsium.TabIndex = 1;
			this.edtCelsium.Text = "0";
			// 
			// btnC2F
			// 
			this.btnC2F.Location = new System.Drawing.Point(235, 32);
			this.btnC2F.Margin = new System.Windows.Forms.Padding(4, 4, 4, 4);
			this.btnC2F.Name = "btnC2F";
			this.btnC2F.Size = new System.Drawing.Size(183, 28);
			this.btnC2F.TabIndex = 2;
			this.btnC2F.Text = "C -> F";
			this.btnC2F.UseVisualStyleBackColor = true;
			this.btnC2F.Click += new System.EventHandler(this.btnC2F_Click);
			// 
			// edtFahr
			// 
			this.edtFahr.Location = new System.Drawing.Point(87, 68);
			this.edtFahr.Margin = new System.Windows.Forms.Padding(4, 4, 4, 4);
			this.edtFahr.Name = "edtFahr";
			this.edtFahr.Size = new System.Drawing.Size(100, 22);
			this.edtFahr.TabIndex = 3;
			// 
			// button1
			// 
			this.button1.Location = new System.Drawing.Point(235, 68);
			this.button1.Name = "button1";
			this.button1.Size = new System.Drawing.Size(183, 22);
			this.button1.TabIndex = 4;
			this.button1.Text = "button1";
			this.button1.UseVisualStyleBackColor = true;
			this.button1.Click += new System.EventHandler(this.button1_Click);
			// 
			// Form1
			// 
			this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			this.ClientSize = new System.Drawing.Size(475, 214);
			this.Controls.Add(this.button1);
			this.Controls.Add(this.edtFahr);
			this.Controls.Add(this.btnC2F);
			this.Controls.Add(this.edtCelsium);
			this.Controls.Add(this.label1);
			this.Margin = new System.Windows.Forms.Padding(4, 4, 4, 4);
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
        private System.Windows.Forms.Button button1;
    }
}

