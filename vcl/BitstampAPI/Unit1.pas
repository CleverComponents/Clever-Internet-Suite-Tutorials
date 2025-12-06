unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, clHttpRequest,
  clTcpClient, clTcpClientTls, clHttp, clUtils, clUriUtils, clCryptMac, clTranslator;

type
  TForm1 = class(TForm)
    btnSubmit: TButton;
    http: TclHttp;
    request: TclHttpRequest;
    memResponse: TMemo;
    Label1: TLabel;
    procedure btnSubmitClick(Sender: TObject);
  private
    function GenerateNonce: string;
    function GenerateTimestamp: string;
    function GetPayload(const ARequestData: string): string;
    function GetSignature(const ADataToSign: string): string;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

const
  api_key = 'api_key';
  api_secret = 'api_key_secret';

function TForm1.GenerateNonce: string;
begin
  Result := TGuid.NewGuid().ToString().ToLower().Trim(['{', '}']);
end;

function TForm1.GenerateTimestamp: string;
var
  time_since_epoch: Comp;
begin
  time_since_epoch := TimeStampToMSecs(DateTimeToTimeStamp(LocalTimeToGlobalTime(Now())))
    - TimeStampToMSecs(DateTimeToTimeStamp(EncodeDate(1970, 1, 1)));
  Result := FloatToStr(time_since_epoch);
end;

function TForm1.GetPayload(const ARequestData: string): string;
begin
  Result := TclFormFieldEncoder.Encode(ARequestData, '');
end;

function TForm1.GetSignature(const ADataToSign: string): string;
var
  hash: TclHmacSha256;
  key, data: TBytes;
begin
  hash := TclHmacSha256.Create();
  try
    key := TclTranslator.GetBytes(api_secret, '');
    data := TclTranslator.GetBytes(ADataToSign, '');

    hash.Init(key, 0, Length(key));

    hash.Update(data, 0, Length(data));

    Result := BytesToHex(hash.Digest()).ToLower();
  finally
    hash.Free();
  end;
end;

procedure TForm1.btnSubmitClick(Sender: TObject);
var
  x_auth,
  x_auth_nonce,
  x_auth_timestamp,
  x_auth_version,
  content_type,
  payload,
  http_method,
  url_host,
  url_path,
  url_query,
  x_auth_signature: string;
  data_to_sign: TStringBuilder;
  url, response: string;
begin
  //http.ProxySettings.Server := '20.81.62.32';
  //http.ProxySettings.Port := 3128;

  x_auth := 'BITSTAMP ' + api_key;
  x_auth_nonce := GenerateNonce();
  x_auth_timestamp := GenerateTimestamp();
  x_auth_version := 'v2';
  content_type := 'application/x-www-form-urlencoded';
  payload := GetPayload('{offset:1}');
  http_method := 'POST';
  url_host := 'www.bitstamp.net';
  url_path := '/api/v2/user_transactions/';
  url_query := '';

  data_to_sign := TStringBuilder.Create();
  try
    data_to_sign.Append(x_auth);
    data_to_sign.Append(http_method);
    data_to_sign.Append(url_host);
    data_to_sign.Append(url_path);
    data_to_sign.Append(url_query);
    data_to_sign.Append(content_type);
    data_to_sign.Append(x_auth_nonce);
    data_to_sign.Append(x_auth_timestamp);
    data_to_sign.Append(x_auth_version);
    data_to_sign.Append(payload);

    x_auth_signature := GetSignature(data_to_sign.ToString());
  finally
    data_to_sign.Free();
  end;

  url := 'https://' + url_host + url_path + url_query;

  request.Clear();

  request.AddTextData(payload);

  request.Header.Accept := '';
  request.Header.AcceptEncoding := '';
  request.Header.ExtraFields.Add('X-Auth: ' + x_auth);
  request.Header.ExtraFields.Add('X-Auth-Signature: ' + x_auth_signature);
  request.Header.ExtraFields.Add('X-Auth-Nonce: ' + x_auth_nonce);
  request.Header.ExtraFields.Add('X-Auth-Timestamp: ' + x_auth_timestamp);
  request.Header.ExtraFields.Add('X-Auth-Version: ' + x_auth_version);
  request.Header.ContentType := content_type;

  http.SilentHTTP := True;
  response := http.Post(url, request);

  memResponse.Lines.Text := response;

  ShowMessage('Done');
end;

end.
