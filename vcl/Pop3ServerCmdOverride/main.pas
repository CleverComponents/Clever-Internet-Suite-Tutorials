unit main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, System.SyncObjs, clTcpServer,
  clTcpServerTls, clTcpCommandServer, clPop3Server, clPop3FileHandler, clUtils;

type
  TMainForm = class(TForm)
    pnlLogo: TPanel;
    imLogoLeft: TImage;
    imLogoMiggle: TImage;
    imLogoRight: TImage;
    pnlMain: TPanel;
    Label5: TLabel;
    Label2: TLabel;
    edtPort: TEdit;
    Label3: TLabel;
    edtRootDir: TEdit;
    btnStart: TButton;
    btnStop: TButton;
    Label1: TLabel;
    memLog: TMemo;
    Label4: TLabel;
    Label6: TLabel;
    clPop3FileHandler1: TclPop3FileHandler;
    clPop3Server1: TclPop3Server;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure clPop3Server1Start(Sender: TObject);
    procedure clPop3Server1Stop(Sender: TObject);
    procedure clPop3Server1AcceptConnection(Sender: TObject;
      AConnection: TclUserConnection; var Handled: Boolean);
    procedure clPop3Server1CloseConnection(Sender: TObject;
      AConnection: TclUserConnection);
    procedure clPop3Server1ReceiveCommand(Sender: TObject;
      AConnection: TclCommandConnection; ACommandParams: TclTcpCommandParams);
    procedure clPop3Server1SendResponse(Sender: TObject;
      AConnection: TclCommandConnection; const ACommand, AResponse: string);
  private
    FSynchronizer: TCriticalSection;
    FIsStop: Boolean;
    procedure PutLogMessage(const ALogMessage: string);
    procedure OverridePoP3CommandHandlers;
    procedure HandleSTAT(AConnection: TclPop3CommandConnection;
      const ACommand: string; AParameters: TclTcpCommandParams);
    procedure HandleLIST(AConnection: TclPop3CommandConnection;
      const ACommand: string; AParameters: TclTcpCommandParams);
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

{ TMainForm }

//POP3 commands overrides
procedure TMainForm.HandleSTAT(AConnection: TclPop3CommandConnection;
  const ACommand: string; AParameters: TclTcpCommandParams);
begin
  if (AConnection.ConnectionState <> csPop3Transaction) then
  begin
    raise EclPop3ServerError.Create(ACommand, ErrResponse + ' invalid state for this command', -1);
  end;

  clPop3Server1.SendResponse(AConnection, ACommand, '%s %d %d',
    [OkResponse, AConnection.MailBox.ActiveCount, AConnection.MailBox.ActiveSize]);
end;

type
  TclTcpCommandInfoAccess = class(TclTcpCommandInfo);

procedure TMainForm.HandleLIST(AConnection: TclPop3CommandConnection;
  const ACommand: string; AParameters: TclTcpCommandParams);
var
  cmd: TclTcpCommandInfo;
begin
  PutLogMessage('HandleLIST override executing');

  //call the default LIST handler
  cmd := clPop3Server1.Commands.CommandByName('LIST-DEFAULT');
  //access the protected Execute method
  TclTcpCommandInfoAccess(cmd).Execute(AConnection, AParameters);
end;

procedure TMainForm.OverridePoP3CommandHandlers;
var
  cmd: TclTcpCommandInfo;
begin
  //STAT override

  cmd := clPop3Server1.Commands.CommandByName('STAT');
  //remove the default command handler
  clPop3Server1.Commands.Remove(cmd);
  //add a new command handler
  cmd := TclPop3CommandInfo.Create('STAT', HandleSTAT);
  clPop3Server1.Commands.Add(cmd);

  //LIST override

  cmd := clPop3Server1.Commands.CommandByName('LIST');
  //rename the default command handler in order to call it later
  cmd.Name := 'LIST-DEFAULT';
  //add a new command handler
  cmd := TclPop3CommandInfo.Create('LIST', HandleLIST);
  clPop3Server1.Commands.Add(cmd);
end;

procedure TMainForm.btnStartClick(Sender: TObject);
begin
  clPop3Server1.Port := StrToInt(edtPort.Text);
  clPop3FileHandler1.MailBoxDir := edtRootDir.Text;
  ForceFileDirectories(AddTrailingBackSlash(clPop3FileHandler1.MailBoxDir));
  ForceFileDirectories(AddTrailingBackSlash(clPop3FileHandler1.MailBoxDir) + 'CleverTester\');

  clPop3Server1.Start();
end;

procedure TMainForm.btnStopClick(Sender: TObject);
begin
  FIsStop := True;
  try
    clPop3Server1.Stop();
  finally
    FIsStop := False;
  end;
end;

procedure TMainForm.clPop3Server1AcceptConnection(Sender: TObject;
  AConnection: TclUserConnection; var Handled: Boolean);
begin
  PutLogMessage('Accept Connection. Host: ' + AConnection.PeerIP);
end;

procedure TMainForm.clPop3Server1CloseConnection(Sender: TObject;
  AConnection: TclUserConnection);
begin
  if not FIsStop then
  begin
    PutLogMessage('Close Connection. Host: ' + AConnection.PeerIP);
  end;
end;

procedure TMainForm.clPop3Server1ReceiveCommand(Sender: TObject;
  AConnection: TclCommandConnection; ACommandParams: TclTcpCommandParams);
begin
  PutLogMessage('Command: ' + ACommandParams.Command + ' ' + ACommandParams.Parameters);
end;

procedure TMainForm.clPop3Server1SendResponse(Sender: TObject;
  AConnection: TclCommandConnection; const ACommand, AResponse: string);
begin
  PutLogMessage('Reply: ' + AResponse);
end;

procedure TMainForm.clPop3Server1Start(Sender: TObject);
begin
  PutLogMessage('=================='#13#10'Start Server');
end;

procedure TMainForm.clPop3Server1Stop(Sender: TObject);
begin
  PutLogMessage('Stop Server');
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FSynchronizer := TCriticalSection.Create();
  OverridePoP3CommandHandlers();
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  FSynchronizer.Free();
end;

procedure TMainForm.PutLogMessage(const ALogMessage: string);
begin
  if not (csDestroying in ComponentState) then
  begin
    FSynchronizer.Enter();
    try
      memLog.Lines.Add(ALogMessage);
    finally
      FSynchronizer.Leave();
    end;
  end;
end;

end.
