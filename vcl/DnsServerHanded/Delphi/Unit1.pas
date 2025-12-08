unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, clUdpServer, clDnsServer, Vcl.StdCtrls, clDnsMessage, SyncObjs;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Memo1: TMemo;
    clDnsServer1: TclDnsServer;
    Label1: TLabel;
    edtPort: TEdit;
    Label2: TLabel;
    edtBinding: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure clDnsServer1Start(Sender: TObject);
    procedure clDnsServer1Stop(Sender: TObject);
    procedure clDnsServer1ReceiveQuery(Sender: TObject; AConnection: TclUdpUserConnection; AQuery: TclDnsMessage);
    procedure clDnsServer1SendResponse(Sender: TObject; AConnection: TclUdpUserConnection; AQuery: TclDnsMessage; AResponse: TclDnsMessage);
    procedure clDnsServer1GetHandedRecords(Sender: TObject; AConnection: TclUdpUserConnection; const AName: string; ARecords: TclDnsRecordList);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FSynchronizer: TCriticalSection;
    procedure PutLogMessage(const ALogMessage: string);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  if (clDnsServer1.Active) then
  begin
    ShowMessage('The server is started');
    Exit;
  end;

  clDnsServer1.LocalBinding := edtBinding.Text;
  clDnsServer1.Port := StrToInt(edtPort.Text);
  clDnsServer1.Start();
end;

procedure TForm1.clDnsServer1Start(Sender: TObject);
begin
  PutLogMessage('=== Server start ===');
end;

procedure TForm1.clDnsServer1Stop(Sender: TObject);
begin
  PutLogMessage('=== Stop');
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FSynchronizer := TCriticalSection.Create();
  edtPort.Text :=  IntToStr(clDnsServer1.Port);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
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

procedure TForm1.clDnsServer1ReceiveQuery(Sender: TObject; AConnection: TclUdpUserConnection; AQuery: TclDnsMessage);
begin
  if (AQuery.Queries.Count > 0) then
  begin
    PutLogMessage('Query received: ' + GetRecordTypeStr(AQuery.Queries[0].RecordType) + ' ' + AQuery.Queries[0].Name);
  end else
  begin
    PutLogMessage('Query received');
  end;
end;

procedure TForm1.clDnsServer1SendResponse(Sender: TObject; AConnection: TclUdpUserConnection; AQuery: TclDnsMessage; AResponse: TclDnsMessage);
begin
  if (AResponse.Answers.Count > 0) then
  begin
    PutLogMessage('Response sent: ' + GetRecordTypeStr(AResponse.Answers[0].RecordType) + ' ' + AResponse.Answers[0].Name);
  end else
  begin
    PutLogMessage('Response sent');
  end;
end;

procedure TForm1.clDnsServer1GetHandedRecords(Sender: TObject; AConnection: TclUdpUserConnection; const AName: string; ARecords: TclDnsRecordList);
var
  soaRec: TclDnsSOARecord;
  nsRec: TclDnsNSRecord;
  aRec: TclDnsARecord;
begin
  ARecords.Clear();

  soaRec := TclDnsSOARecord.Create();
  ARecords.Add(soaRec);

  soaRec.Name := AName;
  soaRec.ExpirationLimit := 123;
  soaRec.MinimumTTL := 456;
  soaRec.RetryInterval := 789;
  soaRec.SerialNumber := 111222;
  soaRec.RefreshInterval := 987;
  soaRec.ResponsibleMailbox := 'mail.' + AName;
  soaRec.PrimaryNameServer := 'ns.' + AName;
  soaRec.TTL := 60000;

  nsRec := TclDnsNSRecord.Create();
  ARecords.Add(nsRec);

  nsRec.Name := AName;
  nsRec.NameServer := 'ns.' + AName;
  nsRec.TTL := 665000;

  aRec := TclDnsARecord.Create();
  ARecords.Add(aRec);

  aRec.Name := AName;
  aRec.IPAddress := '111.222.77.188';
  aRec.TTL := 60000;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  clDnsServer1.Stop();
end;

end.
