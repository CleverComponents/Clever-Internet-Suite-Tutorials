unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, clWinInet, StdCtrls;

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
  details: Cardinal;
begin
  Memo1.Clear();
  if InternetGetConnectedState(@details, 0) then
  begin
    Memo1.Lines.Add('There is an active Internet connection.');
  end else
  begin
    Memo1.Lines.Add('There is no Internet connection.');
  end;

  if (details and INTERNET_CONNECTION_MODEM) > 0 then
  begin
    Memo1.Lines.Add('Local system uses a modem to connect to the Internet.');
  end;
  if (details and INTERNET_CONNECTION_LAN) > 0 then
  begin
    Memo1.Lines.Add('Local system uses a local area network to connect to the Internet.');
  end;
  if (details and INTERNET_CONNECTION_PROXY) > 0 then
  begin
    Memo1.Lines.Add('Local system uses a proxy server to connect to the Internet.');
  end;
  if (details and INTERNET_CONNECTION_OFFLINE) > 0 then
  begin
    Memo1.Lines.Add('Local system is in offline mode.');
  end;
  if (details and INTERNET_CONNECTION_CONFIGURED) > 0 then
  begin
    Memo1.Lines.Add('Local system has a valid connection to the Internet.');
  end;
  if (details and INTERNET_RAS_INSTALLED) > 0 then
  begin
    Memo1.Lines.Add('Local system has RAS installed.');
  end;
end;

end.
