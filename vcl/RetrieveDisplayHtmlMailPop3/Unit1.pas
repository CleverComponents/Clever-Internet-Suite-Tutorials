unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, clMailMessage,
  clTcpClient, clTcpClientTls, clTcpCommandClient, clMC, clPop3, Vcl.OleCtrls,
  SHDocVw;

type
  TForm1 = class(TForm)
    clPop31: TclPop3;
    clMailMessage1: TclMailMessage;
    btnRetrieve: TButton;
    WebBrowser1: TWebBrowser;
    Label1: TLabel;
    edtServer: TEdit;
    Label2: TLabel;
    edtUserName: TEdit;
    Label3: TLabel;
    edtPassword: TEdit;
    Label4: TLabel;
    edtFolder: TEdit;
    Label5: TLabel;
    edtMsgNo: TEdit;
    procedure btnRetrieveClick(Sender: TObject);
    procedure clMailMessage1SaveAttachment(Sender: TObject;
      ABody: TclAttachmentBody; var AFileName: string; var AData: TStream;
      var Handled: Boolean);
  private
    function GetUniqueFileName(const AFileName: string): string;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnRetrieveClick(Sender: TObject);
var
  i: Integer;
  stringToDisplay: string;
  image: TclImageBody;
  msg: TStrings;
begin
  clPop31.Server := edtServer.Text;
  clPop31.UserName := edtUserName.Text;
  clPop31.Password := edtPassword.Text;

  clPop31.Open();

  clPop31.Retrieve(StrToInt(edtMsgNo.Text), clMailMessage1);

  stringToDisplay := clMailMessage1.MessageText.Text;

  for i := 0 to clMailMessage1.Images.Count - 1 do
  begin
    image := clMailMessage1.Images[i];

    stringToDisplay := StringReplace(stringToDisplay, 'cid:' + image.ContentID,
      edtFolder.Text + image.FileName, [rfIgnoreCase, rfReplaceAll]);
  end;

  msg := TStringList.Create();
  try
    msg.Text := stringToDisplay;
    msg.SaveToFile(edtFolder.Text + 'temp.htm');
  finally
    msg.Free();
  end;

  WebBrowser1.Navigate(edtFolder.Text + 'temp.htm');

  clPop31.Close();
end;

function TForm1.GetUniqueFileName(const AFileName: string): string;
var
  dir, name, ext: string;
  i: Integer;
begin
  dir := edtFolder.Text;

  ext := ExtractFileExt(AFileName);
  name := Copy(AFileName, 1, Length(AFileName) - Length(ext));
  name := name + '(';
  ext  := ')' + ext;

  i := 1;
  while FileExists(dir + name + IntToStr(i) + ext) do
  begin
    Inc(i);
  end;

  Result := name + IntToStr(i) + ext;
end;

procedure TForm1.clMailMessage1SaveAttachment(Sender: TObject;
  ABody: TclAttachmentBody; var AFileName: string; var AData: TStream;
  var Handled: Boolean);
begin
  if (AFileName = '') then
  begin
    AFileName := GetUniqueFileName('.dat');
  end;

  AData := TFileStream.Create(edtFolder.Text + AFileName, fmCreate);
  Handled := True;
end;

end.
