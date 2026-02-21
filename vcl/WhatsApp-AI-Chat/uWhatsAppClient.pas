unit uWhatsAppClient;

interface

uses
  System.SysUtils, System.Classes,
  clHttp, clHttpRequest, clJson;

type
  TWhatsAppClient = class
  public
    class procedure SendMessage(
      const Token, PhoneId, ToNumber, Text: string);
  end;

implementation

class procedure TWhatsAppClient.SendMessage(
  const Token, PhoneId, ToNumber, Text: string);
var
  Http: TclHttp;
  Req: TclHttpRequest;
  Json, TextObj: TclJSONObject;
  Url: string;
begin
  Http := TclHttp.Create(nil);
  Req := TclHttpRequest.Create(nil);
  Json := TclJSONObject.Create;
  try
    Http.Authorization := 'Bearer ' + Token;

    Url := 'https://graph.facebook.com/v21.0/' +
           PhoneId + '/messages';

    Json.AddString('messaging_product', 'whatsapp');
    Json.AddString('to', ToNumber);
    Json.AddString('type', 'text');

    TextObj := TclJSONObject.Create;
    TextObj.AddString('body', Text);
    Json.AddMember('text', TextObj);

    Req.BuildJSONRequest(Json);

    Http.Post(Url, Req);

  finally
    Json.Free;
    Req.Free;
    Http.Free;
  end;
end;

end.
