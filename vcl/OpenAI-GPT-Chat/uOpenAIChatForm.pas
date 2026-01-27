unit uOpenAIChatForm;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Classes, System.IniFiles,
  Vcl.Forms, Vcl.StdCtrls, Vcl.Controls, Vcl.ExtCtrls,

  clHttp,
  clHttpRequest,
  clJson;

type
  TfrmOpenAIChat = class(TForm)
    memHistory: TMemo;
    pnlBottom: TPanel;
    memPrompt: TMemo;
    btnSend: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSendClick(Sender: TObject);
    procedure memPromptKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    FApiKey: string;
    FSystemPrompt: string;

    // Full chat history stored as two parallel lists (same index = one turn).
    FUserPrompts: TStringList;
    FAssistantReplies: TStringList;

    procedure LoadConfig;
    procedure ScrollHistoryToBottom;

    function BuildRequestJson(const ACurrentUserPrompt: string): string;
    function PostResponses(const ARequestJson: string; var AStatusCode: Integer; var AStatusText: string): string;

    function ExtractOutputText(const AResponseJson: string): string;
    procedure SelfCheckResponse(const AResponseJson: string; AStatusCode: Integer; const AStatusText: string);

    procedure AppendUser(const S: string);
    procedure AppendAssistant(const S: string);
    procedure AppendSystem(const S: string);
    procedure DoSendPrompt(const Prompt: string);
  end;

var
  frmOpenAIChat: TfrmOpenAIChat;

implementation

{$R *.dfm}

procedure TfrmOpenAIChat.FormCreate(Sender: TObject);
begin
  // System message injected as role=system on every request.
  FSystemPrompt := 'You are a professional Delphi developer.';

  memHistory.Clear;

  FUserPrompts := TStringList.Create;
  FAssistantReplies := TStringList.Create;

  LoadConfig;

  if FApiKey = '' then
  begin
    AppendSystem('ERROR: OpenAI API key not found.');
    AppendSystem('Create an INI file next to the executable:');
    AppendSystem('[OpenAI]');
    AppendSystem('ApiKey=YOUR_OPENAI_API_KEY');
    btnSend.Enabled := False;
    memPrompt.Enabled := False;
    Exit;
  end;

  AppendSystem('Ready. Type your message below. Send with Ctrl+Enter or the Send button.');
end;

procedure TfrmOpenAIChat.FormShow(Sender: TObject);
begin
  ActiveControl := memPrompt;
end;

procedure TfrmOpenAIChat.LoadConfig;
var
  Ini: TIniFile;
  IniName: string;
begin
  IniName := ChangeFileExt(Application.ExeName, '.ini');
  Ini := TIniFile.Create(IniName);
  try
    FApiKey := Trim(Ini.ReadString('OpenAI', 'ApiKey', ''));
  finally
    Ini.Free;
  end;
end;

procedure TfrmOpenAIChat.ScrollHistoryToBottom;
begin
  memHistory.SelStart := Length(memHistory.Text);
  memHistory.SelLength := 0;
  memHistory.Perform(EM_SCROLLCARET, 0, 0);
end;

procedure TfrmOpenAIChat.AppendSystem(const S: string);
begin
  memHistory.Lines.Add('[SYSTEM] ' + S);
  memHistory.Lines.Add('');
  ScrollHistoryToBottom;
end;

procedure TfrmOpenAIChat.AppendUser(const S: string);
var
  SL: TStringList;
begin
  memHistory.Lines.Add('[USER]');

  SL := TStringList.Create;
  try
    // Split by line breaks and append each line as a separate memo line
    SL.Text := S;
    memHistory.Lines.AddStrings(SL);
  finally
    SL.Free;
  end;

  ScrollHistoryToBottom;
end;

procedure TfrmOpenAIChat.AppendAssistant(const S: string);
var
  SL: TStringList;
begin
  memHistory.Lines.Add('[ASSISTANT]');

  SL := TStringList.Create;
  try
    // Split by line breaks and append each line as a separate memo line
    SL.Text := S;
    memHistory.Lines.AddStrings(SL);
  finally
    SL.Free;
  end;

  memHistory.Lines.Add(''); // separator line
  ScrollHistoryToBottom;
end;

function TfrmOpenAIChat.BuildRequestJson(const ACurrentUserPrompt: string): string;
var
  Root, ItemObj: TclJSONObject;
  InputArr: TclJSONArray;
  I: Integer;
begin
  Root := TclJSONObject.Create;
  try
    Root.AddRequiredString('model', 'gpt-4o-mini');

    InputArr := TclJSONArray.Create;
    Root.AddMember('input', InputArr);

    // 1) System message (always first)
    ItemObj := TclJSONObject.Create;
    ItemObj.AddRequiredString('role', 'system');
    ItemObj.AddRequiredString('content', FSystemPrompt);
    InputArr.Add(ItemObj);

    // 2) Full chat history: user/assistant pairs
    // Invariant: FUserPrompts.Count = FAssistantReplies.Count
    for I := 0 to FUserPrompts.Count - 1 do
    begin
      // User
      ItemObj := TclJSONObject.Create;
      ItemObj.AddRequiredString('role', 'user');
      ItemObj.AddRequiredString('content', FUserPrompts[I]);
      InputArr.Add(ItemObj);

      // Assistant
      ItemObj := TclJSONObject.Create;
      ItemObj.AddRequiredString('role', 'assistant');
      ItemObj.AddRequiredString('content', FAssistantReplies[I]);
      InputArr.Add(ItemObj);
    end;

    // 3) Current user prompt (not yet stored in history)
    ItemObj := TclJSONObject.Create;
    ItemObj.AddRequiredString('role', 'user');
    ItemObj.AddRequiredString('content', ACurrentUserPrompt);
    InputArr.Add(ItemObj);

    Result := Root.GetJSONString;
  finally
    Root.Free;
  end;
