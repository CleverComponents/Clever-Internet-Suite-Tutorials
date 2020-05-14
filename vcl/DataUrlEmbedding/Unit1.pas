unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, clHtmlParser, Vcl.StdCtrls, clEncoder, clUtils;

type
  TForm1 = class(TForm)
    clHtmlParser1: TclHtmlParser;
    clEncoder1: TclEncoder;
    memHtml: TMemo;
    btnEncode: TButton;
    btnDecode: TButton;
    edtImagesFolder: TEdit;
    Label1: TLabel;
    procedure btnDecodeClick(Sender: TObject);
    procedure btnEncodeClick(Sender: TObject);
  private
    function DecodeDataUrlImage(const AImagesFolder, AData: string): string;
    function EncodeDataUrlImage(const AImagesFolder, AFileName: string): string;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}


function TForm1.EncodeDataUrlImage(const AImagesFolder, AFileName: string): string;
var
  s, fileName: string;
  src: TStream;
begin
  fileName := AFileName;

  fileName := Trim(AFileName);
  if(Pos('data:', LowerCase(fileName)) = 1) then
  begin
    Result := fileName;
    Exit;
  end;

  if (ExtractFilePath(fileName) = '') then
  begin
    fileName := AddTrailingBackSlash(AImagesFolder) + fileName;
  end;

  src := TFileStream.Create(fileName, fmOpenRead);
  try
    Result := clEncoder1.Encode(src);
  finally
    src.Free();
  end;

  s := ExtractFileExt(fileName);
  if (s <> '') and (s[1] = '.') then
  begin
    s := Copy(s, 2, MaxInt);
  end;

  Result := 'data:image/' + s + ';base64,' + Result;
end;

function TForm1.DecodeDataUrlImage(const AImagesFolder, AData: string): string;
var
  ind: Integer;
  dataType, fileName: string;
  stream: TStream;
begin
  Result := AData;

  ind := Pos('data:', LowerCase(Result));
  if (ind > 0) then
  begin
    Result := Copy(Result, ind + Length('data:'), MaxInt);

    ind := Pos(';base64,', LowerCase(Result));
    if (ind > 0) then
    begin
      dataType := LowerCase(Copy(Result, 1, ind));
      Result := Copy(Result, ind + Length(';base64,'));

      if (Pos('gif', dataType) > 0) then
      begin
        fileName := '.gif';
      end else
      if (Pos('jpeg', dataType) > 0) then
      begin
        fileName := '.jpeg';
      end else
      if (Pos('png', dataType) > 0) then
      begin
        fileName := '.png';
      end else
      begin
        fileName := '.dat';
      end;

      fileName := 'testImage' + fileName;

      fileName := GetUniqueFileName(AddTrailingBackSlash(AImagesFolder) + fileName); //is declared in clUtils

      stream := TFileStream.Create(fileName, fmCreate);
      try
        clEncoder1.Decode(Result, stream);
      finally
        stream.Free();
      end;

      Result := fileName;
    end;
  end;
end;

procedure TForm1.btnDecodeClick(Sender: TObject);
var
  i: Integer;
  html, dataSrc, newSrc: string;
begin
  html := memHtml.Text;
  clHtmlParser1.Parse(html);

  for i := 0 to clHtmlParser1.Images.Count - 1 do
  begin
    dataSrc := clHtmlParser1.Images[i].Src;
    newSrc := DecodeDataUrlImage(edtImagesFolder.Text, dataSrc);

    if (dataSrc <> newSrc) then
    begin
      html := StringReplace(html, dataSrc, newSrc, [rfReplaceAll]);
    end;
  end;

  memHtml.Text := html;
end;

procedure TForm1.btnEncodeClick(Sender: TObject);
var
  i: Integer;
  html, dataSrc, newSrc: string;
begin
  html := memHtml.Text;
  clHtmlParser1.Parse(html);

  for i := 0 to clHtmlParser1.Images.Count - 1 do
  begin
    dataSrc := clHtmlParser1.Images[i].Src;
    newSrc := EncodeDataUrlImage(edtImagesFolder.Text, dataSrc);

    if (dataSrc <> newSrc) then
    begin
      html := StringReplace(html, dataSrc, newSrc, [rfReplaceAll]);
    end;
  end;

  memHtml.Text := html;
end;

end.
