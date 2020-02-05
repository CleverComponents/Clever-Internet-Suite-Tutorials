unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Soap.Rio,
  clHttpRio, RestTutorial;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edtCelsius: TEdit;
    edtFahrenheit: TEdit;
    btnC2F: TButton;
    btnF2C: TButton;
    clHttpRio1: TclHttpRio;
    procedure btnC2FClick(Sender: TObject);
    procedure btnF2CClick(Sender: TObject);
  private
    function GetService: IRestTutorial;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnC2FClick(Sender: TObject);
var
  service: IRestTutorial;
  celsius, fahrenheit: Temperature2;
begin
  if (edtCelsius.Text = '') then Exit;

  service := GetService();

  celsius := nil;
  fahrenheit := nil;
  try
    celsius := Temperature2.Create();

    celsius.Value := StrToFloat(edtCelsius.Text);
    celsius.Units := 'C';

    fahrenheit := service.Celsius2Fahrenheit(celsius);

    edtFahrenheit.Text := FloatToStr(fahrenheit.Value);
  finally
    fahrenheit.Free();
    celsius.Free();
  end;
end;

procedure TForm1.btnF2CClick(Sender: TObject);
var
  service: IRestTutorial;
  celsius, fahrenheit: Temperature2;
begin
  if (edtFahrenheit.Text = '') then Exit;

  service := GetService();

  celsius := nil;
  fahrenheit := nil;
  try
    fahrenheit := Temperature2.Create();

    fahrenheit.Value := StrToFloat(edtFahrenheit.Text);
    fahrenheit.Units := 'F';

    celsius := service.Fahrenheit2Celsius(fahrenheit);

    edtCelsius.Text := FloatToStr(celsius.Value);
  finally
    fahrenheit.Free();
    celsius.Free();
  end;
end;

function TForm1.GetService: IRestTutorial;
begin
  clHttpRio1.URL := 'https://clevercomponents.com/tutorials/wcfservice/RestTutorial.svc';
  clHttpRio1.Service := 'RestTutorial';
  clHttpRio1.Port := 'BasicHttpBinding_IRestTutorial';

  Result := clHttpRio1 as IRestTutorial;
end;

end.
