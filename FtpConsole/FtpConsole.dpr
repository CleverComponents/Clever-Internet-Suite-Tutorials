program FtpConsole;

{$APPTYPE CONSOLE}

uses
  Classes, SysUtils, Windows, clUtils, clFtp, clFtpUtils, clSocketUtils, clTcpClient,
  clTlsSocket, clCertificate;

type
  EclConsoleFtpError = class(Exception);

  TclConsoleFtpClient = class
  private
    FClient: TclFtp;
    FCertificateVerified: Boolean;
    FStdHandle: THandle;
    FCursorInfo: TConsoleScreenBufferInfo;

    function StrAnsiToOem(const S: AnsiString): AnsiString;
    function GetPassword(const InputMask: Char = '*'): string;
    procedure PrepareProgress;
    procedure DoneProgress;
    
    procedure DoProgress(Sender: TObject; ABytesProceed, ATotalBytes: Int64);
    procedure DoVerifyServer(Sender: TObject; ACertificate: TclCertificate;
      const AStatusText: string; AStatusCode: Integer; var AVerified: Boolean);

    function HandleCommands(ACmd: TStrings): Boolean;
    procedure HandleHelp;
    procedure HandleOpen(ACmd: TStrings);
    procedure HandleClose;
    procedure HandlePasv;
    procedure HandleNonp;
    procedure HandleRange(ACmd: TStrings);
    procedure HandlePwd;
    procedure HandleChdir(ACmd: TStrings);
    procedure HandleCdup;
    procedure HandleNewdir(ACmd: TStrings);
    procedure HandleRmdir(ACmd: TStrings);
    procedure HandleList(ACmd: TStrings);
    procedure HandleGet(ACmd: TStrings);
    procedure HandlePut(ACmd: TStrings);
    procedure HandleDel(ACmd: TStrings);
    procedure HandleRename(ACmd: TStrings);
    procedure HandleTls(ACmd: TStrings);

    procedure HandleUnknownCommand;
    procedure HandleWrongParameters(const ACommand: string);
    procedure HandleSocketError(E: EclSocketError);
    procedure HandleConsoleFtpError(E: EclConsoleFtpError);
  public
    constructor Create;
    destructor Destroy; override;
    
    procedure Run;
  end;

{ TclConsoleFtpClient }

constructor TclConsoleFtpClient.Create;
begin
  inherited Create();
  
  FClient := TclFtp.Create(nil);
  FClient.OnVerifyServer := DoVerifyServer;
  
  FStdHandle := GetStdHandle(STD_OUTPUT_HANDLE);
  FCertificateVerified := False;
end;

destructor TclConsoleFtpClient.Destroy;
begin
  FClient.Free();
  inherited Destroy();
end;

procedure TclConsoleFtpClient.PrepareProgress;
begin
  FClient.OnProgress := DoProgress;
  GetConsoleScreenBufferInfo(FStdHandle, FCursorInfo); // record the coordinates from where we're going to write
  WriteLn('');
end;

procedure TclConsoleFtpClient.DoneProgress;
begin
  FClient.OnProgress := nil;
  WriteLn('');
end;

procedure TclConsoleFtpClient.DoProgress(Sender: TObject; ABytesProceed, ATotalBytes: Int64);
var
  newCoord: TCoord;
begin
  newCoord.X := 0;
  newCoord.Y := FCursorInfo.dwCursorPosition.Y;

  SetConsoleCursorPosition(FStdHandle, newCoord);

  Write(StringOfChar(' ', FCursorInfo.dwSize.x)); // Clear the line before writing to it

  SetConsoleCursorPosition(FStdHandle, newCoord);

  Write(Format('%d of %d completed', [ABytesProceed, ATotalBytes]));
end;

procedure TclConsoleFtpClient.DoVerifyServer(Sender: TObject; ACertificate: TclCertificate;
  const AStatusText: string; AStatusCode: Integer; var AVerified: Boolean);
var
  OldMode: Cardinal;
  c: Char;
