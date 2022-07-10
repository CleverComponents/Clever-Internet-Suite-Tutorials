unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, clMailMessage,
  clTcpClient, clTcpClientTls, clTcpCommandClient, clMC, clSmtp, clOAuth;

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
  if (clSmtp1.Active or clOAuth1.Active) then Exit;

  clOAuth1.AuthUrl := 'https://login.live.com/oauth20_authorize.srf';
  clOAuth1.TokenUrl := 'https://login.live.com/oauth20_token.srf';
  clOAuth1.RedirectUrl := 'http://localhost';

  //Use both Client ID and Client Secret from the Azure Active Directory for your app.
  clOAuth1.ClientID := 'a0a907aa-1e38-4bdb-8764-c4f931051018';
  clOAuth1.ClientSecret := '6FYd=PdPS-06UgOdNlFon2TXo*BDyAi-';

  clOAuth1.Scope := 'https://outlook.office.com/SMTP.Send';

  clSmtp1.Server := edtServer.Text;
  clSmtp1.Port := 587;
  clSmtp1.UseTLS := ctExplicit;

  clSmtp1.UserName := edtFrom.Text;

  clSmtp1.Authorization := clOAuth1.GetAuthorization();

  clSmtp1.Open();
  try
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
