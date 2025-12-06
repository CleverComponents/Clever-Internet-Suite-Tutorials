unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WinSock, clSocket, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
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
  client: TclTcpClientConnection;
  data: TStringStream;
begin
  WSAStartup($202, wsaData);
  client := nil;
  data := nil;
  try
    client := TclTcpClientConnection.Create();

    client.NetworkStream := TclNetworkStream.Create();
    client.TimeOut := 60000;
    client.Open('127.0.0.1', 2110);
    ShowMessage('Client connected');

    data := TStringStream.Create('Data from client');
    client.WriteData(data);

    ShowMessage('Sent: ' + data.DataString);

    data.Size := 0;
    client.IsReadUntilClose := True;
    client.ReadData(data);

    ShowMessage('Received: ' + data.DataString);

    client.Close(True);
    ShowMessage('Client disconnected');
  finally
    data.Free();
    client.Free();
    WSACleanup();
  end;
end;

end.
