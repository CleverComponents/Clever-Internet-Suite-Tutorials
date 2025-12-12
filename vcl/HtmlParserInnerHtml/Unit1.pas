unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, clHtmlParser, clUtils, ExtCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    clHtmlParser1: TclHtmlParser;
    Panel1: TPanel;
    Memo2: TMemo;
    Memo1: TMemo;
    Splitter1: TSplitter;
    edtTagName: TEdit;
    Label1: TLabel;
    edtAttributeName: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    edtAttributeValue: TEdit;
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
  i, FoundCount: Integer;
  tag: TclHtmlTag;
  TagName, AttrName, AttrValue: string;
begin
  Memo2.Lines.Clear();

  // Get filter criteria from input fields
  TagName := Trim(edtTagName.Text);
  AttrName := Trim(edtAttributeName.Text);
  AttrValue := Trim(edtAttributeValue.Text);

  // Configure parser
  clHtmlParser1.IncludeClosingTags := True;
  clHtmlParser1.ParseMethod := pmAll;
  clHtmlParser1.Parse(Memo1.Lines);

  FoundCount := 0;

  // Parse and filter tags
  for i := 0 to clHtmlParser1.Tags.Count - 1 do
  begin
    tag := clHtmlParser1.Tags[i];

    // Apply filters
    if (TagName = '') or (CompareText(tag.Name, TagName) = 0) then
    begin
      if (AttrName = '') or (CompareText(tag.AttributeValue(AttrName), AttrValue) = 0) then
      begin
        Memo2.Lines.Text := Memo2.Lines.Text + GetInnerHtml(tag.Owner, tag) + #13#10;
        Inc(FoundCount);
      end;
    end;
  end;

  // Show statistics
  if Memo2.Lines.Count > 0 then
  begin
    Memo2.Lines.Insert(0, Format('Found %d matching tag(s) with content:', [FoundCount]));
    Memo2.Lines.Insert(1, '=======================');
  end else
  begin
    Memo2.Lines.Text := 'No elements found matching the specified criteria.';
  end;
end;

end.
