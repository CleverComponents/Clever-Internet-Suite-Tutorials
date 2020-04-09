unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, clOAuth, clHttpRequest,
  Vcl.OleCtrls, SHDocVw, MSHTML;

type
  TForm1 = class(TForm)
    clOAuth1: TclOAuth;
    btnAuthorize: TButton;
    clHttpRequest1: TclHttpRequest;
    WebBrowser1: TWebBrowser;
    procedure btnAuthorizeClick(Sender: TObject);
    procedure clOAuth1ShowEnterCodeForm(Sender: TObject;
      var AuthorizationCode: string; var Handled: Boolean);
    procedure clOAuth1LaunchBrowser(Sender: TObject; const AUrl: string;
      var Handled: Boolean);
    procedure WebBrowser1DocumentComplete(ASender: TObject;
      const pDisp: IDispatch; const URL: OleVariant);
  private
    FBrowserReady: THandle;
    procedure WaitForWebBrowser(ATimeOut: Integer);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnAuthorizeClick(Sender: TObject);
var
  s: string;
begin
  clOAuth1.AuthorizationEndPoint := apEnterCodeForm;

  clOAuth1.AuthUrl := 'http://oauth.vk.com/authorize';
  clOAuth1.TokenUrl := 'https://oauth.vk.com/access_token';
  clOAuth1.RedirectUrl := 'https://oauth.vk.com/blank.html';
  clOAuth1.ClientID := '6693820';
  clOAuth1.ClientSecret := '9TNejLa8GyigUu0FING5';
  clOAuth1.Scope := 'photos';

  s := clOAuth1.GetAuthorization();

  ShowMessage(s);
end;

procedure TForm1.clOAuth1LaunchBrowser(Sender: TObject; const AUrl: string;
  var Handled: Boolean);
begin
  WebBrowser1.Navigate(AUrl);
  Handled := True;
end;

procedure TForm1.clOAuth1ShowEnterCodeForm(Sender: TObject;
  var AuthorizationCode: string; var Handled: Boolean);
var
  doc: IHTMLDocument2;
  path: string;
  ind: Integer;
begin
  repeat
    WaitForWebBrowser(60000);

    doc := (WebBrowser1.Document as IHTMLDocument2);
    path := string(doc.url);
  until (Pos('https://oauth.vk.com/blank.html', path) = 1);

  path := string(doc.location.href);

  ind := Pos('code=', path);
  if (ind > 0) then
  begin
    path := Copy(path, ind + Length('code='), MaxInt);
    AuthorizationCode := path;
  end;

  Handled := True;
end;

constructor TForm1.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FBrowserReady := CreateEvent(nil, False, False, nil);
end;

destructor TForm1.Destroy;
begin
  CloseHandle(FBrowserReady);
  inherited Destroy();
end;

procedure TForm1.WaitForWebBrowser(ATimeOut: Integer);
var
  res, eventCount: DWORD;
  Msg: TMsg;
  events: array[0..0] of THandle;
begin
  events[0] := FBrowserReady;
  eventCount := 1;

  repeat
    res := MsgWaitForMultipleObjects(eventCount, events, FALSE, DWORD(ATimeOut), QS_ALLEVENTS);
    if (WAIT_FAILED = res) then
    begin
      raise Exception.CreateFmt('Error occurred: %d', [GetLastError()]);
    end;

    if (WAIT_TIMEOUT = res) then
    begin
      raise Exception.Create('Timeout occurred');
    end;

    if ((WAIT_OBJECT_0 + eventCount) = res) then
    begin
      while PeekMessage(Msg, 0, 0, 0, PM_REMOVE) do
      begin
        TranslateMessage(Msg);
        DispatchMessage(Msg);
      end;
    end;
  until (WAIT_OBJECT_0 = res);
end;

procedure TForm1.WebBrowser1DocumentComplete(ASender: TObject;
  const pDisp: IDispatch; const URL: OleVariant);
begin
  SetEvent(FBrowserReady);
end;

end.
