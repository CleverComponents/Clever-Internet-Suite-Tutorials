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

uses
  LocalBindingConnection;

procedure TForm1.Button1Click(Sender: TObject);
var
  wsaData: TWSAData;
  client: TLocalBindingConnection;
  data: TStringStream;
begin
  WSAStartup($202, wsaData);
  client := nil;
  data := nil;
  try
    client := TLocalBindingConnection.Create();

    client.NetworkStream := TclNetworkStream.Create();
    client.TimeOut := 60000;

    // Connect to server with specific local binding IP and port
    // Replace '192.168.1.100' with your actual local IP address
    // Replace 50000 with the desired local port
    // Use 0 for local port to let the system assign a random available port
    client.OpenWithBinding('127.0.0.1', 2110, '192.168.1.100', 50000);

    ShowMessage('Client connected with local binding');

    data := TStringStream.Create('Data from client with local binding');
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
