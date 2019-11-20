using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;
using System.Data;
using CleverComponents.InetSuite;

namespace ImapClientSSL
{
	/// <summary>
	/// Summary description for Form1.
	/// </summary>
	public class Form1 : System.Windows.Forms.Form
	{
		private System.Windows.Forms.TextBox edtUser;
		private System.Windows.Forms.Label label2;
		private System.Windows.Forms.Button btnLogout;
		private System.Windows.Forms.Button btnLogin;
		private System.Windows.Forms.Label label5;
		private System.Windows.Forms.Label label6;
		private System.Windows.Forms.ListView lvMessages;
		private System.Windows.Forms.ColumnHeader columnHeader2;
		private System.Windows.Forms.ColumnHeader columnHeader3;
		private System.Windows.Forms.ColumnHeader columnHeader4;
		private System.Windows.Forms.ColumnHeader columnHeader5;
		private System.Windows.Forms.Label label7;
		private System.Windows.Forms.TextBox edtFrom;
		private System.Windows.Forms.Label label8;
		private System.Windows.Forms.TextBox edtSubject;
		private System.Windows.Forms.TextBox memBody;
		private CleverComponents.InetSuite.Imap4 imap;
		private CleverComponents.InetSuite.MailMessage mailMessage;
		private CleverComponents.InetSuite.OAuth oAuth;
		private PictureBox pictureBox1;
		private ListBox tvFolders;
		private IContainer components;

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
			this.edtUser = new System.Windows.Forms.TextBox();
			this.label2 = new System.Windows.Forms.Label();
			this.btnLogout = new System.Windows.Forms.Button();
			this.btnLogin = new System.Windows.Forms.Button();
			this.label5 = new System.Windows.Forms.Label();
			this.label6 = new System.Windows.Forms.Label();
			this.lvMessages = new System.Windows.Forms.ListView();
			this.columnHeader2 = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
			this.columnHeader3 = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
			this.columnHeader4 = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
			this.columnHeader5 = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
			this.label7 = new System.Windows.Forms.Label();
			this.edtFrom = new System.Windows.Forms.TextBox();
			this.edtSubject = new System.Windows.Forms.TextBox();
			this.label8 = new System.Windows.Forms.Label();
			this.memBody = new System.Windows.Forms.TextBox();
			this.imap = new CleverComponents.InetSuite.Imap4();
			this.mailMessage = new CleverComponents.InetSuite.MailMessage();
			this.pictureBox1 = new System.Windows.Forms.PictureBox();
			this.tvFolders = new System.Windows.Forms.ListBox();
			this.oAuth = new CleverComponents.InetSuite.OAuth();
			((System.ComponentModel.ISupportInitialize)(this.imap)).BeginInit();
			((System.ComponentModel.ISupportInitialize)(this.mailMessage)).BeginInit();
			((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).BeginInit();
			this.SuspendLayout();
			// 
			// edtUser
			// 
			this.edtUser.Location = new System.Drawing.Point(58, 95);
			this.edtUser.Name = "edtUser";
			this.edtUser.Size = new System.Drawing.Size(124, 20);
			this.edtUser.TabIndex = 4;
			this.edtUser.Text = "user@gmail.com";
			// 
			// label2
			// 
			this.label2.Location = new System.Drawing.Point(12, 98);
			this.label2.Name = "label2";
			this.label2.Size = new System.Drawing.Size(40, 16);
			this.label2.TabIndex = 7;
			this.label2.Text = "User";
			// 
			// btnLogout
			// 
			this.btnLogout.Location = new System.Drawing.Point(529, 91);
			this.btnLogout.Name = "btnLogout";
			this.btnLogout.Size = new System.Drawing.Size(82, 26);
			this.btnLogout.TabIndex = 7;
			this.btnLogout.Text = "Logout";
			this.btnLogout.Click += new System.EventHandler(this.btnLogout_Click);
			// 
			// btnLogin
			// 
			this.btnLogin.Location = new System.Drawing.Point(436, 91);
			this.btnLogin.Name = "btnLogin";
			this.btnLogin.Size = new System.Drawing.Size(82, 26);
			this.btnLogin.TabIndex = 6;
			this.btnLogin.Text = "Login";
			this.btnLogin.Click += new System.EventHandler(this.btnLogin_Click);
			// 
			// label5
			// 
			this.label5.Location = new System.Drawing.Point(12, 131);
			this.label5.Name = "label5";
			this.label5.Size = new System.Drawing.Size(80, 17);
			this.label5.TabIndex = 22;
			this.label5.Text = "GMail Folders";
			// 
			// label6
			// 
			this.label6.Location = new System.Drawing.Point(193, 131);
			this.label6.Name = "label6";
			this.label6.Size = new System.Drawing.Size(64, 17);
			this.label6.TabIndex = 23;
			this.label6.Text = "Messages";
			// 
			// lvMessages
			// 
			this.lvMessages.Columns.AddRange(new System.Windows.Forms.ColumnHeader[] {
            this.columnHeader2,
            this.columnHeader3,
            this.columnHeader4,
            this.columnHeader5});
			this.lvMessages.FullRowSelect = true;
			this.lvMessages.HideSelection = false;
			this.lvMessages.Location = new System.Drawing.Point(196, 151);
			this.lvMessages.Name = "lvMessages";
			this.lvMessages.Size = new System.Drawing.Size(415, 115);
			this.lvMessages.TabIndex = 9;
			this.lvMessages.UseCompatibleStateImageBehavior = false;
			this.lvMessages.View = System.Windows.Forms.View.Details;
			this.lvMessages.SelectedIndexChanged += new System.EventHandler(this.lvMessages_SelectedIndexChanged);
			// 
			// columnHeader2
			// 
			this.columnHeader2.Text = "Subject";
			this.columnHeader2.Width = 100;
			// 
			// columnHeader3
			// 
			this.columnHeader3.Text = "From";
			this.columnHeader3.Width = 100;
			// 
			// columnHeader4
			// 
			this.columnHeader4.Text = "Date";
			this.columnHeader4.Width = 80;
			// 
			// columnHeader5
			// 
			this.columnHeader5.Text = "Size";
			// 
			// label7
			// 
			this.label7.Location = new System.Drawing.Point(193, 282);
			this.label7.Name = "label7";
			this.label7.Size = new System.Drawing.Size(48, 23);
			this.label7.TabIndex = 25;
			this.label7.Text = "From";
			// 
			// edtFrom
			// 
			this.edtFrom.Location = new System.Drawing.Point(247, 279);
			this.edtFrom.Name = "edtFrom";
			this.edtFrom.ReadOnly = true;
			this.edtFrom.Size = new System.Drawing.Size(364, 20);
			this.edtFrom.TabIndex = 10;
			// 
			// edtSubject
			// 
			this.edtSubject.Location = new System.Drawing.Point(247, 306);
			this.edtSubject.Name = "edtSubject";
			this.edtSubject.ReadOnly = true;
			this.edtSubject.Size = new System.Drawing.Size(364, 20);
			this.edtSubject.TabIndex = 11;
			// 
			// label8
			// 
			this.label8.Location = new System.Drawing.Point(193, 309);
			this.label8.Name = "label8";
			this.label8.Size = new System.Drawing.Size(48, 23);
			this.label8.TabIndex = 27;
			this.label8.Text = "Subject";
			// 
			// memBody
			// 
			this.memBody.Location = new System.Drawing.Point(196, 335);
			this.memBody.Multiline = true;
			this.memBody.Name = "memBody";
			this.memBody.ReadOnly = true;
			this.memBody.ScrollBars = System.Windows.Forms.ScrollBars.Both;
			this.memBody.Size = new System.Drawing.Size(415, 106);
			this.memBody.TabIndex = 12;
			// 
			// mailMessage
			// 
			this.mailMessage.Date = new System.DateTime(2007, 1, 10, 13, 51, 45, 827);
			this.mailMessage.From.Email = "";
			this.mailMessage.From.Name = "";
			// 
			// pictureBox1
			// 
			this.pictureBox1.Dock = System.Windows.Forms.DockStyle.Top;
			this.pictureBox1.Image = global::GMailIMAP.Properties.Resources.background_net;
			this.pictureBox1.Location = new System.Drawing.Point(0, 0);
			this.pictureBox1.Name = "pictureBox1";
			this.pictureBox1.Size = new System.Drawing.Size(623, 78);
			this.pictureBox1.SizeMode = System.Windows.Forms.PictureBoxSizeMode.CenterImage;
			this.pictureBox1.TabIndex = 28;
			this.pictureBox1.TabStop = false;
			// 
			// tvFolders
			// 
			this.tvFolders.Location = new System.Drawing.Point(15, 151);
			this.tvFolders.Name = "tvFolders";
			this.tvFolders.Size = new System.Drawing.Size(167, 290);
			this.tvFolders.TabIndex = 8;
			this.tvFolders.SelectedIndexChanged += new System.EventHandler(this.tvFolders_SelectedIndexChanged);
			// 
			// oAuth
			// 
			this.oAuth.AuthUrl = null;
			this.oAuth.ClientID = null;
			this.oAuth.ClientSecret = null;
			this.oAuth.Password = null;
			this.oAuth.RedirectUrl = null;
			this.oAuth.Scope = null;
			this.oAuth.State = null;
			this.oAuth.TokenUrl = null;
			this.oAuth.UserName = null;
			// 
			// Form1
			// 
			this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
			this.ClientSize = new System.Drawing.Size(623, 452);
			this.Controls.Add(this.pictureBox1);
			this.Controls.Add(this.memBody);
			this.Controls.Add(this.edtSubject);
			this.Controls.Add(this.label8);
			this.Controls.Add(this.edtFrom);
			this.Controls.Add(this.label7);
			this.Controls.Add(this.lvMessages);
			this.Controls.Add(this.label6);
			this.Controls.Add(this.label5);
			this.Controls.Add(this.tvFolders);
			this.Controls.Add(this.btnLogout);
			this.Controls.Add(this.btnLogin);
			this.Controls.Add(this.edtUser);
			this.Controls.Add(this.label2);
			this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
			this.Name = "Form1";
			this.Text = "GMAIL IMAP client with OAuth - Sample";
			((System.ComponentModel.ISupportInitialize)(this.imap)).EndInit();
			((System.ComponentModel.ISupportInitialize)(this.mailMessage)).EndInit();
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

		private void tvFolders_SelectedIndexChanged(object sender, System.EventArgs e) {
			if (tvFolders.SelectedIndex > -1 && imap.Active) {
				imap.SelectMailBox(tvFolders.Items[tvFolders.SelectedIndex].ToString());
			}

			FillMessages();
		}

		private void FillMessages() {
			lvMessages.Items.Clear();
			ClearMessage();

			for (int i = 1; i <= imap.CurrentMailBox.ExistsMessages; i++) {
				imap.RetrieveHeader(i, mailMessage);

				ListViewItem item = lvMessages.Items.Add(mailMessage.Subject);
				item.SubItems.Add(mailMessage.From.FullAddress);
				item.SubItems.Add(mailMessage.Date.ToString());
				item.SubItems.Add(imap.GetMessageSize(i).ToString());
				item.SubItems.Add(i.ToString());
			}
		}

		private void ClearMessage() {
			edtFrom.Text = "";
			edtSubject.Text = "";
			memBody.Text = "";
		}

		private void btnLogin_Click(object sender, System.EventArgs e) {
			if(imap.Active) return;

			oAuth.AuthUrl = "https://accounts.google.com/o/oauth2/auth";
			oAuth.TokenUrl = "https://accounts.google.com/o/oauth2/token";
			oAuth.RedirectUrl = "http://localhost";
			oAuth.ClientID = "421475025220-6khpgoldbdsi60fegvjdqk2bk4v19ss2.apps.googleusercontent.com";
			oAuth.ClientSecret = "_4HJyAVUmH_iVrPB8pOJXjR1";
			oAuth.Scope = "https://mail.google.com/";

			imap.Server = "imap.gmail.com";
			imap.Port = 993;
			imap.UseTls = ClientTlsMode.Implicit;

			imap.UserName = edtUser.Text;

			imap.Authorization = oAuth.GetAuthorization();

			imap.Open();

			FillFolderList();
		}

		private void FillFolderList() {
			tvFolders.Items.Clear();
			lvMessages.Items.Clear();

			edtFrom.Text = "";
			edtSubject.Text = "";
			memBody.Text = "";

			string[] mailboxes = imap.GetMailBoxes();

			for (int i = 0; i < mailboxes.Length; i++) {
				string item = mailboxes[i].ToString();
				tvFolders.Items.Add(item);
			}
		}

		private void btnLogout_Click(object sender, System.EventArgs e) {
			imap.Close();
			tvFolders.Items.Clear();
			lvMessages.Items.Clear();
			ClearMessage();
		}

		private void lvMessages_SelectedIndexChanged(object sender, System.EventArgs e) {
			if (imap.Active && lvMessages.SelectedItems.Count > 0) {
				imap.RetrieveMessage(Convert.ToInt32(lvMessages.SelectedItems[0].SubItems[4].Text), mailMessage);

				edtFrom.Text = mailMessage.From.FullAddress;
				edtSubject.Text = mailMessage.Subject;
				memBody.Lines = mailMessage.MessageText;
			}
			else {
				ClearMessage();
			}
		}
	}

	public class ExceptionHandler {
		public void OnThreadException(object sender, System.Threading.ThreadExceptionEventArgs t) {
			MessageBox.Show(t.Exception.Message);
		}
	}
}
