unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB,
  clThreadPool, clSyncUtils, clSmtp, clMailMessage, clSocketUtils;

type
  TForm1 = class(TForm)
    btnStart: TButton;
    Label1: TLabel;
    edtServer: TEdit;
    Label2: TLabel;
    edtUser: TEdit;
    Label3: TLabel;
    edtPassword: TEdit;
    Label4: TLabel;
    edtConnectionString: TEdit;
    btnStop: TButton;
    edtCount: TEdit;
    memLog: TMemo;
    procedure btnStartClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
  private
    FThreadPool: TclThreadPool;
    FThreadCount: Integer;
    FIsStop: Boolean;

    procedure SetThreadCounter(ACounter: Integer);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure ThreadDone();
    procedure LogMessage(const AMsg: string);
    procedure SetupSmtp(ASmtp: TclSmtp);
    function IsStop(): Boolean;
  end;

  TSmtpWorkItem = class(TclWorkItem)
  private
    FOwner: TForm1;
    FConnectionString: string;
    FSynchronizer: TclThreadSynchronizer;
    FLogMessage: string;
    FSmtp: TclSmtp;
    FMessage: TclMailMessage;

    procedure SyncThreadDone();
    procedure SyncLogMessage();
    procedure LogMessage(const AMsg: string);
    procedure SetupSmtp(ASmtp: TclSmtp);
    function IsStop(): Boolean;
    function CreateDataSet(): TDataSet;
    procedure ComposeEmail(ADs: TDataSet);
    procedure SendEmail();
  protected
    procedure Execute(AThread: TThread); override;
  public
    constructor Create(AOwner: TForm1; const AConnectionString: string);
    destructor Destroy; override;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

{ TSmtpWorkItem }

procedure TSmtpWorkItem.ComposeEmail(ADs: TDataSet);
begin
  //TODO replace it with your field names
  FMessage.BuildMessage(ADs.FieldByName('text').AsString, ADs.FieldByName('html').AsString);
  FMessage.Subject := ADs.FieldByName('subject').AsString;
  FMessage.From.FullAddress := ADs.FieldByName('from').AsString;
  FMessage.ToList.Add(ADs.FieldByName('tolist').AsString);
end;

constructor TSmtpWorkItem.Create(AOwner: TForm1; const AConnectionString: string);
begin
  inherited Create();

  FSynchronizer := TclThreadSynchronizer.Create();
  FSmtp := TclSmtp.Create(nil);
  FMessage := TclMailMessage.Create(nil);
  FOwner := AOwner;
  FConnectionString := AConnectionString;
end;

function TSmtpWorkItem.CreateDataSet: TDataSet;
begin
  Result := nil; //TODO create a dataset(query), connect it to a database using m_connectionString
end;

destructor TSmtpWorkItem.Destroy;
begin
  FMessage.Free();
  FSmtp.Free();
  FSynchronizer.Free();

  inherited Destroy();
end;

procedure TSmtpWorkItem.Execute(AThread: TThread);
var
  ds: TDataSet;
  cnt: Integer;
begin
  try
    SetupSmtp(FSmtp);

    LogMessage('Open: ' + FConnectionString);
    FSmtp.Open();
    try
      ds := CreateDataSet();
      try
        ds.First();
        cnt := 0;

        while (not ds.Eof) do
        begin
          if IsStop() then Break;

          LogMessage('Send ' + IntToStr(cnt) + ': ' + FConnectionString);
          ComposeEmail(ds);
          try
            SendEmail();
          except
            on EclSocketError do
            begin
              FSmtp.Close();
              FSmtp.Open();
            end;
          end;

          Inc(cnt);
          ds.Next();
        end;
      finally
        ds.Free();
      end;
    finally
      FSmtp.Close();
      LogMessage('Close: ' + FConnectionString);
    end;
  finally
    FSynchronizer.Synchronize(SyncThreadDone);
  end;
end;

function TSmtpWorkItem.IsStop: Boolean;
begin
  Result := FOwner.IsStop();
end;

procedure TSmtpWorkItem.LogMessage(const AMsg: string);
begin
  FLogMessage := AMsg;
  FSynchronizer.Synchronize(SyncLogMessage);
end;

procedure TSmtpWorkItem.SendEmail;
begin
  FSmtp.Send(FMessage);
end;

procedure TSmtpWorkItem.SetupSmtp(ASmtp: TclSmtp);
begin
  FOwner.SetupSmtp(FSmtp);
end;

procedure TSmtpWorkItem.SyncLogMessage;
begin
  FOwner.LogMessage(FLogMessage);
end;

procedure TSmtpWorkItem.SyncThreadDone;
begin
  FOwner.ThreadDone();
end;

{ TForm1 }

procedure TForm1.btnStartClick(Sender: TObject);
begin
  FIsStop := False;
  FThreadPool.QueueWorkItem(TSmtpWorkItem.Create(Self, edtConnectionString.Text));
  SetThreadCounter(FThreadCount + 1);
end;

procedure TForm1.btnStopClick(Sender: TObject);
begin
  FIsStop := True;
  while(FThreadCount > 0) do
  begin
    Application.ProcessMessages();
  end;
  FThreadPool.Stop();
  SetThreadCounter(0);
end;

constructor TForm1.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FThreadPool := TclThreadPool.Create(nil);
  SetThreadCounter(0);
end;

destructor TForm1.Destroy;
begin
  FThreadPool.Free();

  inherited Destroy();
end;

function TForm1.IsStop: Boolean;
begin
  Result := FIsStop;
end;

procedure TForm1.LogMessage(const AMsg: string);
begin
  memLog.Lines.Add(AMsg);
end;

procedure TForm1.SetThreadCounter(ACounter: Integer);
begin
  if (ACounter < 0) then
  begin
    ACounter := 0;
  end;

  FThreadCount := ACounter;
  edtCount.Text := IntToStr(FThreadCount);
  Application.ProcessMessages();
end;

procedure TForm1.SetupSmtp(ASmtp: TclSmtp);
begin
  ASmtp.Server := edtServer.Text;
  ASmtp.UserName := edtUser.Text;
  ASmtp.Password := edtPassword.Text;
end;

procedure TForm1.ThreadDone;
begin
  SetThreadCounter(FThreadCount - 1);
end;

end.
