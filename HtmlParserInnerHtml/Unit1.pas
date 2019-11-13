unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, clHtmlParser;

type
  TForm1 = class(TForm)
    Button1: TButton;
    clHtmlParser1: TclHtmlParser;
    Memo1: TMemo;
    Memo2: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    function GetInnerHtml(AOwner, ATag: TclHtmlTag): string;
    function GetTagSource(ATag: TclHtmlTag): string;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function TForm1.GetTagSource(ATag: TclHtmlTag): string;
begin
  if ATag.IsClosingTag then
  begin
    Result := '</' + ATag.Name + '>';
  end else
  if ATag.IsText then
  begin
    Result := ATag.TagSource;
  end else
  begin
    Result := '<' + ATag.TagSource + '>';
  end;
end;

function TForm1.GetInnerHtml(AOwner, ATag: TclHtmlTag): string;
begin
  if (ATag.NextTag <> nil) and (ATag.NextTag.Owner <> AOwner) then
  begin
    if (AOwner <> ATag.Owner) then
    begin
      Result := GetTagSource(ATag);
    end else
    begin
      Result := '';
    end;

    Result := Result + GetInnerHtml(AOwner, ATag.NextTag);
  end else
  begin
    Result := GetTagSource(ATag);
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  i: Integer;
  tag: TclHtmlTag;
begin
  Memo2.Lines.Clear();

  clHtmlParser1.IncludeClosingTags := True;
  clHtmlParser1.ParseMethod := pmAll;
  clHtmlParser1.Parse(Memo1.Lines);

  for i := 0 to clHtmlParser1.Tags.Count - 1 do
  begin
    tag := clHtmlParser1.Tags[i];
    if (tag.Name = 'div') and (tag.AttributeValue('class') = 'tvRow tvFirst hasLabel tvFirst') then
    begin
      Memo2.Lines.Add(GetInnerHtml(tag.Owner, tag));
    end;
  end;
end;

end.