begin
  if (not AVerified) then
  begin
    AVerified := FCertificateVerified;
  end;

  if (not AVerified) then
  begin
    WriteLn(StrAnsiToOem(AStatusText));
    Write('Do you want to proceed? y/n ');

    GetConsoleMode(GetStdHandle(STD_INPUT_HANDLE), OldMode);
    SetConsoleMode(GetStdHandle(STD_INPUT_HANDLE), OldMode and not (ENABLE_LINE_INPUT or ENABLE_ECHO_INPUT));
    try
      Read(c);
    finally
      SetConsoleMode(GetStdHandle(STD_INPUT_HANDLE), OldMode);
    end;
    WriteLn('y');

    if (LowerCase(c) = 'y') then
    begin
      AVerified := True;
      FCertificateVerified := True;
    end;
  end;
end;

procedure TclConsoleFtpClient.HandleCdup;
begin
  FClient.ChangeToParentDir();

  HandlePwd();
end;

procedure TclConsoleFtpClient.HandleChdir(ACmd: TStrings);
begin
  if ACmd.Count <> 2 then
  begin
    HandleWrongParameters(ACmd[0]);
  end;

  FClient.ChangeCurrentDir(ACmd[1]);

  HandlePwd();
end;

procedure TclConsoleFtpClient.HandleClose;
begin
  FClient.Close();
  WriteLn('Disconnected.');
end;

function TclConsoleFtpClient.HandleCommands(ACmd: TStrings): Boolean;
var
  name: string;
begin
  Result := False;
  
  if (ACmd.Count = 0) then
  begin
    HandleUnknownCommand();
  end;

  name := LowerCase(ACmd[0]);

  if (name = 'help') then
  begin
    HandleHelp();
  end else
  if (name = 'open') then
  begin
    HandleOpen(ACmd);
  end else
  if (name = 'close') then
  begin
    HandleClose();
  end else
  if (name = 'pasv') then
  begin
    HandlePasv();
  end else
  if (name = 'nonp') then
  begin
    HandleNonp();
  end else
  if (name = 'range') then
  begin
    HandleRange(ACmd);
  end else
  if (name = 'pwd') then
  begin
    HandlePwd();
  end else
  if (name = 'chdir') then
  begin
    HandleChdir(ACmd);
  end else
  if (name = 'cdup') then
  begin
    HandleCdup();
  end else
  if (name = 'newdir') then
  begin
    HandleNewdir(ACmd);
  end else
  if (name = 'rmdir') then
  begin
    HandleRmdir(ACmd);
  end else
  if (name = 'list') then
  begin
    HandleList(ACmd);
  end else
  if (name = 'get') then
  begin
    HandleGet(ACmd);
  end else
  if (name = 'put') then
  begin
    HandlePut(ACmd);
  end else
  if (name = 'del') then
  begin
    HandleDel(ACmd);
  end else
  if (name = 'rename') then
  begin
    HandleRename(ACmd);
  end else
  if (name = 'tls') then
  begin
    HandleTls(ACmd);
  end else
  if (name = 'quit') then
  begin
    HandleClose();
    Result := True;
  end else
  begin
    HandleUnknownCommand();
  end;
end;

procedure TclConsoleFtpClient.HandleHelp;
begin
  WriteLn('Commands:');
  WriteLn('help - help');
  WriteLn('open host [port] - open the connection');
  WriteLn('close - close the connection');
  WriteLn('pasv - set passive mode');
  WriteLn('nonp - set non-passive mode');
  WriteLn('range portno1 portno2 - set data port range');
  WriteLn('pwd - print the current directory name');
  WriteLn('chdir "directory name" - change current directory');
  WriteLn('cdup - change to the parent directory');
  WriteLn('newdir "directory name"- create new directory on the server');
  WriteLn('rmdir "directory name" - remove ftp directory');
  WriteLn('list [parameters] - list directory');
  WriteLn('get "ftp file" "local file" - download ftp file and store to a local file');
  WriteLn('put "local file" "ftp file" - upload loal file to ftp file on the server');
  WriteLn('del "file name" - delete file');
  WriteLn('rename "old name" "new name" - rename ftp file');
  WriteLn('tls [implicit/explicit]- enables TLS mode. If no parameter is specified, the mode is determined automatically:');
  WriteLn(' - if the FTP port is 21, the mode is explicit (the AUTH TLS command is used);');
  WriteLn(' - otherwise, the mode is implicit (TLS negotiation starts immediately once connected).');
  WriteLn('quit - close the connection and exit the program');
