unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, clHttpRequest, clTcpClient,
  clTcpClientTls, clHttp, Vcl.StdCtrls, clJson, Vcl.ExtCtrls;

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
    FAuthorization: string;

    procedure ShowObjectMembers(const AName: string; AJsonObject: TclJSONObject);
    procedure ShowArrayMembers(const AName: string; AJsonArray: TclJSONArray);
    procedure ShowArrayStrings(const AName: string; AJsonArray: TclJSONArray);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  FAuthorization := '1234567890';
end;

procedure TForm1.ShowObjectMembers(const AName: string; AJsonObject: TclJSONObject);
var
  i: Integer;
begin
  memResult.Lines.Add('');
  memResult.Lines.Add('Object "' + AName + '"');

  if (AJsonObject = nil) then Exit;

  for i := 0 to AJsonObject.Count - 1 do
  begin
    memResult.Lines.Add(AJsonObject.Members[i].Name + ' = ' + AJsonObject.Members[i].ValueString);
  end;
end;

procedure TForm1.ShowArrayMembers(const AName: string; AJsonArray: TclJSONArray);
var
  i: Integer;
begin
  memResult.Lines.Add('');
  memResult.Lines.Add('Object Array "' + AName + '"');

  if (AJsonArray = nil) then Exit;

  for i := 0 to AJsonArray.Count - 1 do
  begin
    ShowObjectMembers(IntToStr(i), AJsonArray.Objects[i]);
  end;
end;

procedure TForm1.ShowArrayStrings(const AName: string; AJsonArray: TclJSONArray);
var
  i: Integer;
begin
  memResult.Lines.Add('');
  memResult.Lines.Add('String Array "' + AName + '"');

  if (AJsonArray = nil) then Exit;

  for i := 0 to AJsonArray.Count - 1 do
  begin
    memResult.Lines.Add(IntToStr(i) + '. ' + AJsonArray.Items[i].ValueString);
  end;
end;

procedure TForm1.btnGetJobDetailsClick(Sender: TObject);
var
  response, data, job, client, service_provider: TclJSONObject;
  errors: TclJSONObject;
  furniture, visits, job_history: TclJSONArray;
  responseBody: TStringStream;
begin
  response := nil;
  responseBody := nil;
  try
    memResult.Clear();

    clHttpRequest1.Clear();
    clHttpRequest1.Header.Authorization := FAuthorization;

    responseBody := TStringStream.Create();

    clHttp1.SilentHTTP := True; //allow receiving detailed error information
    clHttp1.Get('https://service.domain.com/jobs/get/' + ism_reference.Text, clHttpRequest1, responseBody);

    response := TclJSONObject.ParseObject(responseBody.DataString);

    data := response.ObjectByName('data');

    if (clHttp1.StatusCode <> 200) or (data = nil) then
    begin
      errors := response.ObjectByName('errors');
      memResult.Lines.Add('code = ' + errors.ValueByName('code'));
    end else
    begin
      job := data.ObjectByName('job');

      ShowObjectMembers('job', job);

      client := data.ObjectByName('client');
      ShowObjectMembers('client', client);

      service_provider := data.ObjectByName('service_provider');
      ShowObjectMembers('service_provider', service_provider);

      furniture := data.ArrayByName('furniture');
      ShowArrayMembers('furniture', furniture);

      visits := data.ArrayByName('visits');
      ShowArrayMembers('visits', visits);

      job_history := data.ArrayByName('job_history');
      ShowArrayMembers('job_history', job_history);
    end;
  finally
    responseBody.Free();
    response.Free();
  end;
end;

procedure TForm1.btnCreateJobClick(Sender: TObject);
var
  request, response, errors: TclJSONObject;
  invalid_fields: TclJSONArray;
  responseBody: TStringStream;
begin
  request := nil;
  response := nil;
  responseBody := nil;
  try
    memResult.Lines.Clear();

    request := TclJSONObject.Create();

    request.AddString('client_ref', client_ref.Text);
    request.AddString('customer_title', customer_title.Text);
    request.AddString('customer_firstname', customer_firstname.Text);
    request.AddString('customer_surname', customer_surname.Text);
    request.AddString('customer_address', Trim(customer_address.Text)); //trimming to avoid trailing crlf symbols
    request.AddString('customer_postcode', customer_postcode.Text);
    request.AddString('customer_telephone', customer_telephone.Text);
    request.AddString('faults_client_description', Trim(faults_client_description.Text)); //trimming to avoid trailing crlf symbols
    request.AddString('clients_client', 'Tony''s furniture shop');
    request.AddString('furniture_manufacturer', 'Manufacturer Name');
    request.AddString('furniture_model', 'Model Name');
    request.AddString('furniture_batch', '12334');
    request.AddString('furniture_colour', 'Red');
    request.AddString('furniture_delivery_date', '2019-07-08');
    request.AddString('general_instructions', Trim(general_instructions.Text)); //trimming to avoid trailing crlf symbols

    clHttpRequest1.BuildJSONRequest(request);
    clHttpRequest1.Header.Authorization := FAuthorization;

    responseBody := TStringStream.Create();

    clHttp1.SilentHTTP := True; //allow receiving detailed error information
    clHttp1.Get('https://service.domain.com/jobs/add', clHttpRequest1, responseBody);

    response := TclJSONObject.ParseObject(responseBody.DataString);

    if (clHttp1.StatusCode <> 200) then
    begin
      errors := response.ObjectByName('errors');
      memResult.Lines.Add('code = ' + errors.ValueByName('code'));

      invalid_fields := errors.ArrayByName('invalid_fields');
      ShowArrayStrings('invalid_fields', invalid_fields);
    end else
    begin
      memResult.Lines.Add('ism_reference = ' + response.ValueByName('ism_reference'));
    end;
  finally
    responseBody.Free();
    response.Free();
    request.Free();
  end;
end;

end.
