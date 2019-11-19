using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;
using System.Data;
using CleverComponents.InetSuite;

namespace GMailSMTP
{
	/// <summary>
	/// Summary description for Form1.
	/// </summary>
	public class Form1 : System.Windows.Forms.Form
	{
		private System.Windows.Forms.TextBox memBody;
		private System.Windows.Forms.TextBox edtSubject;
		private System.Windows.Forms.Label label8;
		private System.Windows.Forms.TextBox edtFrom;
		private System.Windows.Forms.Label label7;
		private System.Windows.Forms.Label label5;
		private System.Windows.Forms.Button btnSend;
		private CleverComponents.InetSuite.Smtp smtp1;
		private CleverComponents.InetSuite.MailMessage mailMessage1;
		private System.Windows.Forms.TextBox edtTo;
		private CleverComponents.InetSuite.OAuth oAuth1;
		private PictureBox pictureBox1;

		/// <summary>
		/// Required designer variable.
		/// </summary>
		private System.ComponentModel.Container components = null;

		public Form1()
		{
			//
			// Required for Windows Form Designer support
			//
			InitializeComponent();

			//
			// TODO: Add any constructor code after InitializeComponent call
			//
		}

		/// <summary>
		/// Clean up any resources being used.
		/// </summary>
		protected override void Dispose( bool disposing )
		{
			if( disposing )
			{
				if (components != null) 
				{
					components.Dispose();
				}
			}
			base.Dispose( disposing );
		}

