unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, clTcpClient,
  clTcpClientTls, clTcpCommandClient, clMC, clPop3, clOAuth, clMailMessage, MessageForm;

type
  TForm1 = class(TForm)
    Label2: TLabel;
    edtUser: TEdit;
    lbMessages: TListBox;
    btnGetMessageList: TButton;
    Label3: TLabel;
    clOAuth1: TclOAuth;
    clPop31: TclPop3;
    clMailMessage1: TclMailMessage;
    procedure btnGetMessageListClick(Sender: TObject);
    procedure lbMessagesDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnGetMessageListClick(Sender: TObject);
begin
  // Microsoft Identity Platform v2.0 endpoints
  clOAuth1.AuthUrl := 'https://login.microsoftonline.com/common/oauth2/v2.0/authorize';
  clOAuth1.TokenUrl := 'https://login.microsoftonline.com/common/oauth2/v2.0/token';
  clOAuth1.RedirectUrl := 'http://localhost';

  // Use your registered App Client ID and Client Secret from Azure AD
  clOAuth1.ClientID := 'a0a907aa-1e38-4bdb-8764-c4f931051018'; // Replace with your Client ID
  clOAuth1.ClientSecret := '6FYd=PdPS-06UgOdNlFon2TXo*BDyAi-'; // Replace with your Client Secret

  // Microsoft Graph API scope with offline access for token refresh
  clOAuth1.Scope := 'https://outlook.office.com/POP.AccessAsUser.All offline_access';

  // Office365 POP3 server
  clPop31.Server := 'outlook.office365.com';
  clPop31.Port := 995;
  clPop31.UseTLS := ctImplicit;

  clPop31.UserName := edtUser.Text;

  // Get OAuth 2.0 authorization token (will cache it if already authenticated)
  clPop31.Authorization := clOAuth1.GetAuthorization();

  // Clear message list
  lbMessages.Items.Clear();

  // Connect to POP3 server
  clPop31.Open();
  try
    // Get UID list
    clPop31.GetUIDList(lbMessages.Items);
  finally
    clPop31.Close();
    // Don't close OAuth to keep the token for future use
  end;
end;

procedure TForm1.lbMessagesDblClick(Sender: TObject);
var
  msgIndex: Integer;
begin
  if lbMessages.ItemIndex < 0 then Exit;

  // Message index = list index + 1 (POP3 uses 1-based indexing)
  msgIndex := lbMessages.ItemIndex + 1;

  // Reconnect for this operation
  // OAuth token is already cached in clOAuth1
  clPop31.Authorization := clOAuth1.GetAuthorization();
  clPop31.Open();

  try
    // Retrieve message by index
    clPop31.Retrieve(msgIndex, clMailMessage1);

    frmMessage.ShowMessage(clMailMessage1);

  finally
    clPop31.Close();
  end;
end;

end.
