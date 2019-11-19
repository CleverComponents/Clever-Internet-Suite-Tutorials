namespace WakeOnLANCS {
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
			this.edtMAC = new System.Windows.Forms.TextBox();
			this.btnWakeUp = new System.Windows.Forms.Button();
			this.SuspendLayout();
			// 
			// label1
			// 
			this.label1.AutoSize = true;
			this.label1.Location = new System.Drawing.Point(44, 33);
			this.label1.Name = "label1";
			this.label1.Size = new System.Drawing.Size(30, 13);
			this.label1.TabIndex = 0;
			this.label1.Text = "MAC";
			// 
			// edtMAC
			// 
			this.edtMAC.Location = new System.Drawing.Point(96, 30);
			this.edtMAC.Name = "edtMAC";
			this.edtMAC.Size = new System.Drawing.Size(248, 20);
			this.edtMAC.TabIndex = 1;
			this.edtMAC.Text = "12-34-56-78-9A-BC";
			// 
			// btnWakeUp
			// 
			this.btnWakeUp.Location = new System.Drawing.Point(375, 28);
			this.btnWakeUp.Name = "btnWakeUp";
			this.btnWakeUp.Size = new System.Drawing.Size(75, 23);
			this.btnWakeUp.TabIndex = 2;
			this.btnWakeUp.Text = "Wake Up";
			this.btnWakeUp.UseVisualStyleBackColor = true;
			this.btnWakeUp.Click += new System.EventHandler(this.btnWakeUp_Click);
			// 
			// Form1
			// 
			this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			this.ClientSize = new System.Drawing.Size(497, 86);
			this.Controls.Add(this.btnWakeUp);
			this.Controls.Add(this.edtMAC);
			this.Controls.Add(this.label1);
			this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
			this.Name = "Form1";
			this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
			this.Text = "Wake On LAN sample";
			this.ResumeLayout(false);
			this.PerformLayout();

		}

		#endregion

		private System.Windows.Forms.Label label1;
		private System.Windows.Forms.TextBox edtMAC;
		private System.Windows.Forms.Button btnWakeUp;
	}
}

