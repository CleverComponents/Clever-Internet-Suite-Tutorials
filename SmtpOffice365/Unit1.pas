unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, clMailMessage, clTcpClient, clTcpClientTls, clMC, clSmtp, clCertificate, UITypes,
  clTcpCommandClient;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    edtServer: TEdit;
    Label2: TLabel;
    edtPort: TEdit;
    Label3: TLabel;
    edtUser: TEdit;
    Label4: TLabel;
    edtPassword: TEdit;
    Label6: TLabel;
    edtTo: TEdit;
    Label7: TLabel;
    edtSubject: TEdit;
    memBody: TMemo;
    btnSend: TButton;
    clSmtp1: TclSmtp;
    clMailMessage1: TclMailMessage;
    procedure btnSendClick(Sender: TObject);
    procedure clSmtp1VerifyServer(Sender: TObject; ACertificate: TclCertificate; const AStatusText: string; AStatusCode: Integer;
      var AVerified: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnSendClick(Sender: TObject);
begin
  if (clSmtp1.Active) then Exit;

  clSmtp1.Server := edtServer.Text;
  clSmtp1.Port := StrToInt(edtPort.Text);

  clSmtp1.UserName := edtUser.Text;
  clSmtp1.Password := edtPassword.Text;

  clSmtp1.UseTLS := ctExplicit;

  clSmtp1.Open();
  try
    clMailMessage1.BuildMessage(memBody.Text, '');
    clMailMessage1.From.FullAddress := edtUser.Text;
    clMailMessage1.ToList.EmailAddresses := edtTo.Text;
    clMailMessage1.Subject := edtSubject.Text;

    clSmtp1.Send(clMailMessage1);

    ShowMessage('The message was sent successfully.');
  finally
    clSmtp1.Close();
  end;
end;

procedure TForm1.clSmtp1VerifyServer(Sender: TObject; ACertificate: TclCertificate; const AStatusText: string;
  AStatusCode: Integer; var AVerified: Boolean);
begin
  if not AVerified and (MessageDlg(AStatusText + #13#10' Do you wish to proceed ?',
    mtWarning, [mbYes, mbNo], 0) = mrYes) then
  begin
    AVerified := True;
  end;
end;

end.
