unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, WinSock, clSocket;

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
  data: TStringStream;
begin
  WSAStartup($202, wsaData);
  server := nil;
  data := nil;
  try
    server := TclTcpServerConnection.Create();

    server.NetworkStream := TclNetworkStream.Create();
    server.TimeOut := 60000;
    server.BatchSize := 8192;
    server.Listen(2110);

    Memo1.Lines.Add('Listening...');

    server.Accept();
    Memo1.Lines.Add('Connected');

    data := TStringStream.Create('');
    server.ReadData(data);

    Memo1.Lines.Add('Received: ' + data.DataString);

    data.Position := 0;
    server.WriteData(data);

    Memo1.Lines.Add('Echoed back to client');

    server.Close(False);
    Memo1.Lines.Add('Closed');
  finally
    data.Free();
    server.Free();
    WSACleanup();
  end;
end;

end.
