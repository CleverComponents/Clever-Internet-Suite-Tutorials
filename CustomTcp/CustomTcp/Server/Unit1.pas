unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CustomServer, clTcpServer, clTcpCommandServer, SyncObjs;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FServer: TMyServer;
    FSynchronizer: TCriticalSection;

    procedure DoConnect(Sender: TObject; AConnection: TclUserConnection; var Handled: Boolean);
    procedure DoDisconnect(Sender: TObject; AConnection: TclUserConnection);
    procedure DoSendLines(Sender: TObject; AConnection: TclCommandConnection; ALines: TStrings);
    procedure PutLogMessage(const ALogMessage: string);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  FSynchronizer := TCriticalSection.Create();
  FServer := TMyServer.Create(nil);
  FServer.Port := 2110;

  FServer.OnAcceptConnection := DoConnect;
  FServer.OnCloseConnection := DoDisconnect;
  FServer.OnSendLines := DoSendLines;

  FServer.Start();
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FServer.Free();
  FSynchronizer.Free();
end;

procedure TForm1.PutLogMessage(const ALogMessage: string);
begin
  if not (csDestroying in ComponentState) then
  begin
    FSynchronizer.Enter();
    try
      Memo1.Lines.Add(ALogMessage);
    finally
      FSynchronizer.Leave();
    end;
  end;
end;

procedure TForm1.DoConnect(Sender: TObject; AConnection: TclUserConnection; var Handled: Boolean);
begin
  PutLogMessage('Accept Connection. Host: ' + AConnection.PeerIP);
end;

procedure TForm1.DoDisconnect(Sender: TObject; AConnection: TclUserConnection);
begin
  PutLogMessage('Close Connection. Host: ' + AConnection.PeerIP);
  PutLogMessage('');
end;

procedure TForm1.DoSendLines(Sender: TObject; AConnection: TclCommandConnection; ALines: TStrings);
var
  i: Integer;
begin
  PutLogMessage('Received Lines:');

  for i := 0 to ALines.Count - 1 do
  begin
    PutLogMessage(ALines[i]);
  end;
end;

end.