		#region Windows Form Designer generated code
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
			System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(Form1));
			this.memBody = new System.Windows.Forms.TextBox();
			this.edtSubject = new System.Windows.Forms.TextBox();
			this.label8 = new System.Windows.Forms.Label();
			this.edtFrom = new System.Windows.Forms.TextBox();
			this.label7 = new System.Windows.Forms.Label();
			this.edtTo = new System.Windows.Forms.TextBox();
			this.label5 = new System.Windows.Forms.Label();
			this.btnSend = new System.Windows.Forms.Button();
			this.smtp1 = new CleverComponents.InetSuite.Smtp();
			this.mailMessage1 = new CleverComponents.InetSuite.MailMessage();
			this.oAuth1 = new CleverComponents.InetSuite.OAuth();
			this.pictureBox1 = new System.Windows.Forms.PictureBox();
			((System.ComponentModel.ISupportInitialize)(this.smtp1)).BeginInit();
			((System.ComponentModel.ISupportInitialize)(this.mailMessage1)).BeginInit();
			((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).BeginInit();
			this.SuspendLayout();
			// 
			// memBody
			// 
			this.memBody.Location = new System.Drawing.Point(13, 175);
			this.memBody.Multiline = true;
			this.memBody.Name = "memBody";
			this.memBody.ScrollBars = System.Windows.Forms.ScrollBars.Both;
			this.memBody.Size = new System.Drawing.Size(593, 176);
			this.memBody.TabIndex = 9;
			this.memBody.Text = resources.GetString("memBody.Text");
			// 
			// edtSubject
			// 
			this.edtSubject.Location = new System.Drawing.Point(64, 145);
			this.edtSubject.Name = "edtSubject";
			this.edtSubject.Size = new System.Drawing.Size(542, 20);
			this.edtSubject.TabIndex = 8;
			this.edtSubject.Text = "ABC Company: New Catalog";
			// 
			// label8
			// 
			this.label8.Location = new System.Drawing.Point(10, 120);
			this.label8.Name = "label8";
			this.label8.Size = new System.Drawing.Size(48, 13);
			this.label8.TabIndex = 39;
			this.label8.Text = "To";
			// 
			// edtFrom
			// 
			this.edtFrom.Location = new System.Drawing.Point(64, 89);
			this.edtFrom.Name = "edtFrom";
			this.edtFrom.Size = new System.Drawing.Size(542, 20);
			this.edtFrom.TabIndex = 6;
			this.edtFrom.Text = "user@gmail.com";
			// 
			// label7
			// 
			this.label7.Location = new System.Drawing.Point(10, 92);
			this.label7.Name = "label7";
			this.label7.Size = new System.Drawing.Size(48, 16);
			this.label7.TabIndex = 38;
			this.label7.Text = "From";
			// 
			// edtTo
			// 
			this.edtTo.Location = new System.Drawing.Point(64, 117);
			this.edtTo.Name = "edtTo";
			this.edtTo.Size = new System.Drawing.Size(542, 20);
			this.edtTo.TabIndex = 7;
			this.edtTo.Text = "anderson@domain.com";
			// 
			// label5
			// 
			this.label5.Location = new System.Drawing.Point(10, 148);
			this.label5.Name = "label5";
			this.label5.Size = new System.Drawing.Size(48, 15);
			this.label5.TabIndex = 41;
			this.label5.Text = "Subject";
			// 
			// btnSend
			// 
			this.btnSend.Location = new System.Drawing.Point(477, 360);
			this.btnSend.Name = "btnSend";
			this.btnSend.Size = new System.Drawing.Size(129, 28);
			this.btnSend.TabIndex = 10;
			this.btnSend.Text = "Send";
			this.btnSend.Click += new System.EventHandler(this.btnSend_Click);
			// 
			// mailMessage1
			// 
			this.mailMessage1.Date = new System.DateTime(2007, 1, 10, 23, 13, 23, 984);
			this.mailMessage1.From.Email = "";
			this.mailMessage1.From.Name = "";
			// 
			// oAuth1
			// 
			this.oAuth1.AuthUrl = null;
			this.oAuth1.ClientID = null;
			this.oAuth1.ClientSecret = null;
			this.oAuth1.Password = null;
			this.oAuth1.RedirectUrl = null;
			this.oAuth1.Scope = null;
			this.oAuth1.State = null;
			this.oAuth1.TokenUrl = null;
			this.oAuth1.UserName = null;
			// 
			// pictureBox1
			// 
			this.pictureBox1.Dock = System.Windows.Forms.DockStyle.Top;
			this.pictureBox1.Image = global::GMailSMTP.Properties.Resources.background_net;
			this.pictureBox1.Location = new System.Drawing.Point(0, 0);
			this.pictureBox1.Name = "pictureBox1";
			this.pictureBox1.Size = new System.Drawing.Size(618, 78);
			this.pictureBox1.SizeMode = System.Windows.Forms.PictureBoxSizeMode.CenterImage;
			this.pictureBox1.TabIndex = 42;
			this.pictureBox1.TabStop = false;
			// 
			// Form1
			// 
			this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
			this.ClientSize = new System.Drawing.Size(618, 394);
			this.Controls.Add(this.pictureBox1);
			this.Controls.Add(this.btnSend);
			this.Controls.Add(this.label5);
			this.Controls.Add(this.edtTo);
			this.Controls.Add(this.memBody);
			this.Controls.Add(this.edtSubject);
			this.Controls.Add(this.label8);
			this.Controls.Add(this.edtFrom);
			this.Controls.Add(this.label7);
			this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
			this.Name = "Form1";
			this.Text = "GMAIL SMTP client with OAuth - Sample";
			((System.ComponentModel.ISupportInitialize)(this.smtp1)).EndInit();
			((System.ComponentModel.ISupportInitialize)(this.mailMessage1)).EndInit();
			((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).EndInit();
			this.ResumeLayout(false);
			this.PerformLayout();

		}
		#endregion

		/// <summary>
		/// The main entry point for the application.
		/// </summary>
		[STAThread]
		static void Main() 
		{
			Application.ThreadException += new System.Threading.ThreadExceptionEventHandler(new ExceptionHandler().OnThreadException);
			Application.Run(new Form1());
		}

		private void btnSend_Click(object sender, System.EventArgs e) {
			if(smtp1.Active) return;

			oAuth1.AuthUrl = "https://accounts.google.com/o/oauth2/auth";
			oAuth1.TokenUrl = "https://accounts.google.com/o/oauth2/token";
			oAuth1.RedirectUrl = "http://localhost";
			oAuth1.ClientID = "421475025220-6khpgoldbdsi60fegvjdqk2bk4v19ss2.apps.googleusercontent.com";
			oAuth1.ClientSecret = "_4HJyAVUmH_iVrPB8pOJXjR1";
			oAuth1.Scope = "https://mail.google.com/";

			smtp1.Server = "smtp.gmail.com";
			smtp1.Port = 587;
			smtp1.UseTls = ClientTlsMode.Explicit;

			smtp1.UserName = edtFrom.Text;

			smtp1.Authorization = oAuth1.GetAuthorization();

			smtp1.Open();
			try {
				mailMessage1.BuildMessage(memBody.Text, "");
				mailMessage1.From.FullAddress = edtFrom.Text;
				mailMessage1.ToList.EmailAddresses = edtTo.Text;
				mailMessage1.Subject = edtSubject.Text;

				smtp1.Send(mailMessage1);

				MessageBox.Show("The message was sent successfully.");
			}
			finally {
				smtp1.Close();
			}
		}
	}

	public class ExceptionHandler {
		public void OnThreadException(object sender, System.Threading.ThreadExceptionEventArgs t) {
			MessageBox.Show(t.Exception.Message);
		}
	}
}
