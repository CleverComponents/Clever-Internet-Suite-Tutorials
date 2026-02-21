unit uOpenAIClient;

interface

uses
  System.SysUtils, System.Classes,
  clHttp, clSspiTls, clHttpRequest, clJson;

type
  TOpenAIClient = class
  public
    class function GenerateReply(
      const ApiKey, UserName, UserText: string): string;
  end;

implementation

class function TOpenAIClient.GenerateReply(
  const ApiKey, UserName, UserText: string): string;
var
  Http: TclHttp;
  Req: TclHttpRequest;
  Json: TclJSONObject;
  RespStr: string;
  RespJson: TclJSONObject;
  FinalPrompt: string;
begin
  Result := '';

  Http := TclHttp.Create(nil);
  Req := TclHttpRequest.Create(nil);
  Json := TclJSONObject.Create;
  try
    Http.Authorization := 'Bearer ' + ApiKey;
    Http.UseSystemTLSFlags := False;
    Http.TLSFlags := [tfUseTLS12];

    { -------- System-style prompt like Python project -------- }

    FinalPrompt :=
      'You''re a kind assistant, say hello to the user.' + sLineBreak +
      'Username:' + sLineBreak +
      '''''''' + sLineBreak +
      UserName + sLineBreak +
      '''''''' + sLineBreak +
      'User request:' + sLineBreak +
      '''''''' + sLineBreak +
      UserText + sLineBreak +
      '''''''';

    Json.AddString('model', 'gpt-4o-mini');
    Json.AddString('input', FinalPrompt);

    Req.BuildJSONRequest(Json);

    RespStr := Http.Post(
      'https://api.openai.com/v1/responses',
      Req
    );

    RespJson := TclJSONObject.ParseObject(RespStr);
    try
      Result :=
        RespJson.ArrayByName('output').Objects[0]
        .ArrayByName('content').Objects[0]
        .ValueByName('text');
    finally
      RespJson.Free;
    end;

  finally
    Json.Free;
    Req.Free;
    Http.Free;
  end;
end;

end.
