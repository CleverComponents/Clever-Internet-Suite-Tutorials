unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, clTcpClient, clHttp, SHDocVw, ExtCtrls, mshtml, clUtils,
  clCookies;

type
  TForm1 = class(TForm)
    btnLogin: TButton;
    clHttp1: TclHttp;
    Panel1: TPanel;
    btnGetCookie: TButton;
    Memo1: TMemo;
    btnSubmit: TButton;
    clCookieManager1: TclCookieManager;
    Label1: TLabel;
    edtURL: TEdit;
    procedure btnLoginClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnGetCookieClick(Sender: TObject);
    procedure btnSubmitClick(Sender: TObject);
  private
    FWeb: TWebBrowser;
    procedure GetHttpOnlyCookie(const AUrl: string; ACookies: TStrings);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.GetHttpOnlyCookie(const AUrl: string; ACookies: TStrings);
  procedure AddTextStr_(AList: TStrings; const Value: string);
  var
    P, Start: PAnsiChar;
    S: string;
  begin
    AList.BeginUpdate();
    try
      P := PAnsiChar(Value);
      if P <> nil then
        while P^ <> #0 do
        begin
          Start := P;
          while not (P^ in [#0, #32, #59]) do Inc(P);
          SetString(S, Start, P - Start);
          AList.Add(string(S));
          if P^ = #59 then Inc(P);
          if P^ = #32 then Inc(P);
        end;
    finally
      AList.EndUpdate();
    end;
  end;


const
  INTERNET_COOKIE_HTTPONLY = 8192;
var
  hModule: THandle;
  InternetGetCookieEx: function(lpszUrl, lpszCookieName, lpszCookieData
    : PAnsiChar; var lpdwSize: DWORD; dwFlags: DWORD; lpReserved: pointer)
    : BOOL; stdCall;
  CookieSize: DWORD;
  CookieData: PAnsiChar;
begin
  LoadLibrary('wininet.dll');
  hModule := GetModuleHandle('wininet.dll');
  if (hModule <> 0) then
  begin
    @InternetGetCookieEx := GetProcAddress(hModule, 'InternetGetCookieExA');
    if (@InternetGetCookieEx <> nil) then
    begin
      CookieSize := 1024;
      Cookiedata := AllocMem(CookieSize);
      try
        if InternetGetCookieEx(PAnsiChar(AUrl), nil, Cookiedata, CookieSize, INTERNET_COOKIE_HTTPONLY, nil) then
        begin
          AddTextStr_(ACookies, string(cookiedata));
        end;
      finally
        FreeMem(Cookiedata);
      end;
    end;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FWeb := TWebBrowser.Create(Self);
  FWeb.ParentWindow := Self.WindowHandle;
  FWeb.Width := Panel1.Width;
  FWeb.Height := Panel1.Height;
  FWeb.Top := Panel1.Top;
  FWeb.Left := Panel1.Left;
  Panel1.Visible := False;
end;

procedure TForm1.btnLoginClick(Sender: TObject);
begin
  FWeb.Navigate(WideString(edtURL.Text));
end;

procedure TForm1.btnGetCookieClick(Sender: TObject);
var
  doc: IHTMLDocument2;
  i: Integer;
begin
  doc := FWeb.Document as IHTMLDocument2;

  Memo1.Lines.Clear();
  GetHttpOnlyCookie(string(doc.url), Memo1.Lines);

  clCookieManager1.Clear();
  for i := 0 to Memo1.Lines.Count - 1 do
  begin
    clCookieManager1.Cookies.Add(Memo1.Lines.Names[i], Memo1.Lines.Values[Memo1.Lines.Names[i]], string(doc.url));
  end;
end;

procedure TForm1.btnSubmitClick(Sender: TObject);
var
  doc: IHTMLDocument2;
begin
  doc := FWeb.Document as IHTMLDocument2;

  Memo1.Lines.Clear();
  clHttp1.Get(string(doc.url), Memo1.Lines);
end;

end.
