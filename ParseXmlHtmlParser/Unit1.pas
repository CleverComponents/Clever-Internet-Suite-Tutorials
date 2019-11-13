unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, clHtmlParser, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    Memo2: TMemo;
    clHtmlParser1: TclHtmlParser;
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
  i, j: Integer;
begin
  clHtmlParser1.Parse(Memo1.Lines);

  Memo2.Lines.Clear();

  for i := 0 to clHtmlParser1.Tags.Count - 1 do
  begin
    if (not clHtmlParser1.Tags[i].IsText) and (clHtmlParser1.Tags[i].Name <> '!--') then
    begin
      Memo2.Lines.Add(clHtmlParser1.Tags[i].Name);

      for j := 0 to clHtmlParser1.Tags[i].AttributeCount - 1 do
      begin
        Memo2.Lines.Add(#9 + clHtmlParser1.Tags[i].Attributes[j].Name + ':' + clHtmlParser1.Tags[i].Attributes[j].Value);
      end;

      if (clHtmlParser1.Tags[i].NextTag <> nil)
        and (clHtmlParser1.Tags[i].NextTag.IsText)
        and (clHtmlParser1.Tags[i].NextTag.Owner <> clHtmlParser1.Tags[i].Owner)
        and (Trim(clHtmlParser1.Tags[i].Text) <> '') then
      begin
        Memo2.Lines.Add(#9'Data:' + clHtmlParser1.Tags[i].Text);
      end;
    end;
  end;

  ShowMessage('Done');
end;

end.


