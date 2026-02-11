unit MessagePersister;

interface

uses
  System.Classes, clMailMessage, clMC, clTcpClientTls;

type
  TclMailMessageStatus = (msDraft, msOutbox, msSent, msInbox, msDeleted);

  TclMailMessageList = class;

  TclMailMessageItem = class(TCollectionItem)
  private
    FMailMessage: TStrings;
    FStatus: TclMailMessageStatus;
    FMarkedAsRead: Boolean;
    FUID: string;
    FFrom: string;
    FSubject: string;
    FDate: TDateTime;
    FPriority: TclMessagePriority;
    procedure LoadProperties;
    procedure SetMarkedAsRead(const Value: Boolean);
    procedure SetStatus(const Value: TclMailMessageStatus);
    procedure SetMailMessage(const Value: TStrings);
    procedure MailMessageChange(Sender: TObject);
    function GetFrom: string;
    function GetSubject: string;
    function GetDate: TDateTime;
    function GetPriority: TclMessagePriority;
    procedure MessageChanged;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property From: string read GetFrom;
    property Subject: string read GetSubject;
    property Date: TDateTime read GetDate;
    property Priority: TclMessagePriority read GetPriority;
  published
    property MailMessage: TStrings read FMailMessage write SetMailMessage;
    property Status: TclMailMessageStatus read FStatus write SetStatus;
    property MarkedAsRead: Boolean read FMarkedAsRead write SetMarkedAsRead;
    property UID: string read FUID write FUID;
  end;

  TclMailMessageList = class(TCollection)
  private
    FOnMessageChanged: TNotifyEvent;
    function GetItem(Index: Integer): TclMailMessageItem;
    procedure SetItem(Index: Integer; const Value: TclMailMessageItem);
    procedure MessageChanged;
  protected
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create();
    function Add(): TclMailMessageItem;
    procedure Load(const AFileName: string);
    procedure Store(const AFileName: string);
    function Find(const AUID: string): TclMailMessageItem;
    property Items[Index: Integer]: TclMailMessageItem read GetItem write SetItem; default;
    property OnMessageChanged: TNotifyEvent read FOnMessageChanged write FOnMessageChanged;
  end;

  TclMailAccounts = class(TComponent)
  private
    FPOP3Sasl: Boolean;
    FSMTPSasl: Boolean;
    FPOP3Port: Integer;
    FSMTPPort: Integer;
    FPOP3Server: string;
    FPOP3User: string;
    FPOP3Password: string;
    FSMTPServer: string;
    FSMTPUser: string;
    FSMTPPassword: string;
    FName: string;
    FEMail: string;
    FLeaveMessage: Boolean;
    FTimeOut: Integer;
    FSendImmediately: Boolean;
    FPOP3SecurityMode: TclClientTlsMode;
    FSMTPSecurityMode: TclClientTlsMode;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Load(const AFileName: string);
    procedure Store(const AFileName: string);
  published
    property Name: string read FName write FName;
    property EMail: string read FEMail write FEMail;
    property POP3Server: string read FPOP3Server write FPOP3Server;
    property POP3User: string read FPOP3User write FPOP3User;
    property POP3Password: string read FPOP3Password write FPOP3Password;
    property SMTPServer: string read FSMTPServer write FSMTPServer;
    property SMTPUser: string read FSMTPUser write FSMTPUser;
    property SMTPPassword: string read FSMTPPassword write FSMTPPassword;
    property POP3Sasl: Boolean read FPOP3Sasl write FPOP3Sasl;
    property SMTPSasl: Boolean read FSMTPSasl write FSMTPSasl;
    property POP3Port: Integer read FPOP3Port write FPOP3Port;
    property SMTPPort: Integer read FSMTPPort write FSMTPPort;
    property POP3SecurityMode: TclClientTlsMode read FPOP3SecurityMode write FPOP3SecurityMode default ctNone;
    property SMTPSecurityMode: TclClientTlsMode read FSMTPSecurityMode write FSMTPSecurityMode default ctNone;
    property LeaveMessage: Boolean read FLeaveMessage write FLeaveMessage;
    property TimeOut: Integer read FTimeOut write FTimeOut;
    property SendImmediately: Boolean read FSendImmediately write FSendImmediately default True;
  end;

implementation

uses
  System.SysUtils;

{ TclMailMessageItem }

procedure TclMailMessageItem.Assign(Source: TPersistent);
begin
  if (Source is TclMailMessageItem) then
  begin
    MailMessage.Assign((Source as TclMailMessageItem).MailMessage);
    Status := (Source as TclMailMessageItem).Status;
    MarkedAsRead := (Source as TclMailMessageItem).MarkedAsRead;
  end else
  begin
    inherited Assign(Source);
  end;
end;

procedure TclMailMessageItem.MailMessageChange(Sender: TObject);
begin
  MessageChanged();
end;

constructor TclMailMessageItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FMailMessage := TStringList.Create();
  TStringList(FMailMessage).OnChange := MailMessageChange;
