unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Soap.Rio,
  clHttpRio, RestSoap, RestSoapSign, RestSoapSignEncrypt, clCertificateStore,
  clHttpRequest, clSoapMessage, clCertificate, clSoapSecurity;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edtCelsius: TEdit;
    edtFahrenheit: TEdit;
    btnC2F: TButton;
    btnF2C: TButton;
    cbSecurity: TComboBox;
    Label3: TLabel;
    Request: TclSoapMessage;
    Response: TclSoapMessage;
    clCertificateStore1: TclCertificateStore;
    procedure btnC2FClick(Sender: TObject);
    procedure btnF2CClick(Sender: TObject);
    procedure RequestGetSigningCertificate(Sender: TObject;
      AKeyInfo: TclXmlKeyInfo; var ACertificate: TclCertificate;
      AExtraCerts: TclCertificateList; var Handled: Boolean);
    procedure RequestGetEncryptionCertificate(Sender: TObject;
      AKeyInfo: TclXmlKeyInfo; var ACertificate: TclCertificate;
      AExtraCerts: TclCertificateList; var AStoreName: string;
      var AStoreLocation: TclCertificateStoreLocation; var Handled: Boolean);
    procedure ResponseGetSigningCertificateEx(Sender: TObject;
      AKeyInfo: TclXmlKeyInfo; var ACertificate: TclCertificate;
      AExtraCerts: TclCertificateList; var AStoreName: string;
      var AStoreLocation: TclCertificateStoreLocation; var Handled: Boolean);
    procedure ResponseGetEncryptionCertificate(Sender: TObject;
      AKeyInfo: TclXmlKeyInfo; var ACertificate: TclCertificate;
      AExtraCerts: TclCertificateList; var AStoreName: string;
      var AStoreLocation: TclCertificateStoreLocation; var Handled: Boolean);
  private
    function GetService: IRestSoap;
    function GetServiceSign: IRestSoapSign;
    function GetServiceSignEncrypt: IRestSoapSignEncrypt;

    procedure ConvertC2F;
    procedure ConvertF2C;

    procedure ConvertC2FSign;
    procedure ConvertF2CSign;

    procedure ConvertC2FSignEncrypt;
    procedure ConvertF2CSignEncrypt;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnC2FClick(Sender: TObject);
begin
  if (edtCelsius.Text = '') then Exit;

  case cbSecurity.ItemIndex of
    0 : ConvertC2F();
    1 : ConvertC2FSign();
    2 : ConvertC2FSignEncrypt();
  end;
end;

procedure TForm1.btnF2CClick(Sender: TObject);
begin
  if (edtFahrenheit.Text = '') then Exit;

  case cbSecurity.ItemIndex of
    0 : ConvertF2C();
    1 : ConvertF2CSign();
    2 : ConvertF2CSignEncrypt();
  end;
end;

procedure TForm1.ConvertC2F;
var
  service: IRestSoap;
  celsius, fahrenheit: RestSoap.Temperature2;
begin
  service := GetService();

  celsius := nil;
  fahrenheit := nil;
  try
    celsius := RestSoap.Temperature2.Create();

    celsius.Value := StrToFloat(edtCelsius.Text);
    celsius.Units := 'C';

    fahrenheit := service.Celsius2Fahrenheit(celsius);

    edtFahrenheit.Text := FloatToStr(fahrenheit.Value);
  finally
    fahrenheit.Free();
    celsius.Free();
    service := nil;
  end;
end;

procedure TForm1.ConvertC2FSign;
var
  service: IRestSoapSign;
  celsius, fahrenheit: RestSoapSign.Temperature2;
begin
  service := GetServiceSign();

  celsius := nil;
  fahrenheit := nil;
  try
    celsius := RestSoapSign.Temperature2.Create();

    celsius.Value := StrToFloat(edtCelsius.Text);
    celsius.Units := 'C';

    fahrenheit := service.Celsius2Fahrenheit(celsius);

    edtFahrenheit.Text := FloatToStr(fahrenheit.Value);
  finally
    fahrenheit.Free();
    celsius.Free();
    service := nil;
  end;
end;

procedure TForm1.ConvertC2FSignEncrypt;
var
  service: IRestSoapSignEncrypt;
  celsius, fahrenheit: RestSoapSignEncrypt.Temperature2;
begin
  service := GetServiceSignEncrypt();

  celsius := nil;
  fahrenheit := nil;
  try
    celsius := RestSoapSignEncrypt.Temperature2.Create();

    celsius.Value := StrToFloat(edtCelsius.Text);
    celsius.Units := 'C';

    fahrenheit := service.Celsius2Fahrenheit(celsius);

    edtFahrenheit.Text := FloatToStr(fahrenheit.Value);
  finally
    fahrenheit.Free();
    celsius.Free();
    service := nil;
  end;
end;

procedure TForm1.ConvertF2C;
var
  service: IRestSoap;
  celsius, fahrenheit: RestSoap.Temperature2;
begin
  service := GetService();

  celsius := nil;
  fahrenheit := nil;
  try
    fahrenheit := RestSoap.Temperature2.Create();

    fahrenheit.Value := StrToFloat(edtFahrenheit.Text);
    fahrenheit.Units := 'F';

    celsius := service.Celsius2Fahrenheit(fahrenheit);

    edtCelsius.Text := FloatToStr(celsius.Value);
  finally
    fahrenheit.Free();
    celsius.Free();
    service := nil;
  end;
