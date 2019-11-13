unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, clTcpClient, clHttp, clHtmlParser, clFirewallUtils,
  clTcpClientTls, clWinInet, clUtils, clUriUtils;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    memResult: TMemo;
    Label1: TLabel;
    edtUrl: TEdit;
    Label2: TLabel;
    btnGet: TButton;
    clHttp1: TclHttp;
    clHtmlParser1: TclHtmlParser;
    cbShowText: TCheckBox;
    Label3: TLabel;
    edtUser: TEdit;
    Label4: TLabel;
    edtPassword: TEdit;
    Bevel1: TBevel;
    Label5: TLabel;
    edtProxyServer: TEdit;
    Label6: TLabel;
    edtProxyPort: TEdit;
    Label7: TLabel;
    edtProxyUser: TEdit;
    Label8: TLabel;
    edtProxyPassword: TEdit;
    cbProxyType: TComboBox;
    Label9: TLabel;
    btnGetIEProxy: TButton;
    procedure btnGetClick(Sender: TObject);
    procedure clHtmlParser1ParseTag(Sender: TObject; ATag: TclHtmlTag);
    procedure cbProxyTypeChange(Sender: TObject);
    procedure btnGetIEProxyClick(Sender: TObject);
  private
    procedure GetIEProxySettings(AList: TStrings);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.GetIEProxySettings(AList: TStrings);
var
  pInfo: PInternetProxyInfo;
  len: DWORD;
begin
  AList.Clear();

  len := 0;
  InternetQueryOption(nil, INTERNET_OPTION_PROXY, nil, len);
  if (len > 0) then
  begin
    GetMem(pInfo, len);
    try
      if InternetQueryOption(nil, INTERNET_OPTION_PROXY, pInfo, len) then
      begin
        SplitText(string(pInfo.lpszProxy), AList, ' ');
      end;
    finally
      FreeMem(pInfo);
    end;
  end;
end;

procedure TForm1.btnGetIEProxyClick(Sender: TObject);
var
  proxyList: TStrings;
  proxy: string;
  url: TclUrlParser;
begin
  proxyList := TStringList.Create();
  try
    GetIEProxySettings(proxyList);

    if (proxyList.Count = 1) then
    begin
      proxy := proxyList[0];
    end else
    if cbProxyType.ItemIndex = 0 then
    begin
      url := TclUrlParser.Create();
      try
        url.Parse(edtUrl.Text);

        if (url.UrlType = utHTTPS) then
        begin
          proxy := proxyList.Values['https'];
        end else
        begin
          proxy := proxyList.Values['http'];
        end;
      finally
        url.Free();
      end;
    end else
    begin
      proxy := proxyList.Values['socks'];
    end;

    if WordCount(proxy, [':']) > 1 then
    begin
      edtProxyServer.Text := ExtractWord(1, proxy, [':']);
      edtProxyPort.Text := ExtractWord(2, proxy, [':']);
    end else
    begin
      edtProxyServer.Text := proxy;
      edtProxyPort.Text := '8080';
    end;
  finally
    proxyList.Free();
  end;
end;

procedure TForm1.btnGetClick(Sender: TObject);
var
  html: TStrings;
begin
  memResult.Lines.Clear();

  html := TStringList.Create();
  try
    clHttp1.UserName := edtUser.Text;
    clHttp1.Password := edtPassword.Text;

    clHttp1.FirewallSettings.Server := '';
    clHttp1.ProxySettings.Server := '';

    if cbProxyType.ItemIndex = 0 then
    begin
      clHttp1.ProxySettings.Server := edtProxyServer.Text;
      clHttp1.ProxySettings.Port := StrToIntDef(edtProxyPort.Text, 8080);
      clHttp1.ProxySettings.UserName := edtProxyUser.Text;
      clHttp1.ProxySettings.Password := edtProxyPassword.Text;
    end else
    begin
      if cbProxyType.ItemIndex = 1 then
      begin
        clHttp1.FirewallSettings.FirewallType := ftSocks4;
      end else
      begin
        clHttp1.FirewallSettings.FirewallType := ftSocks5;
      end;

      clHttp1.FirewallSettings.Server := edtProxyServer.Text;
      clHttp1.FirewallSettings.Port := StrToInt(edtProxyPort.Text);
      clHttp1.FirewallSettings.UserName := edtProxyUser.Text;
      clHttp1.FirewallSettings.Password := edtProxyPassword.Text;
    end;

    clHttp1.Get(edtUrl.Text, html);

    if cbShowText.Checked then
    begin
      clHtmlParser1.Parse(html);
    end else
    begin
      memResult.Lines.Assign(html);
    end;
  finally
    html.Free();
  end;
end;

procedure TForm1.cbProxyTypeChange(Sender: TObject);
begin
  case cbProxyType.ItemIndex of
    0: edtProxyPort.Text := '8080';
    1, 2: edtProxyPort.Text := '1080';
  end;
end;

procedure TForm1.clHtmlParser1ParseTag(Sender: TObject; ATag: TclHtmlTag);
begin
  if (Trim(ATag.Text) <> '') then
  begin
    memResult.Lines.Add(ATag.Text);
  end;
end;

end.
