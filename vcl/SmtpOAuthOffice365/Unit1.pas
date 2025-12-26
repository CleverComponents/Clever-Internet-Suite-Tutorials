unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, clMailMessage,
  clTcpClient, clTcpClientTls, clTcpCommandClient, clMC, clSmtp, clOAuth, clEncoder;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    edtServer: TEdit;
    Label2: TLabel;
    edtFrom: TEdit;
    Label3: TLabel;
    edtTo: TEdit;
    Label4: TLabel;
    edtSubject: TEdit;
    memText: TMemo;
    btnSend: TButton;
    clOAuth1: TclOAuth;
    clSmtp1: TclSmtp;
    clMailMessage1: TclMailMessage;
    procedure btnSendClick(Sender: TObject);
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

  clOAuth1.AuthUrl := 'https://login.microsoftonline.com/common/oauth2/v2.0/authorize';
  clOAuth1.TokenUrl := 'https://login.microsoftonline.com/common/oauth2/v2.0/token';
  clOAuth1.RedirectUrl := 'http://localhost';

  // Use your registered App Client ID and Client Secret from Azure AD
  clOAuth1.ClientID := 'a0a907aa-1e38-4bdb-8764-c4f931051018'; // Replace with your Client ID
  clOAuth1.ClientSecret := '6FYd=PdPS-06UgOdNlFon2TXo*BDyAi-'; // Replace with your Client Secret

  clOAuth1.Scope := 'https://outlook.office.com/SMTP.Send offline_access';

  clSmtp1.Server := edtServer.Text;
  clSmtp1.Port := 587;
  clSmtp1.UseTLS := ctExplicit;

  clSmtp1.UserName := edtFrom.Text;

  clSmtp1.Authorization := clOAuth1.GetAuthorization();

  clSmtp1.Open();
  try
    clMailMessage1.CharSet := 'utf-8';
    clMailMessage1.Encoding := cmQuotedPrintable;
    clMailMessage1.BuildMessage(memText.Text, '');
    clMailMessage1.From.FullAddress := edtFrom.Text;
    clMailMessage1.ToList.EmailAddresses := edtTo.Text;
    clMailMessage1.Subject := edtSubject.Text;

    clSmtp1.Send(clMailMessage1);
  finally
    clSmtp1.Close();
  end;

  ShowMessage('The message was sent successfully.');
end;

end.