end;

destructor TclMailMessageItem.Destroy;
begin
  FMailMessage.Free();
  inherited Destroy();
end;

procedure TclMailMessageItem.MessageChanged;
begin
  FFrom := '';
  FSubject := '';
  FDate := 0;
  FPriority := mpLow;
  (GetOwner() as TclMailMessageList).MessageChanged();
end;

procedure TclMailMessageItem.SetMailMessage(const Value: TStrings);
begin
  FMailMessage.Assign(Value);
end;

procedure TclMailMessageItem.SetMarkedAsRead(const Value: Boolean);
begin
  if (FMarkedAsRead <> Value) then
  begin
    FMarkedAsRead := Value;
    MessageChanged();
  end;
end;

procedure TclMailMessageItem.SetStatus(const Value: TclMailMessageStatus);
begin
  if (FStatus <> Value) then
  begin
    FStatus := Value;
    MessageChanged();
  end;
end;

function TclMailMessageItem.GetFrom: string;
begin
  if (FFrom = '') then
  begin
    LoadProperties();
  end;
  Result := FFrom;
end;

function TclMailMessageItem.GetSubject: string;
begin
  if (FSubject = '') then
  begin
    LoadProperties();
  end;
  Result := FSubject;
end;

function TclMailMessageItem.GetDate: TDateTime;
begin
  if (Round(FDate) = 0) then
  begin
    LoadProperties();
  end;
  Result := FDate;
end;

function TclMailMessageItem.GetPriority: TclMessagePriority;
begin
  if (FPriority = mpLow) then
  begin
    LoadProperties();
  end;
  Result := FPriority;
end;

procedure TclMailMessageItem.LoadProperties;
var
  Parser: TclMailMessage;
begin
  Parser := TclMailMessage.Create(nil);
  try
    Parser.HeaderSource := MailMessage;
    FFrom := Parser.From.FullAddress;
    FSubject := Parser.Subject;
    FDate := Parser.Date;
    FPriority := Parser.Priority;
  finally
    Parser.Free();
  end;
end;

{ TclMailMessageList }

constructor TclMailMessageList.Create;
begin
  inherited Create(TclMailMessageItem);
end;

function TclMailMessageList.GetItem(Index: Integer): TclMailMessageItem;
begin
  Result := (inherited GetItem(Index) as TclMailMessageItem);
end;

procedure TclMailMessageList.Load(const AFileName: string);
var
  Stream: TStream;
  R: TReader;
begin
  Clear();
  if not FileExists(AFileName) then Exit;
  Stream := nil;
  R := nil;
  try
    Stream := TFileStream.Create(AFileName, fmOpenRead);
    R := TReader.Create(Stream, 2048);
    R.ReadValue();
    R.ReadCollection(Self);
  finally
    R.Free();
    Stream.Free();
  end;
end;

procedure TclMailMessageList.Store(const AFileName: string);
var
  Stream: TStream;
  W: TWriter;
begin
  Stream := nil;
  W := nil;
  try
    Stream := TFileStream.Create(AFileName, fmCreate);
    W := TWriter.Create(Stream, 2048);
    W.WriteCollection(Self);
  finally
    W.Free();
    Stream.Free();
  end;
end;

procedure TclMailMessageList.MessageChanged;
begin
  if Assigned(OnMessageChanged) then
  begin
    OnMessageChanged(Self);
  end;
end;

procedure TclMailMessageList.SetItem(Index: Integer; const Value: TclMailMessageItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TclMailMessageList.Update(Item: TCollectionItem);
begin
  inherited Update(Item);
  MessageChanged();
end;

function TclMailMessageList.Add: TclMailMessageItem;
begin
  BeginUpdate();
  try
    Result := (inherited Add() as TclMailMessageItem);
  finally
    EndUpdate();
  end;
end;

function TclMailMessageList.Find(const AUID: string): TclMailMessageItem;
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
  begin
    Result := Items[i];
    if (Result.UID = AUID) then Exit;
  end;
  Result := nil;
end;

{ TclMailAccounts }

constructor TclMailAccounts.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FPOP3Port := 110;
  FSMTPPort := 25;
  FTimeOut := 60;
  FSendImmediately := True;
  FPOP3SecurityMode := ctNone;
  FSMTPSecurityMode := ctNone;
end;

procedure TclMailAccounts.Load(const AFileName: string);
var
  Stream: TStream;
begin
  if not FileExists(AFileName) then Exit;
  Stream := TFileStream.Create(AFileName, fmOpenRead);
  try
    Stream.ReadComponent(Self);
  finally
    Stream.Free();
  end;
end;

procedure TclMailAccounts.Store(const AFileName: string);
var
  Stream: TStream;
begin
  Stream := TFileStream.Create(AFileName, fmCreate);
  try
    Stream.WriteComponent(Self);
  finally
    Stream.Free();
  end;
end;

end.