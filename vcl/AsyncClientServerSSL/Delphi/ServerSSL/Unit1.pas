unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SyncObjs,
  Dialogs, StdCtrls, clCertificateStore, clCertificate, clSslServer, clTcpServer, clTcpServerTls,
  clSspiTls, clWUtils, clUtils, clTranslator;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    edtPort: TEdit;
    btnStart: TButton;
    btnStop: TButton;
    Label2: TLabel;
    memLog: TMemo;
    clCertificateStore1: TclCertificateStore;
    edtData: TEdit;
    btnSend: TButton;
    procedure btnStartClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnSendClick(Sender: TObject);
  private
    FServer: TclSslServer;
    FIsStop: Boolean;
    FSynchronizer: TCriticalSection;

    procedure DoGetCertificate(Sender: TObject; var ACertificate: TclCertificate;
      AExtraCerts: TclCertificateList; var Handled: Boolean);
    procedure DoAcceptConnection(Sender: TObject; AConnection: TclUserConnection; var Handled: Boolean);
    procedure DoCloseConnection(Sender: TObject; AConnection: TclUserConnection);
    procedure DoReadConnection(Sender: TObject; AConnection: TclUserConnection; AData: TStream);
    procedure DoStart(Sender: TObject);
    procedure DoStop(Sender: TObject);
    procedure PutLogMessage(const ALogMessage: string);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnSendClick(Sender: TObject);
var
  i: Integer;
  stream: TStream;
  len: Integer;
  b: TclByteArray;
begin
  if (Length(edtData.Text) = 0) then raise Exception.Create('Nothing to send');

  FServer.BeginWork();
  stream := TMemoryStream.Create();
  try
    //write the size of data
    b := TclTranslator.GetBytes(edtData.Text, 'UTF-8');
    len := Length(b);
    stream.Write(len, SizeOf(len));

    //write data
    stream.Write(b[0], len);

    for i := 0 to FServer.ConnectionCount - 1 do
    begin
      stream.Position := 0;
      FServer.Connections[i].WriteData(stream);
    end;
  finally
    stream.Free();
    FServer.EndWork();
  end;
end;

procedure TForm1.btnStartClick(Sender: TObject);
begin
  FServer.Port := StrToInt(edtPort.Text);

  //forces the component to start SSL negotiation immediately once connecting
  FServer.UseTLS := stImplicit;

  //is used when running on Windows 10 version 1809 or later
  FServer.UseSystemTLSFlags := False;

  //specifies TLS 1.0 protocols (also available SSL 2.0 and SSL 3.0)
  FServer.TLSFlags := [tfUseTLS];

  //do not request client certificate for impersonation purposes
  FServer.RequireClientCertificate := False;

  FServer.Start();
end;

procedure TForm1.btnStopClick(Sender: TObject);
begin
  FIsStop := True;
  try
    FServer.Stop();
  finally
    FIsStop := False;
  end;
end;

procedure TForm1.DoAcceptConnection(Sender: TObject; AConnection: TclUserConnection; var Handled: Boolean);
begin
  PutLogMessage('Connected client: ' + AConnection.PeerIP);
end;

procedure TForm1.DoCloseConnection(Sender: TObject; AConnection: TclUserConnection);
begin
  if not FIsStop then
  begin
    PutLogMessage('Close Connection. Host: ' + AConnection.PeerIP);
  end;
end;

procedure TForm1.DoGetCertificate(Sender: TObject; var ACertificate: TclCertificate;
  AExtraCerts: TclCertificateList; var Handled: Boolean);
begin
  //creates self-signed server certificate
  if (clCertificateStore1.Items.Count = 0) then
  begin
    clCertificateStore1.ValidFrom := Date();
    clCertificateStore1.ValidTo := Date() + 365;
    clCertificateStore1.Items.Add(clCertificateStore1.CreateSelfSigned('CN=CleverTester,O=CleverComponents,E=CleverTester@company.mail', 0));
  end;
  ACertificate := clCertificateStore1.Items[0];
  Handled := True;
end;

procedure TForm1.DoReadConnection(Sender: TObject;
  AConnection: TclUserConnection; AData: TStream);
begin
  PutLogMessage(Format('Received from %s client: %d bytes', [AConnection.PeerIP, AData.Size]));
end;

procedure TForm1.DoStart(Sender: TObject);
begin
  PutLogMessage('=== Start ===');
end;

procedure TForm1.DoStop(Sender: TObject);
begin
  PutLogMessage('=== Stop');
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FSynchronizer := TCriticalSection.Create();
  
  FServer := TclSslServer.Create(nil);

  //assigns event handlers for server
  FServer.OnGetCertificate := DoGetCertificate;
  FServer.OnAcceptConnection := DoAcceptConnection;
  FServer.OnCloseConnection := DoCloseConnection;
  FServer.OnReadConnection := DoReadConnection;
  FServer.OnStart := DoStart;
  FServer.OnStop := DoStop;
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
      memLog.Lines.Add(ALogMessage);
    finally
      FSynchronizer.Leave();
    end;
  end;
end;

end.
