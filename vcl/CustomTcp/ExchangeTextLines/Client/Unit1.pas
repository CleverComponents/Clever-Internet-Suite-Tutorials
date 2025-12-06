unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CustomClient;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
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
      client.GetLines(lines);
      Memo1.Lines.AddStrings(lines);

      lines.Clear();
      lines.Add('<root>');
      lines.Add('<somedata>data</somedata>');
      lines.Add('</root>');
      client.SendLines(lines);
    finally
      lines.Free();
    end;

    client.Close();

    Memo1.Lines.Add('Done');
    Memo1.Lines.Add('');
  finally
    client.Free();
  end;
end;

end.