end;

procedure TclConsoleFtpClient.HandleConsoleFtpError(E: EclConsoleFtpError);
begin
  WriteLn(StrAnsiToOem('Error: ' + E.Message));
end;

procedure TclConsoleFtpClient.HandleDel(ACmd: TStrings);
begin
  if ACmd.Count <> 2 then
  begin
    HandleWrongParameters(ACmd[0]);
  end;

  FClient.Delete(ACmd[1]);
  WriteLn('The file "' + ACmd[1] + '" was deleted.');
end;

procedure TclConsoleFtpClient.HandleGet(ACmd: TStrings);
begin
  if ACmd.Count <> 3 then
  begin
    HandleWrongParameters(ACmd[0]);
  end;

  PrepareProgress();
  try
    FClient.GetFile(ACmd[1], ACmd[2]);
  finally
    DoneProgress();
  end;
  
  WriteLn('The file "' + ACmd[1] + '" was downloaded.');
end;

procedure TclConsoleFtpClient.HandleList(ACmd: TStrings);
var
  list: TStrings;
  i: Integer;
  s: string;
begin
  list := TStringList.Create();
  try
    s := '';
    if (ACmd.Count > 1) then
    begin
      s := ACmd[1];
    end;

    FClient.GetList(list, s);

    for i := 0 to list.Count - 1 do
    begin
      WriteLn(list[i]);
    end;

    WriteLn('Done.');
  finally
    list.Free();
  end;
end;

procedure TclConsoleFtpClient.HandleNewdir(ACmd: TStrings);
begin
  if ACmd.Count <> 2 then
  begin
    HandleWrongParameters(ACmd[0]);
  end;

  FClient.MakeDir(ACmd[1]);

  WriteLn('The directory "' + ACmd[1] + '" was created.');
end;

procedure TclConsoleFtpClient.HandleNonp;
begin
  FClient.PassiveMode := False;
  WriteLn('The non-passive mode is enabled.');
end;

function TclConsoleFtpClient.GetPassword(const InputMask: Char): string;
var
  OldMode: Cardinal;
  c: Char;
