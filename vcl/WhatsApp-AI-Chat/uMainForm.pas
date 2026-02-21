unit uMainForm;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Classes, System.IniFiles, System.SyncObjs,
  Vcl.Forms, Vcl.StdCtrls, Vcl.Controls,
  clHttpServer, clHttpHeader, clJson,
  uOpenAIClient, uWhatsAppClient, clTcpServer, clTcpServerTls, clUriUtils;

type
  TMainForm = class(TForm)
    btnStart: TButton;
    btnStop: TButton;
    memLog: TMemo;
    edtPort: TEdit;
    lblPort: TLabel;
    HttpServer: TclHttpServer;
    btnTestReply: TButton;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure btnTestReplyClick(Sender: TObject);
    procedure HttpServerReceiveRequest(Sender: TObject;
      AConnection: TclHttpUserConnection;
      const AMethod, AUri: string;
      AHeader: TclHttpRequestHeader; ABody: TStream);
  private
    FVerifyToken: string;
    FWhatsAppToken: string;
    FPhoneNumberId: string;
    FOpenAIKey: string;
    FCritical: TCriticalSection;

    procedure LoadConfig;
    procedure Log(const S: string);
    procedure ProcessIncomingMessage(const AFrom, AName, AText: string);
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  HttpServer.Stop;
  FreeAndNil(FCritical);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FCritical := TCriticalSection.Create;
  LoadConfig;
end;

procedure TMainForm.LoadConfig;
var
  Ini: TIniFile;
  Path: string;
begin
  Path := ChangeFileExt(Application.ExeName, '.ini');
  Ini := TIniFile.Create(Path);
  try
    FVerifyToken   := Ini.ReadString('Environment', 'WHATSAPP_VERIFY_TOKEN', '');
    FWhatsAppToken := Ini.ReadString('Environment', 'WHATSAPP_ACCESS_TOKEN', '');
    FPhoneNumberId := Ini.ReadString('Environment', 'WHATSAPP_PHONE_NUMBER_ID', '');
    FOpenAIKey     := Ini.ReadString('Environment', 'OPENAI_API_KEY', '');
    edtPort.Text   := Ini.ReadString('Environment', 'PORT', '5000');
  finally
    Ini.Free;
  end;
end;

procedure TMainForm.btnStartClick(Sender: TObject);
begin
  HttpServer.Port := StrToIntDef(edtPort.Text, 5000);
  HttpServer.Start;
  Log('Server started');
end;

procedure TMainForm.btnStopClick(Sender: TObject);
begin
  HttpServer.Stop;
  Log('Server stopped');
end;

procedure TMainForm.Log(const S: string);
begin
  if not (csDestroying in ComponentState) and Assigned(FCritical) then
  begin
    FCritical.Enter;
    try
      memLog.Lines.Add(S);
    finally
      FCritical.Leave;
    end;
  end;
end;

procedure TMainForm.HttpServerReceiveRequest(Sender: TObject;
  AConnection: TclHttpUserConnection;
  const AMethod, AUri: string;
  AHeader: TclHttpRequestHeader; ABody: TStream);
var
  UrlParser: TclUrlParser;
  Params: TStringList;
  Query, Mode, Token, Challenge: string;

  Bytes: TBytes;
  JsonStr: string;

  Json: TclJSONObject;
  Entry, Changes, ValueObj: TclJSONObject;
  ContactsArr, MessagesArr: TclJSONArray;
  FromNum, FromName, TextMsg: string;
