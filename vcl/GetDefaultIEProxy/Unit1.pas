unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, clWinInet, clWUtils;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    function GetSystemProxySettings: string;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  s: string;
begin
  Memo1.Clear;
  
  // System/IE proxy settings
  s := GetSystemProxySettings;

  Memo1.Text := s + sLineBreak + sLineBreak +
    'Note: Modern browsers like Microsoft Edge use these system settings ' +
    'when configured to use system proxy.';

  ShowMessage('Done');
end;

function TForm1.GetSystemProxySettings: string;
var
  proxy: PInternetProxyInfo;
  proxyBuf: Pointer;
  proxyBufLen: DWORD;
  b: BOOL;
begin
  Result := '';
  proxyBufLen := 4096;
  GetMem(proxyBuf, proxyBufLen);
  try
    b := InternetQueryOption(nil, INTERNET_OPTION_PROXY, proxyBuf, proxyBufLen);
    if not b then 
    begin
      Result := 'Failed to get system proxy info. Error: ' + IntToStr(GetLastError);
      Exit;
    end;
    
    proxy := PInternetProxyInfo(proxyBuf);
    Result := 'System Proxy Settings:' + sLineBreak + sLineBreak;
    
    if Assigned(proxy.lpszProxy) and (proxy.lpszProxy^ <> #0) then
    begin
      Result := Result + 'Proxy Server: ' + string(PclChar(GetTclString(proxy.lpszProxy))) + sLineBreak;
    end else
    begin
      Result := Result + 'Proxy Server: Not configured' + sLineBreak;
    end;

    if Assigned(proxy.lpszProxyBypass) and (proxy.lpszProxyBypass^ <> #0) then
    begin
      Result := Result + 'Proxy Bypass: ' + string(PclChar(GetTclString(proxy.lpszProxyBypass))) + sLineBreak;
    end else
    begin
      Result := Result + 'Proxy Bypass: Not configured' + sLineBreak;
    end;
    
    Result := Result + 'Access Type: ' + IntToStr(proxy.dwAccessType);
    
  finally
    FreeMem(proxyBuf);
  end;
end;

end.
