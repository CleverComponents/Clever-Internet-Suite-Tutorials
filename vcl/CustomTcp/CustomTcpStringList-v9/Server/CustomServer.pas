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

  TMyHandleLinesEvent = procedure (Sender: TObject; AConnection: TclCommandConnection; ALines: TStrings) of object;
  TMyHandleDataEvent = procedure (Sender: TObject; AConnection: TclCommandConnection; AData: TStream) of object;

  TclProcessStreamDataHandler = class(TclProcessSingleCommandHandler)
  private
    FSize: Int64;
    FTotalSize: Int64;
  protected
    function ExtractData(AData: TStream;
      var AUnprocessedBytes: Int64; AMaxDataSize: Int64): TclProcessDataContext; override;
  public
    constructor Create(AServer: TclTcpCommandServer; AHandler: TclProcessDataEvent;
      ACommand: TclTcpCommandInfo; ASize: Int64);
  end;

  TclProcessStreamDataContext = class(TclProcessSingleCommandContext)
  private
    FData: TStream;
  public
    constructor Create(ACommand: TclTcpCommandInfo);
    destructor Destroy; override;

    property Data: TStream read FData;
  end;

  TclTcpStreamDataParams = class(TclTcpCommandParams)
  private
    FStreamData: TStream;
  public
    procedure FromStreamData(AContext: TclProcessStreamDataContext); virtual;

    property StreamData: TStream read FStreamData write FStreamData;
  end;

  TMyServer = class(TclTcpCommandServer)
  private
    FOnHandleLines: TMyHandleLinesEvent;
    FOnHandleData: TMyHandleDataEvent;
    
    procedure HandleLOGIN(AConnection: TclCommandConnection; const ACommand: string; AParams: TclTcpCommandParams);
    procedure HandleCLOSE(AConnection: TclCommandConnection; const ACommand: string; AParams: TclTcpCommandParams);
    procedure HandleLINES(AConnection: TclCommandConnection; const ACommand: string; AParams: TclTcpCommandParams);
    procedure HandleLINESEnd(AConnection: TclCommandConnection; const ACommand: string; AParams: TclTcpCommandParams);
    procedure HandleDATA(AConnection: TclCommandConnection; const ACommand: string; AParams: TclTcpCommandParams);
    procedure HandleDATAEnd(AConnection: TclCommandConnection; const ACommand: string; AParams: TclTcpCommandParams);
    procedure HandleNullCommand(AConnection: TclCommandConnection; const ACommand: string; AParams: TclTcpCommandParams);
    procedure HandleStreamData(AConnection: TclCommandConnection; AContext: TclProcessDataContext);
  protected
    function CreateDefaultConnection: TclUserConnection; override;
    procedure DoAcceptConnection(AConnection: TclUserConnection; var Handled: Boolean); override;
    procedure GetCommands; override;
    procedure ProcessUnhandledError(AConnection: TclCommandConnection;
      AParameters: TclTcpCommandParams; E: Exception); override;
    function GetNullCommand(AParameters: TclTcpCommandParams): TclTcpCommandInfo; override;

    procedure DoHandleLines(AConnection: TclCommandConnection; ALines: TStrings); virtual;
    procedure DoHandleData(AConnection: TclCommandConnection; AData: TStream); virtual;
  public
    property OnHandleLines: TMyHandleLinesEvent read FOnHandleLines write FOnHandleLines;
    property OnHandleData: TMyHandleDataEvent read FOnHandleData write FOnHandleData;
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

procedure TMyServer.HandleLINES(AConnection: TclCommandConnection; const ACommand: string; AParams: TclTcpCommandParams);
begin
  AcceptMultipleLines(AConnection, TclMyCommandInfo.Create(ACommand, HandleLINESEnd));
  SendResponse(AConnection, ACommand, '100');
end;

procedure TMyServer.HandleLINESEnd(AConnection: TclCommandConnection; const ACommand: string; AParams: TclTcpCommandParams);
var
  lines: TStrings;
begin
  AcceptCommands(AConnection);
  DoHandleLines(AConnection, AParams.RawData);
  SendResponse(AConnection, 'LINES', '100');

  lines := TStringList.Create();
  try
    lines.Add('There are original client lines:');
    lines.AddStrings(AParams.RawData);

    SendMultipleLines(AConnection, lines, '.');
  except
    lines.Free();
    raise;
  end;
end;

