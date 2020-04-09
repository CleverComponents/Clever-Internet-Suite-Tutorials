namespace SmtpServerService {
	partial class Service1 {
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

		#region Component Designer generated code

		/// <summary> 
		/// Required method for Designer support - do not modify 
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent() {
			this.components = new System.ComponentModel.Container();
			CleverComponents.InetSuite.MailUserAccountItem mailUserAccountItem3 = new CleverComponents.InetSuite.MailUserAccountItem();
			this.smtpServer1 = new CleverComponents.InetSuite.SmtpServer();
			this.smtpRelay1 = new CleverComponents.InetSuite.SmtpRelay();
			this.smtpFileHandler1 = new CleverComponents.InetSuite.SmtpFileHandler();
			this.timer1 = new System.Windows.Forms.Timer(this.components);
			// 
			// smtpServer1
			// 
			this.smtpServer1.HelpText = new string[] {
        "Commands Supported:",
        "HELO EHLO AUTH HELP QUIT MAIL NOOP RSET RCPT DATA STARTTLS"};
			this.smtpServer1.Port = 25;
			this.smtpServer1.ServerName = "Clever Internet Suite SMTP service";
			mailUserAccountItem3.DisplayName = "Clever Tester";
			mailUserAccountItem3.Email = "CleverTester@company.mail";
			mailUserAccountItem3.Password = "clevertester";
			mailUserAccountItem3.UserName = "CleverTester";
			this.smtpServer1.UserAccounts.AddRange(new CleverComponents.InetSuite.UserAccountItem[] {
            mailUserAccountItem3});
			// 
			// smtpRelay1
			// 
			this.smtpRelay1.DnsServer = null;
			this.smtpRelay1.Port = 25;
			// 
			// smtpFileHandler1
			// 
			this.smtpFileHandler1.MailBoxDir = "C:\\CleverMailBox\\";
			this.smtpFileHandler1.RelayDir = "C:\\CleverMailBox\\RelayQueue\\";
			this.smtpFileHandler1.Server = this.smtpServer1;
			// 
			// timer1
			// 
			this.timer1.Tick += new System.EventHandler(this.timer1_Tick);
			// 
			// Service1
			// 
			this.ServiceName = "Clever SMTP Service";

		}

		#endregion

		private CleverComponents.InetSuite.SmtpServer smtpServer1;
		private CleverComponents.InetSuite.SmtpRelay smtpRelay1;
		private CleverComponents.InetSuite.SmtpFileHandler smtpFileHandler1;
		private System.Windows.Forms.Timer timer1;
	}
}
