unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CustomClient;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  client: TMyClient;
  lines: TStrings;
begin
  client := TMyClient.Create(nil);
  try
    client.Server := 'localhost';
    client.Port := 2110;
    client.TimeOut := 1000;
    client.UserName := 'testuser';
    client.Open();

    client.Login();

    lines := TStringList.Create();
    try
      lines.Clear();
      lines.Add('<root>');
      lines.Add('<somedata>data</somedata>');
      lines.Add('</root>');

      client.ExchangeLines(lines);

      Memo1.Lines.AddStrings(client.Response);
    finally
      lines.Free();
    end;

    client.Close();

    Memo1.Lines.Add('');
  finally
    client.Free();
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  client: TMyClient;
  src, dst: TStringStream;
begin
  client := nil;
  src := nil;
  dst := nil;
  try
    client := TMyClient.Create(nil);

    client.Server := 'localhost';
    client.Port := 2110;
    client.TimeOut := 1000;
    client.UserName := 'testuser';
    client.Open();

    client.Login();

    src := TStringStream.Create('some test data to be sent');
    dst := TStringStream.Create('');

    client.ExchangeData(src, dst);

    Memo1.Lines.Text := Memo1.Lines.Text + dst.DataString;

    client.Close();

    Memo1.Lines.Add('');
  finally
    dst.Free();
    src.Free();
    client.Free();
  end;
end;

end.
