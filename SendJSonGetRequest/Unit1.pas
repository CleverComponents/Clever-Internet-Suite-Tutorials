unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, clHttpRequest, clTcpClient,
  clTcpClientTls, clHttp, Vcl.StdCtrls, clJsonSerializerBase, clJsonSerializer, clJson;

type
  TForm1 = class(TForm)
    btnSendJSonString: TButton;
    clHttp1: TclHttp;
    clHttpRequest1: TclHttpRequest;
    btnSendSerializedObject: TButton;
    btnSendJSonObject: TButton;
    procedure btnSendJSonStringClick(Sender: TObject);
    procedure btnSendSerializedObjectClick(Sender: TObject);
    procedure btnSendJSonObjectClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TCreateJobServiceRequest = class
  private
    FCustomerPostcode: string;
    FCustomerAddress: string;
    FCustomerFirstname: string;
    FGeneralInstructions: string;
    FFurnitureManufacturer: string;
    FClientRef: string;
    FFurnitureColour: string;
    FFurnitureModel: string;
    FClientsClient: string;
    FCustomerTelephone: string;
    FCustomerSurname: string;
    FCustomerTitle: string;
    FFurnitureDeliveryDate: string;
    FFurnitureBatch: string;
    FFaultsClientDescription: string;
  public
    [TclJsonString('client_ref')]
    property ClientRef: string read FClientRef write FClientRef;

    [TclJsonString('customer_title')]
    property CustomerTitle: string read FCustomerTitle write FCustomerTitle;

    [TclJsonString('customer_firstname')]
    property CustomerFirstname: string read FCustomerFirstname write FCustomerFirstname;

    [TclJsonString('customer_surname')]
    property CustomerSurname: string read FCustomerSurname write FCustomerSurname;

    [TclJsonString('customer_address')]
    property CustomerAddress: string read FCustomerAddress write FCustomerAddress;

    [TclJsonString('customer_postcode')]
    property CustomerPostcode: string read FCustomerPostcode write FCustomerPostcode;

    [TclJsonString('customer_telephone')]
    property CustomerTelephone: string read FCustomerTelephone write FCustomerTelephone;

    [TclJsonString('faults_client_description')]
    property FaultsClientDescription: string read FFaultsClientDescription write FFaultsClientDescription;

    [TclJsonString('clients_client')]
    property ClientsClient: string read FClientsClient write FClientsClient;

    [TclJsonString('furniture_manufacturer')]
    property FurnitureManufacturer: string read FFurnitureManufacturer write FFurnitureManufacturer;

    [TclJsonString('furniture_model')]
    property FurnitureModel: string read FFurnitureModel write FFurnitureModel;

    [TclJsonString('furniture_batch')]
    property FurnitureBatch: string read FFurnitureBatch write FFurnitureBatch;

    [TclJsonString('furniture_colour')]
    property FurnitureColour: string read FFurnitureColour write FFurnitureColour;

    [TclJsonString('furniture_delivery_date')]
    property FurnitureDeliveryDate: string read FFurnitureDeliveryDate write FFurnitureDeliveryDate;

    [TclJsonString('general_instructions')]
    property GeneralInstructions: string read FGeneralInstructions write FGeneralInstructions;
  end;

  TCreateJobServiceResponse = class
  private
    FIsmReference: string;
  public
    [TclJsonString('ism_reference')]
    property IsmReference: string read FIsmReference write FIsmReference;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnSendJSonStringClick(Sender: TObject);
var
  request: string;
  response: TStringStream;
begin
  request :=
'{' +
' "client_ref": "ABC123456",' +
' "customer_title": "Mr",' +
' "customer_firstname": "John",' +
' "customer_surname": "Smith",' +
' "customer_address": "123 The Lane, Sunnyvale",' +
' "customer_postcode": "ZZ1 1AA",' +
' "customer_telephone": "07711911911",' +
' "faults_client_description": "Issue with PROBLEM MIDDLE STITCHING IS MISSING (DIMPLE)",' +
' "clients_client": "Tony''s furniture shop",' +
' "furniture_manufacturer": "Manufacturer Name",' +
' "furniture_model": "Model Name",' +
' "furniture_batch": "12334",' +
' "furniture_colour": "Red",' +
' "furniture_delivery_date": "2019-07-08"' +
'}';

  response := TStringStream.Create();
  try
    clHttpRequest1.BuildJSONRequest(request);
    clHttp1.SendRequest('GET', 'https://dev2.system.ism.furniture/apiv2/jobs/add', clHttpRequest1, response);
  finally
    response.Free();
  end;