begin
  GetConsoleMode(GetStdHandle(STD_INPUT_HANDLE), OldMode);
  SetConsoleMode(GetStdHandle(STD_INPUT_HANDLE), OldMode and not (ENABLE_LINE_INPUT or ENABLE_ECHO_INPUT));
  try
    while not Eof do
    begin
      Read(c);
      if c = #13 then // Carriage Return
      begin
        Break;
      end;
      if c = #8 then // Back Space
      begin
        if (Length(Result) > 0) then
        begin
          Delete(Result, Length(Result), 1);
          Write(#8);
        end;
      end else
      begin
        Result := Result + c;
        Write(InputMask);
      end;
    end;
  finally
    SetConsoleMode(GetStdHandle(STD_INPUT_HANDLE), OldMode);
  end;
end;

procedure TclConsoleFtpClient.HandleOpen(ACmd: TStrings);
var
  s: string;
begin
  if ACmd.Count < 2 then
  begin
    HandleWrongParameters(ACmd[0]);
  end;

  FClient.Server := ACmd[1];

  if ACmd.Count > 2 then
  begin
    FClient.Port := StrToIntDef(ACmd[2], cDefaultFtpPort);
  end;

  Write('User: ');
  ReadLn(s);
  FClient.UserName := s;

  Write('Password: ');
  FClient.Password := GetPassword();
  WriteLn('');
  
  FClient.Open();

  WriteLn('Connected.');
  
  HandlePwd();
end;

procedure TclConsoleFtpClient.HandlePasv;
begin
  FClient.PassiveMode := True;
  WriteLn('The passive mode is enabled.');
end;

procedure TclConsoleFtpClient.HandlePut(ACmd: TStrings);
begin
  if ACmd.Count <> 3 then
  begin
    HandleWrongParameters(ACmd[0]);
  end;

  PrepareProgress();
  try
    FClient.PutFile(ACmd[1], ACmd[2]);
  finally
    DoneProgress();
  end;

  WriteLn('The file "' + ACmd[1] + '" was uploaded.');
end;

procedure TclConsoleFtpClient.HandlePwd;
begin
  WriteLn('The current directory: "' + FClient.CurrentDir + '"');
end;

procedure TclConsoleFtpClient.HandleRange(ACmd: TStrings);
begin
  if ACmd.Count <> 3 then
  begin
    HandleWrongParameters(ACmd[0]);
  end;

  FClient.DataPortBegin := StrToIntDef(ACmd[1], 0);
  FClient.DataPortEnd := StrToIntDef(ACmd[2], 0);

  WriteLn('The data port range was set between ' + ACmd[1] + ' and ' + ACmd[2]);
end;

procedure TclConsoleFtpClient.HandleRename(ACmd: TStrings);
begin
  if ACmd.Count <> 3 then
  begin
    HandleWrongParameters(ACmd[0]);
  end;

  FClient.Rename(ACmd[1], ACmd[2]);
  WriteLn('The file "' + ACmd[1] + '" was renamed to "' + ACmd[2] + '".');
end;

procedure TclConsoleFtpClient.HandleRmdir(ACmd: TStrings);
begin
  if ACmd.Count <> 2 then
  begin
    HandleWrongParameters(ACmd[0]);
  end;

  FClient.RemoveDir(ACmd[1]);

  WriteLn('The directory "' + ACmd[1] + '" was removed.');
end;

function TclConsoleFtpClient.StrAnsiToOem(const S: AnsiString): AnsiString;
begin
  SetLength(Result, Length(S));
  AnsiToOemBuff(@S[1], @Result[1], Length(S));
end;

procedure TclConsoleFtpClient.HandleSocketError(E: EclSocketError);
begin
  WriteLn(StrAnsiToOem('Error occurred, code: ' + IntToStr(E.ErrorCode) + ', message: ' + E.Message));
end;

procedure TclConsoleFtpClient.HandleTls(ACmd: TStrings);
var
  s: string;
begin
  if FClient.Active then
  begin
    raise EclConsoleFtpError.Create('The FTP client is connected. Please close the connection before enabling the TLS mode.');
  end;

  if (ACmd.Count > 1) then
  begin
    s := LowerCase(ACmd[1]);

    if (s = 'implicit') then
    begin
      FClient.UseTLS := ctImplicit;
    end else
    if (s = 'explicit') then
    begin
      FClient.UseTLS := ctExplicit;
    end else
    begin
      HandleWrongParameters(ACmd[0]); 
    end;
  end else
  begin
    FClient.UseTLS := ctAutomatic;
  end;

  WriteLn('The TLS mode is enabled. Please use the "open" command to proceed.');
end;

procedure TclConsoleFtpClient.HandleUnknownCommand;
begin
  raise EclConsoleFtpError.Create('The command is not recognized. Please type "help" to see the supported command list');
end;

procedure TclConsoleFtpClient.HandleWrongParameters(const ACommand: string);
begin
  raise EclConsoleFtpError.Create('The "' + ACommand + '" command parameters are invalid. Please type "help" to see the supported command list');
end;

procedure TclConsoleFtpClient.Run;
var
  s: string;
  cmd: TStrings;
  isquit: Boolean;
begin
  cmd := TStringList.Create();
  try
    isquit := False;
    repeat
      try
        ReadLn(s);
        ExtractQuotedWords(s, cmd);
        isquit := HandleCommands(cmd);
      except
        on E: EclSocketError do
        begin
          HandleSocketError(E);
        end;
        on E: EclConsoleFtpError do
        begin
          HandleConsoleFtpError(E);
        end;
      end;
    until isquit;
  finally
    cmd.Free();
  end;
end;

var
  ftpClient: TclConsoleFtpClient;
begin
  try
    ftpClient := TclConsoleFtpClient.Create();
    try
      ftpClient.Run();
    finally
      ftpClient.Free();
    end;
  except
    on E:Exception do
      WriteLn(E.Classname, ': ', E.Message);
  end;
end.
