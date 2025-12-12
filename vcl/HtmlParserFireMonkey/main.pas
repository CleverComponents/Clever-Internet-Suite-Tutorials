unit main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Rtti, System.Classes,
  System.Variants, FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.Layouts,
  FMX.Memo, FMX.Edit, clHtmlParser, FMX.Memo.Types, FMX.ScrollBox, FMX.StdCtrls,
  FMX.Controls.Presentation;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Label1: TLabel;
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

{$R *.fmx}

procedure TForm1.Button1Click(Sender: TObject);
var
  parser: TclHtmlParser;
  src: TStrings;
begin
  parser := nil;
  src := nil;
  try
    parser := TclHtmlParser.Create(nil);
    src := TStringList.Create();

    src.LoadFromFile(Edit1.Text);

    parser.Parse(src);

    Memo1.Lines.Clear();
    Memo1.Lines.Add(parser.Title);
    Memo1.Lines.Add(parser.Description);

    Memo1.Lines.Add('Tags: ' + IntToStr(parser.Tags.Count));
    Memo1.Lines.Add('Links: ' + IntToStr(parser.Links.Count));
    Memo1.Lines.Add('Images: ' + IntToStr(parser.Images.Count));
    Memo1.Lines.Add('Done!');
  finally
    src.Free();
    parser.Free();
  end;
end;

end.
