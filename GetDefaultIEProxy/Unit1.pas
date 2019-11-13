unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, clWinInet;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  proxy: PInternetProxyInfo;
  proxyBuf: Pointer;
  proxyBufLen: DWORD;
  b: BOOL;
  s: string;
begin
  proxyBufLen := 4096;
  GetMem(proxyBuf, proxyBufLen);
  try
    b := InternetQueryOption(nil, INTERNET_OPTION_PROXY, proxyBuf, proxyBufLen);
    if not b then raise Exception.Create('Failed to get proxy info');
    proxy := PInternetProxyInfo(proxyBuf);

    s := PChar(proxy.lpszProxy);
    //returns for separated settings: 'https=localhost:8081 http=localhost:8080 gopher=localhost:8080 ftp=192.168.19.10:8080 socks=212.12.0.1:1080'
    //returns for http settings only: localhost:8080
    //returns for https settings only: https=localhost:8081
    //returns empty string if no proxy selected
    //returns empty string if autoproxy or proxy.pac specified

    Memo1.Lines.Delimiter := #32;
    Memo1.Lines.DelimitedText := s;

    ShowMessage('Done');
  finally
    FreeMem(proxyBuf);
  end;
end;

end.
