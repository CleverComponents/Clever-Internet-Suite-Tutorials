unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, clMailMessage, clSMimeMessage,
  clTcpClient, clTcpClientTls, clTcpCommandClient, clMC, clSmtp, clCryptApi, Vcl.StdCtrls,
  clCertificateStore, clCertificate, Data.DB;

type
  TForm1 = class(TForm)
    btnSendSigned: TButton;
    clSmtp1: TclSmtp;
    clSMimeMessage1: TclSMimeMessage;
    clCertificateStore1: TclCertificateStore;
    btnSendEncrypted: TButton;
    procedure btnSendSignedClick(Sender: TObject);
    procedure clSMimeMessage1GetSigningCertificate(Sender: TObject;
      var ACertificate: TclCertificate; AExtraCerts: TclCertificateList;
      var Handled: Boolean);
    procedure btnSendEncryptedClick(Sender: TObject);
    procedure clSMimeMessage1GetEncryptionCertificate(Sender: TObject;
      var ACertificate: TclCertificate; AExtraCerts: TclCertificateList;
      var Handled: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnSendEncryptedClick(Sender: TObject);
begin
  //composing a new message
  clSMimeMessage1.BuildMessage('The message text...', 'HTML content...');
  clSMimeMessage1.Subject := 'Subject line follows here';
  clSMimeMessage1.From.FullAddress := 'sender@domain.com';
  clSMimeMessage1.ToList.Clear();
  clSMimeMessage1.ToList.Add('recipient@another.com');

  //configuring the encryption parameters
  clSMimeMessage1.Config.EncryptAlgorithm := szOID_NIST_AES128_CBC;
  clSMimeMessage1.Config.SMimeVersion := clSMime32;

  //encrypting the message
  clSMimeMessage1.Encrypt();

  //configuring the SMTP connection
  clSmtp1.Server := 'smtp.mailhost.com';
  clSmtp1.UserName := 'sender@domain.com';
  clSmtp1.Password := 'secret';

  //sending the message
  clSmtp1.Open();
  clSmtp1.Send(clSMimeMessage1);
  clSmtp1.Close();
end;

procedure TForm1.btnSendSignedClick(Sender: TObject);
begin
  //composing a new message
  clSMimeMessage1.BuildMessage('The message text...', 'HTML content...');
  clSMimeMessage1.Subject := 'Subject line follows here';
  clSMimeMessage1.From.FullAddress := 'sender@domain.com';
  clSMimeMessage1.ToList.Clear();
  clSMimeMessage1.ToList.Add('recipient@another.com');

  //configuring the signature parameters
  clSMimeMessage1.Config.SignAlgorithm := szOID_RSA_SHA512RSA;
  clSMimeMessage1.Config.SMimeVersion := clSMime32;

  //signing the message
  clSMimeMessage1.Sign();

  //configuring the SMTP connection
  clSmtp1.Server := 'smtp.mailhost.com';
  clSmtp1.UserName := 'sender@domain.com';
  clSmtp1.Password := 'secret';

  //sending the message
  clSmtp1.Open();
  clSmtp1.Send(clSMimeMessage1);
  clSmtp1.Close();
end;

procedure TForm1.clSMimeMessage1GetEncryptionCertificate(Sender: TObject;
  var ACertificate: TclCertificate; AExtraCerts: TclCertificateList;
  var Handled: Boolean);
begin
  //loading the encryption certificate -
  //the public-key certificate that belongs to the message recipient
  ACertificate := clCertificateStore1.CertificateByEmail('recipient@another.com');
  Handled := True;
end;

procedure TForm1.clSMimeMessage1GetSigningCertificate(Sender: TObject;
  var ACertificate: TclCertificate; AExtraCerts: TclCertificateList;
  var Handled: Boolean);
begin
  //loading the signing certificate -
  //the private-key certificate that belongs to the message sender
  ACertificate := clCertificateStore1.CertificateByEmail('sender@domain.com');
  Handled := True;
end;

end.

