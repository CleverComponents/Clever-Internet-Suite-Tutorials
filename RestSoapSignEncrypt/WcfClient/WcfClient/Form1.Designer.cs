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
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(16, 31);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(43, 13);
            this.label1.TabIndex = 0;
            this.label1.Text = "Celsium";
            // 
            // edtCelsium
            // 
            this.edtCelsium.Location = new System.Drawing.Point(65, 28);
            this.edtCelsium.Name = "edtCelsium";
            this.edtCelsium.Size = new System.Drawing.Size(76, 20);
            this.edtCelsium.TabIndex = 1;
            this.edtCelsium.Text = "0";
            // 
            // btnC2F
            // 
            this.btnC2F.Location = new System.Drawing.Point(176, 26);
            this.btnC2F.Name = "btnC2F";
            this.btnC2F.Size = new System.Drawing.Size(137, 23);
            this.btnC2F.TabIndex = 2;
            this.btnC2F.Text = "C -> F";
            this.btnC2F.UseVisualStyleBackColor = true;
            this.btnC2F.Click += new System.EventHandler(this.btnC2F_Click);
            // 
            // edtFahr
            // 
            this.edtFahr.Location = new System.Drawing.Point(65, 55);
            this.edtFahr.Name = "edtFahr";
            this.edtFahr.Size = new System.Drawing.Size(76, 20);
            this.edtFahr.TabIndex = 3;
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(356, 174);
            this.Controls.Add(this.edtFahr);
            this.Controls.Add(this.btnC2F);
            this.Controls.Add(this.edtCelsium);
            this.Controls.Add(this.label1);
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
    }
}