end;

procedure TForm1.ConvertF2CSign;
var
  service: IRestSoapSign;
  celsius, fahrenheit: RestSoapSign.Temperature2;
begin
  service := GetServiceSign();

  celsius := nil;
  fahrenheit := nil;
  try
    fahrenheit := RestSoapSign.Temperature2.Create();

    fahrenheit.Value := StrToFloat(edtFahrenheit.Text);
    fahrenheit.Units := 'F';

    celsius := service.Celsius2Fahrenheit(fahrenheit);

    edtCelsius.Text := FloatToStr(celsius.Value);
  finally
    fahrenheit.Free();
    celsius.Free();
    service := nil;
  end;
end;

procedure TForm1.ConvertF2CSignEncrypt;
var
  service: IRestSoapSignEncrypt;
  celsius, fahrenheit: RestSoapSignEncrypt.Temperature2;
begin
  service := GetServiceSignEncrypt();

  celsius := nil;
  fahrenheit := nil;
  try
    fahrenheit := RestSoapSignEncrypt.Temperature2.Create();

    fahrenheit.Value := StrToFloat(edtFahrenheit.Text);
    fahrenheit.Units := 'F';

    celsius := service.Celsius2Fahrenheit(fahrenheit);

    edtCelsius.Text := FloatToStr(celsius.Value);
  finally
    fahrenheit.Free();
    celsius.Free();
    service := nil;
  end;
end;

function TForm1.GetService: IRestSoap;
var
  rio: TclHttpRio;
begin
  rio := TclHttpRio.Create(nil);

  rio.URL := 'http://localhost:51899/RestSoap.svc';
  rio.Service := 'RestSoap';
  rio.Port := 'RestSoapBinding_IRestSoap';
  rio.Sign := False;
  rio.Encrypt := False;
  rio.SoapRequest := Request;
  rio.SoapResponse := Response;

  Result := rio as IRestSoap;
end;

function TForm1.GetServiceSign: IRestSoapSign;
var
  rio: TclHttpRio;
begin
  rio := TclHttpRio.Create(nil);

  rio.URL := 'http://localhost:51899/RestSoapSign.svc';
  rio.Service := 'RestSoapSign';
  rio.Port := 'RestSoapSingBinding_IRestSoapSign';
  rio.Sign := True;
  rio.Encrypt := True;
  rio.SoapRequest := Request;
  rio.SoapResponse := Response;

  Result := rio as IRestSoapSign;
end;

function TForm1.GetServiceSignEncrypt: IRestSoapSignEncrypt;
var
  rio: TclHttpRio;
begin
  rio := TclHttpRio.Create(nil);

  rio.URL := 'http://localhost:51899/RestSoapSignEncrypt.svc';
  rio.Service := 'RestSoapSignEncrypt';
  rio.Port := 'RestSoapSignEncryptBinding_IRestSoapSignEncrypt';
  rio.Sign := True;
  rio.Encrypt := True;
  rio.SoapRequest := Request;
  rio.SoapResponse := Response;

  Result := rio as IRestSoapSignEncrypt
end;

procedure TForm1.RequestGetEncryptionCertificate(Sender: TObject;
  AKeyInfo: TclXmlKeyInfo; var ACertificate: TclCertificate;
  AExtraCerts: TclCertificateList; var AStoreName: string;
  var AStoreLocation: TclCertificateStoreLocation; var Handled: Boolean);
begin
  if (clCertificateStore1.Items.Count = 0) then
  begin
    clCertificateStore1.Open('MY');
  end;
  ACertificate := clCertificateStore1.FindByThumbprint('d47ec78db75e82832a5c7fc91895b55fad1de81e', True);
  AStoreName := 'MY';
  AStoreLocation := slCurrentUser;
  Handled := True;
end;

procedure TForm1.RequestGetSigningCertificate(Sender: TObject;
  AKeyInfo: TclXmlKeyInfo; var ACertificate: TclCertificate;
  AExtraCerts: TclCertificateList; var Handled: Boolean);
begin
  if (clCertificateStore1.Items.Count = 0) then
  begin
    clCertificateStore1.Open('MY');
  end;
  ACertificate := clCertificateStore1.FindByThumbprint('4ea0ea7560685b381f729f7a855451ced26a297d', True);
  Handled := True;
end;

procedure TForm1.ResponseGetEncryptionCertificate(Sender: TObject;
  AKeyInfo: TclXmlKeyInfo; var ACertificate: TclCertificate;
  AExtraCerts: TclCertificateList; var AStoreName: string;
  var AStoreLocation: TclCertificateStoreLocation; var Handled: Boolean);
begin
  AStoreName := 'MY';
  AStoreLocation := slCurrentUser;
  Handled := True;
end;

procedure TForm1.ResponseGetSigningCertificateEx(Sender: TObject;
  AKeyInfo: TclXmlKeyInfo; var ACertificate: TclCertificate;
  AExtraCerts: TclCertificateList; var AStoreName: string;
  var AStoreLocation: TclCertificateStoreLocation; var Handled: Boolean);
begin
  AStoreName := 'MY';
  AStoreLocation := slCurrentUser;
  Handled := True;
end;

end.
