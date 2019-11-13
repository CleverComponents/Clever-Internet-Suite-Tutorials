unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, clTcpServer, clUserMgr, clMailUserMgr, SyncObjs, clUtils,
  clImap4Server, clImap4FileHandler, clTcpCommandServer, clTcpServerTls, ProxyHeader, ProxiedImapConnection;

type
  TMainForm = class(TForm)
    btnStart: TButton;
    btnStop: TButton;
    memLog: TMemo;
    edtPort: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtRootDir: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    clImap4FileHandler1: TclImap4FileHandler;
    clImap4Server1: TclImap4Server;
    btnTestProxyHeader: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure clImap4Server1Start(Sender: TObject);
    procedure clImap4Server1Stop(Sender: TObject);
    procedure clImap4Server1AcceptConnection(Sender: TObject; AConnection: TclUserConnection; var Handled: Boolean);
    procedure clImap4Server1CloseConnection(Sender: TObject; AConnection: TclUserConnection);
    procedure clImap4Server1ReceiveCommand(Sender: TObject; AConnection: TclCommandConnection;
      ACommandParams: TclTcpCommandParams);
    procedure clImap4Server1SendResponse(Sender: TObject; AConnection: TclCommandConnection; const ACommand, AResponse: string);
    procedure clImap4Server1Authenticate(Sender: TObject; AConnection: TclImap4CommandConnection;
      var Account: TclMailUserAccountItem; const AUserName: string; var IsAuthorized, Handled: Boolean);
    procedure btnTestProxyHeaderClick(Sender: TObject);
    procedure clImap4Server1CreateConnection(Sender: TObject; var AConnection: TclUserConnection);
  private
    FSynchronizer: TCriticalSection;
    FIsStop: Boolean;
    procedure PutLogMessage(const ALogMessage: string);
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FSynchronizer := TCriticalSection.Create();
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

procedure TMainForm.btnStartClick(Sender: TObject);
begin
  clImap4Server1.Port := StrToInt(edtPort.Text);
  clImap4FileHandler1.MailBoxDir := edtRootDir.Text;
  ForceFileDirectories(AddTrailingBackSlash(clImap4FileHandler1.MailBoxDir));
  ForceFileDirectories(AddTrailingBackSlash(clImap4FileHandler1.MailBoxDir) + 'CleverTester\');
  clImap4Server1.Start();
end;

procedure TMainForm.btnStopClick(Sender: TObject);
begin
  FIsStop := True;
  try
    clImap4Server1.Stop();
  finally
    FIsStop := False;
  end;
end;

procedure TMainForm.clImap4Server1SendResponse(Sender: TObject; AConnection: TclCommandConnection; const ACommand,
  AResponse: string);
begin
  PutLogMessage('Reply: ' + AResponse);
end;

procedure TMainForm.clImap4Server1Start(Sender: TObject);
begin
  PutLogMessage('=================='#13#10'Start Server');
end;

procedure TMainForm.clImap4Server1Stop(Sender: TObject);
begin
  PutLogMessage('Stop Server');
end;

procedure TMainForm.clImap4Server1AcceptConnection(Sender: TObject; AConnection: TclUserConnection; var Handled: Boolean);
begin
  PutLogMessage('Accept Connection. Host: ' + AConnection.PeerIP);
end;

procedure TMainForm.clImap4Server1Authenticate(Sender: TObject; AConnection: TclImap4CommandConnection;
  var Account: TclMailUserAccountItem; const AUserName: string; var IsAuthorized, Handled: Boolean);
begin
  if Account <> nil then
  begin
    PutLogMessage('Authenticate user: ' + Account.UserName);
  end;
end;

procedure TMainForm.clImap4Server1CloseConnection(Sender: TObject; AConnection: TclUserConnection);
begin
  if not FIsStop then
  begin
    PutLogMessage('Close Connection. Host: ' + AConnection.PeerIP);
  end;
end;

procedure TMainForm.clImap4Server1ReceiveCommand(Sender: TObject; AConnection: TclCommandConnection;
  ACommandParams: TclTcpCommandParams);
var
  connection: TProxiedConnection;
begin
  connection := AConnection as TProxiedConnection;

  if not connection.ConnectionInfoRead then
  begin
    connection.ConnectionInfoRead := True;

    PutLogMessage('Source IP: ' + connection.Proxy.SourceAddress + ', Port: ' + IntToStr(connection.Proxy.SourcePort));
    PutLogMessage('Destination IP: ' + connection.Proxy.DestinationAddress + ', Port: ' + IntToStr(connection.Proxy.DestinationPort));
  end;

  PutLogMessage('Command: ' + ACommandParams.Command + ' ' + ACommandParams.Parameters);
end;

procedure TMainForm.clImap4Server1CreateConnection(Sender: TObject; var AConnection: TclUserConnection);
begin
  AConnection := TProxiedConnection.Create();
end;

procedure TMainForm.btnTestProxyHeaderClick(Sender: TObject);
var
  stream: TStringStream;
  proxy: TProxyHeaderParser;
begin
  proxy := nil;
  stream := nil;
  try
    proxy := TProxyHeaderParser.Create(True);
    stream := TStringStream.Create('PROXY TCP4 162.216.46.145 0.0.0.0 57523 143'#13#10'a protocol data follows here');

    PutLogMessage('Data before proxy header checking: "' + stream.DataString + '"');

    proxy.Check(stream);

    PutLogMessage('Proxied protocol: ' + proxy.ProxiedProtocol);
    PutLogMessage('Source IP: ' + proxy.SourceAddress + ', Port: ' + IntToStr(proxy.SourcePort));
    PutLogMessage('Destination IP: ' + proxy.DestinationAddress + ', Port: ' + IntToStr(proxy.DestinationPort));
    PutLogMessage('Data after proxy header checking: "' + stream.DataString + '"');
  finally
    stream.Free();
    proxy.Free();
  end;
end;

end.