end;

function TfrmOpenAIChat.PostResponses(
  const ARequestJson: string;
  var AStatusCode: Integer;
  var AStatusText: string
): string;
var
  Http: TclHttp;
  Req: TclHttpRequest;
begin
  Http := TclHttp.Create(nil);
  Req := TclHttpRequest.Create(nil);
  try
    Http.UseSystemTLSFlags := False;

    Http.SilentHTTP := True;
    Http.Authorization := 'Bearer ' + FApiKey;

    Req.BuildJSONRequest(ARequestJson);

    Result := Http.Post('https://api.openai.com/v1/responses', Req);

    AStatusCode := Http.StatusCode;
    AStatusText := Http.StatusText;
  finally
    Req.Free;
    Http.Free;
  end;
end;

function TfrmOpenAIChat.ExtractOutputText(const AResponseJson: string): string;
var
  Root: TclJSONObject;
  OutputArr, ContentArr: TclJSONArray;
  OutItem, ContentItem: TclJSONObject;
  I, J: Integer;
  BlockType, BlockText: string;
begin
  Result := '';

  Root := TclJSONBase.ParseObject(AResponseJson);
  try
    // "output" is an array of output items
    OutputArr := Root.ArrayByName('output');
    if OutputArr = nil then Exit;

    for I := 0 to OutputArr.Count - 1 do
    begin
      OutItem := OutputArr.Objects[I];
      if OutItem = nil then Continue;

      // Each output item may include a "content" array
      ContentArr := OutItem.ArrayByName('content');
      if ContentArr = nil then Continue;

      for J := 0 to ContentArr.Count - 1 do
      begin
        ContentItem := ContentArr.Objects[J];
        if ContentItem = nil then Continue;

        BlockType := ContentItem.ValueByName('type');
        if SameText(BlockType, 'output_text') then
        begin
          BlockText := ContentItem.ValueByName('text');
          if BlockText <> '' then
          begin
            if Result <> '' then
              Result := Result + sLineBreak;
            Result := Result + BlockText;
          end;
        end;
      end;
    end;
  finally
    Root.Free;
  end;
end;

procedure TfrmOpenAIChat.SelfCheckResponse(
  const AResponseJson: string;
  AStatusCode: Integer;
  const AStatusText: string
);
var
  TextOut: string;
begin
  if AStatusCode >= 400 then
  begin
    AppendSystem(Format('HTTP ERROR %d %s', [AStatusCode, AStatusText]));
    AppendSystem('Raw response JSON: ' + AResponseJson);
    raise Exception.Create('The API returned an HTTP error.');
  end;

  TextOut := ExtractOutputText(AResponseJson);
  if TextOut = '' then
  begin
    AppendSystem('SELF-CHECK FAILED: No output_text blocks found in the response.');
    AppendSystem('Raw response JSON: ' + AResponseJson);
    raise Exception.Create('No output_text blocks found in the response.');
  end;
end;

procedure TfrmOpenAIChat.DoSendPrompt(const Prompt: string);
var
  ReqJson, RespJson, OutText, StatusText: string;
  StatusCode: Integer;
begin
  AppendUser(Prompt);

  btnSend.Enabled := False;
  memPrompt.Enabled := False;
  try
    // Sanity check for history consistency
    if FUserPrompts.Count <> FAssistantReplies.Count then
      raise Exception.Create('Internal error: chat history lists are out of sync.');

    ReqJson := BuildRequestJson(Prompt);
    RespJson := PostResponses(ReqJson, StatusCode, StatusText);

    // Self-check (HTTP + presence of output_text blocks)
    SelfCheckResponse(RespJson, StatusCode, StatusText);

    OutText := ExtractOutputText(RespJson);
    AppendAssistant(OutText);

    // Store the new turn
    FUserPrompts.Add(Prompt);
    FAssistantReplies.Add(OutText);

    // Final check: keep lists in sync
    if FUserPrompts.Count <> FAssistantReplies.Count then
      raise Exception.Create('Internal error: chat history lists became out of sync.');

    memPrompt.Clear;
  finally
    memPrompt.Enabled := True;
    btnSend.Enabled := True;
  end;

  ActiveControl := memPrompt;
end;

procedure TfrmOpenAIChat.btnSendClick(Sender: TObject);
var
  Prompt: string;
begin
  Prompt := Trim(memPrompt.Text);
  if Prompt = '' then Exit;
  DoSendPrompt(Prompt);
end;

procedure TfrmOpenAIChat.memPromptKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_RETURN) and (ssCtrl in Shift) then
  begin
    Key := 0;
    btnSendClick(btnSend);
  end;
end;

end.