end;

procedure TForm1.btnSendSerializedObjectClick(Sender: TObject);
var
  request: TCreateJobServiceRequest;
  requestBody: string;
  response: TCreateJobServiceResponse;
  responseBody: TStringStream;
  serializer: TclJsonSerializer;
begin
  request := nil;
  response := nil;
  responseBody := nil;
  serializer := nil;
  try
    request := TCreateJobServiceRequest.Create();

    request.ClientRef := 'ABC123456';
    request.CustomerTitle := 'Mr';
    request.CustomerFirstname := 'John';
    request.CustomerSurname := 'Smith';
    request.CustomerAddress := '123 The Lane,'#13#10' Sunnyvale';
    request.CustomerPostcode := 'ZZ1 1AA';
    request.CustomerTelephone := '07711911911';
    request.FaultsClientDescription := 'Issue with PROBLEM MIDDLE STITCHING IS MISSING (DIMPLE)';
    request.ClientsClient := 'Tony''s furniture shop';
    request.FurnitureManufacturer := 'Manufacturer Name';
    request.FurnitureModel := 'Model Name';
    request.FurnitureBatch := '12334';
    request.FurnitureColour := 'Red';
    request.FurnitureDeliveryDate := '2019-07-08';
    request.GeneralInstructions := 'Ring customer ASAP';

    serializer := TclJsonSerializer.Create();

    requestBody := serializer.ObjectToJson(request);

    clHttpRequest1.BuildJSONRequest(requestBody);

    responseBody := TStringStream.Create();

    clHttp1.SendRequest('GET', 'https://dev2.system.ism.furniture/apiv2/jobs/add', clHttpRequest1, responseBody);

    response := serializer.JsonToObject(TCreateJobServiceResponse, responseBody.DataString) as TCreateJobServiceResponse;
  finally
    serializer.Free();
    responseBody.Free();
    response.Free();
    request.Free();
  end;
end;

procedure TForm1.btnSendJSonObjectClick(Sender: TObject);
var
  request: TclJSONObject;
  response: TclJSONObject;
  responseBody: TStringStream;
begin
  request := nil;
  response := nil;
  responseBody := nil;
  try
    request := TclJSONObject.Create();

    request.AddString('client_ref', 'ABC123456');
    request.AddString('customer_title', 'Mr');
    request.AddString('customer_firstname', 'John');
    request.AddString('customer_surname', 'Smith');
    request.AddString('customer_address', '123 The Lane,'#13#10' Sunnyvale');
    request.AddString('customer_postcode', 'ZZ1 1AA');
    request.AddString('customer_telephone', '07711911911');
    request.AddString('faults_client_description', 'Issue with PROBLEM MIDDLE STITCHING IS MISSING (DIMPLE)');
    request.AddString('clients_client', 'Tony''s furniture shop');
    request.AddString('furniture_manufacturer', 'Manufacturer Name');
    request.AddString('furniture_model', 'Model Name');
    request.AddString('furniture_batch', '12334');
    request.AddString('furniture_colour', 'Red');
    request.AddString('furniture_delivery_date', '2019-07-08');
    request.AddString('general_instructions', 'Ring customer ASAP');

    clHttpRequest1.BuildJSONRequest(request);

    responseBody := TStringStream.Create();

    clHttp1.SendRequest('GET', 'https://dev2.system.ism.furniture/apiv2/jobs/add', clHttpRequest1, responseBody);

    response := TclJSONObject.ParseObject(responseBody.DataString);
  finally
    responseBody.Free();
    response.Free();
    request.Free();
  end;
end;

end.
