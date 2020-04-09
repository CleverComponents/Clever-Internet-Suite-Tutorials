unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, clHtmlParser, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    clHtmlParser1: TclHtmlParser;
    Memo1: TMemo;
    Memo2: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    function GetCellText(ATableCell: TclHtmlTableCell): string;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function TForm1.GetCellText(ATableCell: TclHtmlTableCell): string;
var
  i: Integer;
begin
  Result := '';
  for i := 0 to ATableCell.Tags.Count - 1 do
  begin
    if ATableCell.Tags[i].IsText then
    begin
      Result := Result + ATableCell.Tags[i].Text;
    end;
  end;
  Result := Trim(Result);
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  i, j, k: Integer;
  cell: TclHtmlTableCell;
  table: TclHtmlTable;
  row: TclHtmlTableRow;
begin
  clHtmlParser1.ParseMethod := pmAll;
  clHtmlParser1.Parse(Memo1.Lines);

  Memo2.Lines.Clear();

  for i := 0 to clHtmlParser1.Tables.Count - 1 do
  begin
    Memo2.Lines.Add('table ' + IntToStr(i));

    table := clHtmlParser1.Tables[i];
    for j := 0 to table.Rows.Count - 1 do
    begin
      Memo2.Lines.Add('row ' + IntToStr(j));

      row := table.Rows[j];
      for k := 0 to row.Cells.Count - 1 do
      begin
        cell := row.Cells[k];
        Memo2.Lines.Add(GetCellText(cell));
      end;
    end;
  end;
end;

end.
