unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, clHttpRequest, clTcpClient,
  clTcpClientTls, clHttp, Vcl.StdCtrls, clJsonSerializerBase, clJsonSerializer, clJson;

type
  TForm1 = class(TForm)
    btnSendJSONString: TButton;
    clHttp1: TclHttp;
    clHttpRequest1: TclHttpRequest;
    btnSendSerializedObject: TButton;
    btnSendJSONObject: TButton;
    memResult: TMemo;
    procedure btnSendJSONStringClick(Sender: TObject);
    procedure btnSendSerializedObjectClick(Sender: TObject);
    procedure btnSendJSONObjectClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FBaseURL: string;
    FMethod: string;
    procedure DisplayResponse(const AMethod: string; AResponseBody: TStringStream);
    procedure HandleHTTPError(const AOperation: string; AHttp: TclHttp);
  public
    { Public declarations }
  end;

  TPostRequest = class
  private
    FTitle: string;
    FBody: string;
    FUserId: Integer;
  public
    [TclJsonString('title')]
    property Title: string read FTitle write FTitle;

    [TclJsonString('body')]
    property Body: string read FBody write FBody;

    [TclJsonProperty('userId')]
    property UserId: Integer read FUserId write FUserId;
  end;

  TPostResponse = class
  private
    FId: Integer;
    FTitle: string;
    FBody: string;
    FUserId: Integer;
  public
    [TclJsonProperty('id')]
    property Id: Integer read FId write FId;

    [TclJsonString('title')]
    property Title: string read FTitle write FTitle;

    [TclJsonString('body')]
    property Body: string read FBody write FBody;

    [TclJsonProperty('userId')]
    property UserId: Integer read FUserId write FUserId;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  // Demo configuration with JSONPlaceholder
  // Note: JSONPlaceholder expects POST for creating resources
  // but this tutorial demonstrates GET with JSON data
  FBaseURL := 'https://jsonplaceholder.typicode.com';
  FMethod := 'POST';

  //{
  // For real API usage, comment the line above and uncomment below:
  // FBaseURL := 'https://service.domain.com';
  // FMethod := 'GET';
  // Also update JSON structures and endpoints accordingly
  //}

  memResult.Clear();
  memResult.Lines.Add('JSON GET Request Demo');
  memResult.Lines.Add('Using JSONPlaceholder service');
  memResult.Lines.Add('================================');
  memResult.Lines.Add('');
end;

procedure TForm1.HandleHTTPError(const AOperation: string; AHttp: TclHttp);
begin
  memResult.Lines.Add(Format('Error %s: Status %d - %s',
    [AOperation, AHttp.StatusCode, AHttp.StatusText]));
end;

procedure TForm1.DisplayResponse(const AMethod: string; AResponseBody: TStringStream);
begin
  memResult.Lines.Add('');
  memResult.Lines.Add(Format('=== Response from %s ===', [AMethod]));
  memResult.Lines.Add(AResponseBody.DataString);
  memResult.Lines.Add('================================');
end;

procedure TForm1.btnSendJSONStringClick(Sender: TObject);
var
  request: string;
  responseBody: TStringStream;
  responseHeader: TStringList;
begin
  memResult.Lines.Add('');
  memResult.Lines.Add('Method 1: Raw JSON String');
  memResult.Lines.Add('Creating JSON request as raw string...');

  // Method 1: Raw JSON string
  request :=
'{' +
'  "title": "JSON String Method",' +
'  "body": "This request was created using raw JSON string",' +
'  "userId": 1' +
'}';

  responseBody := nil;
  responseHeader := nil;
  try
    clHttpRequest1.Clear();
    clHttpRequest1.BuildJSONRequest(request);

    responseBody := TStringStream.Create('', TEncoding.UTF8);
    responseHeader := TStringList.Create();

    // Note: JSONPlaceholder expects POST for creating resources
    // but this tutorial demonstrates GET with JSON data
    clHttp1.SilentHTTP := True;
    clHttp1.SendRequest(FMethod, FBaseURL + '/posts', clHttpRequest1, responseHeader, responseBody);

    if (clHttp1.StatusCode = 201) then
    begin
      DisplayResponse('Raw JSON String Method', responseBody);
    end else
    begin
      HandleHTTPError('JSON String Method', clHttp1);
    end;
  finally
    responseBody.Free();
    responseHeader.Free();
  end;
end;

