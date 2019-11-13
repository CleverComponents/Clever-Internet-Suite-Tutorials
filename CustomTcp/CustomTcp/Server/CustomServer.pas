unit CustomServer;

interface

uses
  Classes, clTcpServer, clTcpCommandServer, clSocket, SysUtils, clSocketUtils;

type
  TclMyCommandHandler = procedure (AConnection: TclCommandConnection;
    const ACommand: string; AParams: TclTcpCommandParams) of object;

  TclMyCommandInfo = class(TclTcpCommandInfo)
  private
    FHandler: TclMyCommandHandler;
  protected
    procedure Execute(AConnection: TclCommandConnection; AParams: TclTcpCommandParams); override;
  public
    constructor Create(const AName: string; AHandler: TclMyCommandHandler);
  end;

  TMySendLinesEvent = procedure (Sender: TObject; AConnection: TclCommandConnection; ALines: TStrings) of object;
  
  TMyServer = class(TclTcpCommandServer)
  private
    FOnSendLines: TMySendLinesEvent;
    
    procedure HandleLOGIN(AConnection: TclCommandConnection; const ACommand: string; AParams: TclTcpCommandParams);
    procedure HandleCLOSE(AConnection: TclCommandConnection; const ACommand: string; AParams: TclTcpCommandParams);
    procedure HandleGETLINES(AConnection: TclCommandConnection; const ACommand: string; AParams: TclTcpCommandParams);
    procedure HandleSENDLINES(AConnection: TclCommandConnection; const ACommand: string; AParams: TclTcpCommandParams);
    procedure HandleSENDLINESData(AConnection: TclCommandConnection; const ACommand: string; AParams: TclTcpCommandParams);
    procedure HandleNullCommand(AConnection: TclCommandConnection; const ACommand: string; AParams: TclTcpCommandParams);
  protected
    function CreateDefaultConnection: TclUserConnection; override;
    procedure DoAcceptConnection(AConnection: TclUserConnection; var Handled: Boolean); override;
    procedure GetCommands; override;
    procedure ProcessUnhandledError(AConnection: TclCommandConnection;
      AParameters: TclTcpCommandParams; E: Exception); override;
    function GetNullCommand(AParameters: TclTcpCommandParams): TclTcpCommandInfo; override;

    procedure DoSendLines(AConnection: TclCommandConnection; ALines: TStrings); virtual;
  public
    property OnSendLines: TMySendLinesEvent read FOnSendLines write FOnSendLines;
  end;

implementation

{ TMyServer }

function TMyServer.CreateDefaultConnection: TclUserConnection;
begin
  Result := TclCommandConnection.Create();
end;

procedure TMyServer.DoAcceptConnection(AConnection: TclUserConnection; var Handled: Boolean);
begin
  inherited DoAcceptConnection(AConnection, Handled);
  SendResponse(AConnection as TclCommandConnection, '', '100');
end;

function TMyServer.GetNullCommand(AParameters: TclTcpCommandParams): TclTcpCommandInfo;
begin
  Result := TclMyCommandInfo.Create(AParameters.Command, HandleNullCommand);
end;

procedure TMyServer.HandleLOGIN(AConnection: TclCommandConnection; const ACommand: string; AParams: TclTcpCommandParams);
begin
  SendResponse(AConnection, ACommand, '100');
end;

procedure TMyServer.HandleNullCommand(AConnection: TclCommandConnection; const ACommand: string; AParams: TclTcpCommandParams);
begin
  raise EclTcpCommandServerError.Create(ACommand, '101', -1, False);
end;

procedure TMyServer.HandleSENDLINES(AConnection: TclCommandConnection; const ACommand: string; AParams: TclTcpCommandParams);
begin
  AcceptMultipleLines(AConnection, TclMyCommandInfo.Create(ACommand, HandleSENDLINESData));
  SendResponse(AConnection, ACommand, '100');
end;

procedure TMyServer.HandleSENDLINESData(AConnection: TclCommandConnection; const ACommand: string; AParams: TclTcpCommandParams);
begin
  AcceptCommands(AConnection);
  DoSendLines(AConnection, AParams.RawData);
  SendResponse(AConnection, 'SENDLINES', '100');
end;

procedure TMyServer.HandleCLOSE(AConnection: TclCommandConnection; const ACommand: string; AParams: TclTcpCommandParams);
begin
  try
    SendResponseAndClose(AConnection, ACommand, '100');
  except
    on EclSocketError do ;
  end;
end;

procedure TMyServer.HandleGETLINES(AConnection: TclCommandConnection; const ACommand: string; AParams: TclTcpCommandParams);
var
  lines: TStrings;
begin
  SendResponse(AConnection, ACommand, '100');
  lines := TStringList.Create();
  try
    lines.Add('This is a first line of data');
    lines.Add('This is a second line of data');
    lines.Add('This is a third line of data');

    SendMultipleLines(AConnection, lines, '.');
  except
    lines.Free();
    raise;
  end;
end;

procedure TMyServer.DoSendLines(AConnection: TclCommandConnection; ALines: TStrings);
begin
  if Assigned(OnSendLines) then
  begin
    OnSendLines(Self, AConnection, ALines);
  end;
end;

procedure TMyServer.ProcessUnhandledError(AConnection: TclCommandConnection;
  AParameters: TclTcpCommandParams; E: Exception);
begin
  SendResponse(AConnection, AParameters.Command, '102');
end;

procedure TMyServer.GetCommands;
begin
  Commands.Add(TclMyCommandInfo.Create('LOGIN', HandleLOGIN));
  Commands.Add(TclMyCommandInfo.Create('CLOSE', HandleCLOSE));
  Commands.Add(TclMyCommandInfo.Create('GETLINES', HandleGETLINES));
  Commands.Add(TclMyCommandInfo.Create('SENDLINES', HandleSENDLINES));
end;

{ TclMyCommandInfo }

constructor TclMyCommandInfo.Create(const AName: string; AHandler: TclMyCommandHandler);
begin
  inherited Create(AName);
  FHandler := AHandler;
end;

procedure TclMyCommandInfo.Execute(AConnection: TclCommandConnection; AParams: TclTcpCommandParams);
begin
  FHandler(AConnection, Name, AParams);
end;

end.
