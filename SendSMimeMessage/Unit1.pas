unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, clCertificateStore,
  clMailMessage, clSMimeMessage, clTcpClient, clTcpClientTls,
  clTcpCommandClient, clMC, clSmtp, clCertificate;


type
  TForm1 = class(TForm)
    Label2: TLabel;
    Label3: TLabel;
    edtSubject: TEdit;
    edtToList: TEdit;
    memMessage: TMemo;
    Label7: TLabel;
    Label6: TLabel;
    Port: TLabel;
    Server: TLabel;
    edtServer: TEdit;
    edtPort: TEdit;
    edtUserName: TEdit;
    edtPassword: TEdit;
    btnSend: TButton;
    clSmtp1: TclSmtp;
    clSMimeMessage1: TclSMimeMessage;
    CertificateSender: TclCertificateStore;
    CertificateRecipient: TclCertificateStore;
    procedure btnSendClick(Sender: TObject);
    procedure clSMimeMessage1GetEncryptionCertificate(Sender: TObject;
      var ACertificate: TclCertificate; AExtraCerts: TclCertificateList;
      var Handled: Boolean);
    procedure clSMimeMessage1GetSigningCertificate(Sender: TObject;
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

//1. You must have certificates installed for both the message sender and for the message recipients.
//The sender's certificate must have a private key.
//It should be installed in the "Personal" Windows storage (MY), "Current User" location.
//This certificate is used for signing the message.
//The recipients' certificates should be installed in the "Other People" storage (addressbook), "Current User" location.
//These certificates must not necessarily have a private key. They are used for encrypting the message.
//The sender's certificate must provide the same Email address as the message sender address.
//The same for the message recipients. The Email address is used to find a corresponding ceriticate in the storage.
procedure TForm1.btnSendClick(Sender: TObject);
begin
  clSmtp1.Server := edtServer.Text;
  clSmtp1.Port := StrToInt(edtPort.Text);
  clSmtp1.UseTLS := ctImplicit;
  clSmtp1.UserName := edtUserName.Text;
  clSmtp1.Password := edtPassword.Text;

  clSMimeMessage1.BuildMessage(memMessage.Text, '');
  clSMimeMessage1.Subject := edtSubject.Text;
  clSMimeMessage1.From.FullAddress := clSmtp1.UserName;
  clSMimeMessage1.ToList.EmailAddresses := edtToList.Text;

  clSMimeMessage1.Sign();
  clSMimeMessage1.Encrypt();

  clSmtp1.Open();
  clSmtp1.Send(clSMimeMessage1);
  clSmtp1.Close();

  ShowMessage('Done');
end;

//2. If neccessary certificates are not installed in Windows,
//use the following two events to load certificates from files:
//a private-key sender's certificate and public-key certificates for message recipients:
//OnGetSigningCertificate and OnGetEncryptionCertificate.
//You can use the TclCertificateStore component to import certificates from a file.

procedure TForm1.clSMimeMessage1GetEncryptionCertificate(Sender: TObject;
  var ACertificate: TclCertificate; AExtraCerts: TclCertificateList;
  var Handled: Boolean);
var
 i: Integer;
begin
  if(CertificateRecipient.Items.Count = 0) then
  begin
    CertificateSender.ImportFromCER('resipient.cer');
  end;

  if(clSMimeMessage1.ToList.Count > 0) then
  begin
    ACertificate := CertificateRecipient.CertificateByEmail(clSMimeMessage1.ToList[0].Email);
  end;

  for i := 1 to clSMimeMessage1.ToList.Count - 1 do
    begin
      AExtraCerts.Add(CertificateRecipient.CertificateByEmail(clSMimeMessage1.ToList[i].Email));
    end;

    Handled := True;
end;

procedure TForm1.clSMimeMessage1GetSigningCertificate(Sender: TObject;
  var ACertificate: TclCertificate; AExtraCerts: TclCertificateList;
  var Handled: Boolean);
begin
  if(CertificateSender.Items.Count = 0) then
  begin
    CertificateSender.ImportFromPFX('sender.pfx', 'secret');
  end;

  ACertificate := CertificateSender.FindByEmail(clSMimeMessage1.From.Email, True);
  Handled := True;
end;

end.