procedure TForm1.btnSendSerializedObjectClick(Sender: TObject);
var
  request: TPostRequest;
  requestBody: string;
  response: TPostResponse;
  responseBody: TStringStream;
  responseHeader: TStringList;
  serializer: TclJsonSerializer;
begin
  memResult.Lines.Add('');
  memResult.Lines.Add('Method 2: Object Serialization');
  memResult.Lines.Add('Creating JSON request via object serialization...');

  request := nil;
  response := nil;
  responseBody := nil;
  responseHeader := nil;
  serializer := nil;
  try
    // Method 2: Object serialization using TclJsonSerializer
    request := TPostRequest.Create();

    request.Title := 'Serialized Object Method';
    request.Body := 'This request was created using object serialization with TclJsonSerializer';
    request.UserId := 1;

    serializer := TclJsonSerializer.Create();

    // Convert object to JSON string
    requestBody := serializer.ObjectToJson(request);
    memResult.Lines.Add('Serialized JSON: ' + requestBody);

    clHttpRequest1.Clear();
    clHttpRequest1.BuildJSONRequest(requestBody);

    responseBody := TStringStream.Create('', TEncoding.UTF8);
    responseHeader := TStringList.Create();

    // Note: JSONPlaceholder expects POST for creating resources
    // but this tutorial demonstrates GET with JSON data
    clHttp1.SilentHTTP := True;
    clHttp1.SendRequest(FMethod, FBaseURL + '/posts', clHttpRequest1, responseHeader, responseBody);

    if (clHttp1.StatusCode = 201) then
    begin
      // Deserialize response back to object
      response := serializer.JsonToObject(TPostResponse, responseBody.DataString) as TPostResponse;

      memResult.Lines.Add('');
      memResult.Lines.Add('=== Deserialized Response ===');
      memResult.Lines.Add(Format('ID: %d', [response.Id]));
      memResult.Lines.Add(Format('Title: %s', [response.Title]));
      memResult.Lines.Add(Format('Body: %s', [response.Body]));
      memResult.Lines.Add(Format('User ID: %d', [response.UserId]));
      memResult.Lines.Add('================================');
    end else
    begin
      HandleHTTPError('Object Serialization Method', clHttp1);
    end;
  finally
    serializer.Free();
    responseBody.Free();
    responseHeader.Free();
    response.Free();
    request.Free();
  end;
end;

procedure TForm1.btnSendJSONObjectClick(Sender: TObject);
var
  request: TclJSONObject;
  response: TclJSONObject;
  responseBody: TStringStream;
  responseHeader: TStringList;
begin
  memResult.Lines.Add('');
  memResult.Lines.Add('Method 3: TclJSONObject API');
  memResult.Lines.Add('Creating JSON request using TclJSONObject class...');

  request := nil;
  response := nil;
  responseBody := nil;
  responseHeader := nil;
  try
    // Method 3: Direct TclJSONObject manipulation
    request := TclJSONObject.Create();

    request.AddString('title', 'TclJSONObject API Method');
    request.AddString('body', 'This request was created using TclJSONObject API');
    // Use AddValue for numeric values
    request.AddValue('userId', '1');

    memResult.Lines.Add('Created JSON: ' + request.GetJSONString());

    clHttpRequest1.Clear();
    clHttpRequest1.BuildJSONRequest(request);

    responseBody := TStringStream.Create('', TEncoding.UTF8);
    responseHeader := TStringList.Create();

    // Note: JSONPlaceholder expects POST for creating resources
    // but this tutorial demonstrates GET with JSON data
    clHttp1.SilentHTTP := True;
    clHttp1.SendRequest(FMethod, FBaseURL + '/posts', clHttpRequest1, responseHeader, responseBody);

    if (clHttp1.StatusCode = 201) then
    begin
      response := TclJSONObject.ParseObject(responseBody.DataString);

      memResult.Lines.Add('');
      memResult.Lines.Add('=== Parsed Response ===');
      memResult.Lines.Add(Format('ID: %s', [response.ValueByName('id')]));
      memResult.Lines.Add(Format('Title: %s', [response.ValueByName('title')]));
      memResult.Lines.Add(Format('Body: %s', [response.ValueByName('body')]));
      memResult.Lines.Add(Format('User ID: %s', [response.ValueByName('userId')]));
      memResult.Lines.Add('================================');
    end else
    begin
      HandleHTTPError('TclJSONObject API Method', clHttp1);
    end;
  finally
    responseBody.Free();
    responseHeader.Free();
    response.Free();
    request.Free();
  end;
end;

end.
