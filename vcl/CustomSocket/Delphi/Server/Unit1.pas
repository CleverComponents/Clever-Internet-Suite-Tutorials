unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, WinSock, clSocket, clTlsSocket;

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
  wsaData: TWSAData;
  server: TclTcpServerConnection;
  data: TStream;
begin
  WSAStartup($202, wsaData);
  server := nil;
  data := nil;
  try
    server := TclTcpServerConnection.Create();

    server.NetworkStream := TclNetworkStream.Create();
    server.TimeOut := 60000;
    server.BatchSize := 8192;
    server.Open(2110);
    server.Accept();
    Memo1.Lines.Add('connected');

    data := TStringStream.Create('');
    server.ReadData(data);
    data.Position := 0;
    server.WriteData(data);

    Memo1.Lines.Add('read done');

    server.Close(False);
    Memo1.Lines.Add('closed');
  finally
    data.Free();
    server.Free();
    WSACleanup();
  end;
end;

end.
