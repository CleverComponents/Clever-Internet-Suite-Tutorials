unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, UITypes,
  Graphics, Controls, Forms, Dialogs, StdCtrls, clCertificateStore, clCertificate,
  clTcpClient, clTcpClientTls, clTcpCommandClient, clMC, clSmtp, clMailMessage,
  clSMimeMessage, ComCtrls, clCryptAPI;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    edtFrom: TEdit;
    Label2: TLabel;
    edtRecipient: TEdit;
    Label3: TLabel;
    edtSubject: TEdit;
    memText: TMemo;
    cbSign: TCheckBox;
    Label5: TLabel;
    cbCertificateSource: TComboBox;
    Label6: TLabel;
    edtCertificateFileName: TEdit;
    btnSelectCertificateFile: TButton;
    Label7: TLabel;
    cbCertificate: TComboBox;
    Label8: TLabel;
    edtSmtpHost: TEdit;
    Label9: TLabel;
    edtSmtpPort: TEdit;
    Label10: TLabel;
    edtSmtpUser: TEdit;
    Label11: TLabel;
    edtSmtpPassword: TEdit;
    btnSend: TButton;
    OpenDialog1: TOpenDialog;
    clSMimeMessage1: TclSMimeMessage;
    clSmtp1: TclSmtp;
    clCertificateStore1: TclCertificateStore;
    ProgressBar1: TProgressBar;
    Label12: TLabel;
    edtCertificatePassword: TEdit;
    btnLoadCertificate: TButton;
    procedure cbSignClick(Sender: TObject);
    procedure cbCertificateSourceChange(Sender: TObject);
    procedure btnSelectCertificateFileClick(Sender: TObject);
    procedure btnLoadCertificateClick(Sender: TObject);
    procedure btnSendClick(Sender: TObject);
    procedure clSMimeMessage1GetSigningCertificate(Sender: TObject;
      var ACertificate: TclCertificate; AExtraCerts: TclCertificateList;
      var Handled: Boolean);
    procedure clSmtp1Progress(Sender: TObject; ABytesProceed,
      ATotalBytes: Int64);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.cbSignClick(Sender: TObject);
begin
  cbCertificateSource.Enabled := cbSign.Checked;
  btnLoadCertificate.Enabled := cbSign.Checked;
  cbCertificate.Enabled := cbSign.Checked;

  cbCertificateSourceChange(nil);
end;

procedure TForm1.clSMimeMessage1GetSigningCertificate(Sender: TObject;
  var ACertificate: TclCertificate; AExtraCerts: TclCertificateList;
  var Handled: Boolean);
begin
  ACertificate := clCertificateStore1.Items[cbCertificate.ItemIndex];
  Handled := True;
end;

procedure TForm1.clSmtp1Progress(Sender: TObject; ABytesProceed, ATotalBytes: Int64);
begin
  if (ATotalBytes > 0) then
  begin
    ProgressBar1.Position := Round(ABytesProceed * ProgressBar1.Max / ATotalBytes);
  end;
end;

procedure TForm1.cbCertificateSourceChange(Sender: TObject);
begin
  edtCertificateFileName.Enabled := (cbCertificateSource.ItemIndex = 0);
  btnSelectCertificateFile.Enabled := edtCertificateFileName.Enabled;
  edtCertificatePassword.Enabled := edtCertificateFileName.Enabled;
end;

procedure TForm1.btnSelectCertificateFileClick(Sender: TObject);
begin
  if OpenDialog1.Execute() then
  begin
    edtCertificateFileName.Text := OpenDialog1.FileName;
  end;
end;

procedure TForm1.btnSendClick(Sender: TObject);
var
  certificate: TclCertificate;
begin
  //build message

  clSMimeMessage1.BuildMessage(memText.Lines.Text, '');

  clSMimeMessage1.Subject := edtSubject.Text;
  clSMimeMessage1.From.FullAddress := edtFrom.Text;
  clSMimeMessage1.ToList.EmailAddresses := edtRecipient.Text;

  if (cbSign.Checked) then
  begin
  //validate certificate

    if (cbCertificate.ItemIndex < 0) then
    begin
      raise Exception.Create('The signing certificate is not specified');
    end;

    certificate := clCertificateStore1.Items[cbCertificate.ItemIndex];

    if (certificate.Email <> clSMimeMessage1.From.Email) then
    begin
      if (MessageDlg('The signing certificate E-mail address does not match the E-mail sender. Continue anyway?',
        mtConfirmation, [mbYes, mbNo], 0) <> mrYes) then
      begin
        Exit;
      end;
    end;

    if not clCertificateStore1.Verify(certificate) then
    begin
      if (MessageDlg('The certificate is not suitable for signing. Continue anyway?',
        mtConfirmation, [mbYes, mbNo], 0) <> mrYes) then
      begin
        Exit;
      end;
    end;

  //sign message

    clSMimeMessage1.Sign();
  end;

  //send message

  clSmtp1.Server := edtSmtpHost.Text;
  clSmtp1.Port := StrToInt(edtSmtpPort.Text);
  clSmtp1.UserName := edtSmtpUser.Text;
  clSmtp1.Password := edtSmtpPassword.Text;

  ProgressBar1.Position := 0;

  clSmtp1.Open();
  try
    clSmtp1.Send(clSMimeMessage1);
  finally
    clSmtp1.Close();
  end;

  ProgressBar1.Position := 100;

  ShowMessage('The E-mail was sent successfully.');
end;

procedure TForm1.btnLoadCertificateClick(Sender: TObject);
var
  i: Integer;
begin
  clCertificateStore1.Close();
  cbCertificate.Clear();

  case cbCertificateSource.ItemIndex of
    0: clCertificateStore1.ImportFromPFX(edtCertificateFileName.Text, edtCertificatePassword.Text);
    1: clCertificateStore1.Open('MY');
  end;

  for i := 0 to clCertificateStore1.Items.Count - 1 do
  begin
    if (clCertificateStore1.Items[i].FriendlyName <> '') then
    begin
      cbCertificate.Items.Add(clCertificateStore1.Items[i].FriendlyName);
    end else
    begin
      cbCertificate.Items.Add(clCertificateStore1.Items[i].IssuedTo);
    end;
  end;

  if (cbCertificate.Items.Count > 0) then
  begin
    cbCertificate.ItemIndex := 0;
  end;
end;

end.