begin
  Log(AMethod + ' ' + AUri);

  UrlParser := TclUrlParser.Create;
  try
    UrlParser.Parse(AUri);

    if not SameText(UrlParser.Path, '/webhook') then
    begin
      Exit;
    end;

    Query := UrlParser.QueryString;
  finally
    UrlParser.Free;
  end;

  { -------------------- GET (verification) -------------------- }
  if SameText(AMethod, 'GET') then
  begin
    Params := TStringList.Create;
    try
      Params.Delimiter := '&';
      Params.StrictDelimiter := True;

      if Pos('?', Query) = 1 then
      begin
        Delete(Query, 1, 1);
      end;
      Params.DelimitedText := Query;

      Mode := Params.Values['hub.mode'];
      Token := Params.Values['hub.verify_token'];
      Challenge := Params.Values['hub.challenge'];

      if (Mode = 'subscribe') and (Token = FVerifyToken) then
        HttpServer.SendResponse(AConnection, 200, 'OK', Challenge)
      else
        HttpServer.SendResponse(AConnection, 403, 'Forbidden', 'Verification failed');
    finally
      Params.Free;
    end;

    Exit;
  end;

  { -------------------- Method check -------------------- }
  if not SameText(AMethod, 'POST') then
  begin
    HttpServer.SendResponse(AConnection, 405, 'Method Not Allowed', '');
    Exit;
  end;

  { -------------------- POST -------------------- }
  if (ABody = nil) or (ABody.Size = 0) then
  begin
    HttpServer.SendResponse(AConnection, 400, 'Bad Request', '');
    Exit;
  end;

  ABody.Position := 0;
  SetLength(Bytes, ABody.Size);
  if ABody.Size > 0 then
    ABody.ReadBuffer(Bytes, Length(Bytes));

  JsonStr := TEncoding.UTF8.GetString(Bytes);

  try
    Json := TclJSONObject.ParseObject(JsonStr);
  except
    HttpServer.SendResponse(AConnection, 400, 'Bad Request', '');
    Exit;
  end;

  try
    Entry := Json.ArrayByName('entry').Objects[0];
    Changes := Entry.ArrayByName('changes').Objects[0];
    ValueObj := Changes.ObjectByName('value');

    ContactsArr := ValueObj.ArrayByName('contacts');
    if ContactsArr.Count > 0 then
      FromName := ContactsArr.Objects[0]
        .ObjectByName('profile')
        .ValueByName('name');

    MessagesArr := ValueObj.ArrayByName('messages');
    if MessagesArr.Count = 0 then
    begin
      HttpServer.SendResponse(AConnection, 200, 'OK', 'EVENT_RECEIVED');
      Exit;
    end;

    FromNum := MessagesArr.Objects[0].ValueByName('from');

    if MessagesArr.Objects[0].ObjectByName('text') <> nil then
      TextMsg := MessagesArr.Objects[0]
        .ObjectByName('text')
        .ValueByName('body')
    else
    begin
      HttpServer.SendResponse(AConnection, 200, 'OK', 'EVENT_RECEIVED');
      Exit;
    end;

  finally
    Json.Free;
  end;

  HttpServer.SendResponse(AConnection, 200, 'OK', 'EVENT_RECEIVED');

  TThread.CreateAnonymousThread(
    procedure
    begin
      ProcessIncomingMessage(FromNum, FromName, TextMsg);
    end
  ).Start;
end;

procedure TMainForm.btnTestReplyClick(Sender: TObject);
begin
  TThread.CreateAnonymousThread(
    procedure
    begin
      ProcessIncomingMessage('your_test_whatsapp_phone_number', 'Mike', 'Write a quatrain about vacation');
    end
  ).Start;
end;

procedure TMainForm.ProcessIncomingMessage(
  const AFrom, AName, AText: string);
var
  Reply: string;
begin
  try
    TThread.Synchronize(nil,
      procedure
      begin
        Log('Message sender: ' + AName);
        Log('Message from ' + AFrom + ': ' + AText);
      end);

    Reply := TOpenAIClient.GenerateReply(FOpenAIKey, AName, AText);
    TWhatsAppClient.SendMessage(FWhatsAppToken, FPhoneNumberId, AFrom, Reply);

    TThread.Synchronize(nil,
      procedure
      begin
        Log('Replied to ' + AFrom + ': ' + Reply);
      end);
  except
    on E: Exception do
    begin
      TThread.Synchronize(nil,
        procedure
        begin
          Log('ERROR: ' + E.ClassName + ': ' + E.Message);
        end);
    end;
  end;
end;

end.