procedure TMyServer.HandleCLOSE(AConnection: TclCommandConnection; const ACommand: string; AParams: TclTcpCommandParams);
begin
  try
    SendResponseAndClose(AConnection, ACommand, '100');
  except
    on EclSocketError do ;
  end;
end;

procedure TMyServer.HandleStreamData(AConnection: TclCommandConnection; AContext: TclProcessDataContext);
var
  dataContext: TclProcessStreamDataContext;
  parameters: TclTcpStreamDataParams;
begin
  dataContext := (AContext as TclProcessStreamDataContext);

  parameters := TclTcpStreamDataParams.Create();
  try
    parameters.FromStreamData(dataContext);
    ProcessCommand(AConnection, dataContext.Command, parameters);
  finally
    parameters.Free();
  end;
end;

procedure TMyServer.HandleDATA(AConnection: TclCommandConnection; const ACommand: string; AParams: TclTcpCommandParams);
var
  size: Int64;
begin
  size := StrToInt64Def(AParams.Parameters, 0);
  AcceptData(AConnection,
    TclProcessStreamDataHandler.Create(Self, HandleStreamData,
      TclMyCommandInfo.Create(ACommand, HandleDATAEnd), size));
  SendResponse(AConnection, ACommand, '100');
end;

procedure TMyServer.HandleDATAEnd(AConnection: TclCommandConnection; const ACommand: string; AParams: TclTcpCommandParams);
var
  data: TStream;
  dataParams: TclTcpStreamDataParams;
  size: Int64;
begin
  AcceptCommands(AConnection);

  dataParams := (AParams as TclTcpStreamDataParams);

  DoHandleData(AConnection, dataParams.StreamData);

  data := TMemoryStream.Create();
  try
    size := dataParams.StreamData.Size;
    data.Write(size, SizeOf(size));

    data.CopyFrom(dataParams.StreamData, 0);

    data.Position := 0;
    AConnection.WriteData(data);
  finally
    data.Free();
  end;
end;

procedure TMyServer.DoHandleData(AConnection: TclCommandConnection; AData: TStream);
begin
  if Assigned(OnHandleData) then
  begin
    OnHandleData(Self, AConnection, AData);
  end;
end;

procedure TMyServer.DoHandleLines(AConnection: TclCommandConnection; ALines: TStrings);
begin
  if Assigned(OnHandleLines) then
  begin
    OnHandleLines(Self, AConnection, ALines);
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
  Commands.Add(TclMyCommandInfo.Create('LINES', HandleLINES));
  Commands.Add(TclMyCommandInfo.Create('DATA', HandleDATA));
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

{ TclProcessStreamDataHandler }

constructor TclProcessStreamDataHandler.Create(AServer: TclTcpCommandServer;
  AHandler: TclProcessDataEvent; ACommand: TclTcpCommandInfo; ASize: Int64);
begin
  inherited Create(AServer, AHandler, ACommand);
  FSize := ASize;
end;

function TclProcessStreamDataHandler.ExtractData(AData: TStream;
  var AUnprocessedBytes: Int64; AMaxDataSize: Int64): TclProcessDataContext;
var
  context: TclProcessStreamDataContext;
begin
  context := TclProcessStreamDataContext.Create(Command);
  try
    if IsMaxDataSize then
    begin
      FTotalSize := FTotalSize + AData.Size;
    end else
    begin
      FTotalSize := AData.Size;
    end;
    AUnprocessedBytes := FTotalSize;

    if CheckMaxDataSize(FTotalSize, AMaxDataSize) then
    begin
      IsMaxDataSize := True;
      AUnprocessedBytes := 0;
    end;

    if (FTotalSize >= FSize) then
    begin
      if not IsMaxDataSize then
      begin
        context.Data.CopyFrom(AData, 0);
      end;

      AUnprocessedBytes := 0;
      context.IsReady := True;
      FTotalSize := 0;
    end;

    Result := context;
  except
    context.Free();
    raise;
  end;
end;

{ TclProcessStreamDataContext }

constructor TclProcessStreamDataContext.Create(ACommand: TclTcpCommandInfo);
begin
  inherited Create(ACommand);
  FData := TMemoryStream.Create();
end;

destructor TclProcessStreamDataContext.Destroy;
begin
  FData.Free();
  inherited Destroy();
end;

{ TclTcpStreamDataParams }

procedure TclTcpStreamDataParams.FromStreamData(AContext: TclProcessStreamDataContext);
begin
  Command := AContext.Command.Name;
  Parameters := '';
  RawCommand := '';
  StreamData := AContext.Data;
end;

end.
