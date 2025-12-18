unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, clHttpRequest, clTcpClient,
  clTcpClientTls, clHttp, Vcl.StdCtrls, clJson, ExtCtrls;

type
  TForm1 = class(TForm)
    clHttp1: TclHttp;
    clHttpRequest1: TclHttpRequest;
    btnCreateJob: TButton;
    general_instructions: TMemo;
    btnGetJobDetails: TButton;
    ism_reference: TEdit;
    Label1: TLabel;
    customer_title: TEdit;
    customer_firstname: TEdit;
    customer_surname: TEdit;
    customer_postcode: TEdit;
    customer_telephone: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label2: TLabel;
    faults_client_description: TMemo;
    memResult: TMemo;
    client_ref: TEdit;
    Label10: TLabel;
    customer_address: TMemo;
    Bevel1: TBevel;
    Label11: TLabel;
    Bevel2: TBevel;
    Label12: TLabel;
    procedure btnGetJobDetailsClick(Sender: TObject);
    procedure btnCreateJobClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FBaseURL: string;

    procedure ShowObjectMembers(const AName: string; AJsonObject: TclJSONObject);
    procedure HandleHTTPError(const AOperation: string; AHttp: TclHttp);
    function SendJSONRequest(const AMethod, AUrl: string; ARequestJSON: TclJSONObject = nil): TclJSONObject;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  // Demo configuration with JSONPlaceholder
  FBaseURL := 'https://jsonplaceholder.typicode.com';

  //{
  // For real API usage, comment the line above and uncomment below:
  // FBaseURL := 'https://service.domain.com';
  // Also set your authorization token in SendJSONRequest method
  //}

  // Update UI labels for demo clarity
  Label1.Caption := 'Post ID (1-100):';
  btnCreateJob.Caption := 'Create Demo Post';
  btnGetJobDetails.Caption := 'Get Demo Post';
end;

procedure TForm1.HandleHTTPError(const AOperation: string; AHttp: TclHttp);
begin
  memResult.Lines.Add(Format('Error %s: Status %d - %s',
    [AOperation, AHttp.StatusCode, AHttp.StatusText]));
end;

function TForm1.SendJSONRequest(const AMethod, AUrl: string; ARequestJSON: TclJSONObject = nil): TclJSONObject;
var
  responseBody: TStringStream;
  jsonString: string;
  responseHeader: TStringList;
begin
  Result := nil;
  responseBody := nil;
  responseHeader := nil;

  try
    clHttpRequest1.Clear();

    //{
    // For real API authentication, uncomment and set your authorization token:
    // clHttpRequest1.Header.Authorization := 'Bearer Your-Auth-Token-Here';
    //}

    if (ARequestJSON <> nil) then
    begin
      clHttpRequest1.BuildJSONRequest(ARequestJSON);
    end;

    responseBody := TStringStream.Create('', TEncoding.UTF8);
    responseHeader := TStringList.Create();
    clHttp1.SilentHTTP := True;

    clHttp1.SendRequest(AMethod, AUrl, clHttpRequest1, responseHeader, responseBody);

    jsonString := responseBody.DataString;
    if (jsonString <> '') then
    begin
      Result := TclJSONObject.ParseObject(jsonString);
    end;

  finally
    responseBody.Free();
    responseHeader.Free();
  end;
end;

procedure TForm1.ShowObjectMembers(const AName: string; AJsonObject: TclJSONObject);
var
  i: Integer;
begin
  memResult.Lines.Add('');
  memResult.Lines.Add('Object "' + AName + '"');

  if (AJsonObject = nil) then
  begin
    Exit;
  end;

  for i := 0 to AJsonObject.Count - 1 do
  begin
    memResult.Lines.Add(Format('  %s = %s',
      [AJsonObject.Members[i].Name, AJsonObject.Members[i].ValueString]));
  end;
end;

procedure TForm1.btnGetJobDetailsClick(Sender: TObject);
var
  response: TclJSONObject;
  postId: string;
begin
  memResult.Clear();

  // Demo with JSONPlaceholder - Get a post by ID
  if Trim(ism_reference.Text) = '' then
  begin
    postId := '1'; // Default to post ID 1
  end else
  begin
    postId := ism_reference.Text;
  end;

  memResult.Lines.Add('Demo: Fetching post from JSONPlaceholder...');
  memResult.Lines.Add('URL: ' + FBaseURL + '/posts/' + postId);
  memResult.Lines.Add('');
  memResult.Lines.Add('Note: This demo uses JSONPlaceholder service.');
  memResult.Lines.Add('For real API, update FBaseURL and JSON structure.');
  memResult.Lines.Add('');

  response := SendJSONRequest('GET', FBaseURL + '/posts/' + postId);

  if (response = nil) then
  begin
    HandleHTTPError('Get Post', clHttp1);
    Exit;
  end;

  try
    if (clHttp1.StatusCode = 200) then
    begin
      ShowObjectMembers('Post', response);

      // Show additional info
      memResult.Lines.Add('');
      memResult.Lines.Add('=== Post Details ===');
      memResult.Lines.Add('Title: ' + response.ValueByName('title'));
      memResult.Lines.Add('Body: ' + response.ValueByName('body'));
      memResult.Lines.Add('User ID: ' + response.ValueByName('userId'));
      memResult.Lines.Add('Post ID: ' + response.ValueByName('id'));
    end else
    begin
      HandleHTTPError('Get Post', clHttp1);
    end;
  finally
    response.Free();
  end;
end;

procedure TForm1.btnCreateJobClick(Sender: TObject);
var
  request, response: TclJSONObject;
begin
  memResult.Lines.Clear();
  memResult.Lines.Add('Demo: Creating new post on JSONPlaceholder...');
  memResult.Lines.Add('URL: ' + FBaseURL + '/posts');
  memResult.Lines.Add('');
  memResult.Lines.Add('Note: This demo uses JSONPlaceholder service.');
  memResult.Lines.Add('For real API, update FBaseURL and JSON structure.');
  memResult.Lines.Add('');

  request := TclJSONObject.Create();

  try
    // Create a sample post using form data
    request.AddString('userId', '1');

    if Trim(customer_title.Text) <> '' then
    begin
      request.AddString('title', customer_title.Text);
    end else
    begin
      request.AddString('title', 'Sample Post Title');
    end;

    if Trim(faults_client_description.Text) <> '' then
    begin
      request.AddString('body', faults_client_description.Text);
    end else
    if Trim(general_instructions.Text) <> '' then
    begin
      request.AddString('body', general_instructions.Text);
    end else
    begin
      request.AddString('body', 'This is the body of the sample post created using Clever Internet Suite REST client.');
    end;

    response := SendJSONRequest('POST', FBaseURL + '/posts', request);

    if (response = nil) then
    begin
      HandleHTTPError('Create Post', clHttp1);
      Exit;
    end;

    try
      if (clHttp1.StatusCode = 201) then // 201 Created
      begin
        memResult.Lines.Add('=== Post Created Successfully! ===');
        memResult.Lines.Add('');
        ShowObjectMembers('Created Post', response);

        memResult.Lines.Add('');
        memResult.Lines.Add('=== Summary ===');
        memResult.Lines.Add('New Post ID: ' + response.ValueByName('id'));
        memResult.Lines.Add('Title: ' + response.ValueByName('title'));
        memResult.Lines.Add('Status: ' + IntToStr(clHttp1.StatusCode) + ' Created');
      end else
      begin
        HandleHTTPError('Create Post', clHttp1);
        if (response <> nil) then
        begin
          memResult.Lines.Add('Response: ' + response.GetJSONString());
        end;
      end;
    finally
      response.Free();
    end;
  finally
    request.Free();
  end;
end;

end.
