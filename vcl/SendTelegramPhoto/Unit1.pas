unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, clTcpClient, clTcpClientTls, clHttp,
  Vcl.StdCtrls, clHttpRequest, Vcl.ExtCtrls, Vcl.Imaging.jpeg,
  Vcl.Imaging.pngimage;

type
  TForm1 = class(TForm)
    clHttpRequest: TclHttpRequest;
    btnSend: TButton;
    clHttpTG: TclHttp;
    Image1: TImage;
    memResponse: TMemo;
    edtChannelName: TEdit;
    procedure btnSendClick(Sender: TObject);
    procedure clHttpRequestLoadData(Sender: TObject; AItem: TclHttpRequestItem;
      var AData: TStream);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnSendClick(Sender: TObject);
const
  urlTGSendPhoto = 'https://api.telegram.org/bot%s/sendPhoto';
  BOT_API_KEY = 'BOT_API_KEY';
var
  s: string;
begin
  clHttpRequest.Clear();
  clHttpRequest.AddFormField('chat_id', edtChannelName.Text);
  clHttpRequest.AddSubmitFile('photo', 'chart.png');

  s := clHttpTG.Post(Format(urlTGSendPhoto, [BOT_API_KEY]), clHttpRequest);
  memResponse.Lines.Text := s;
end;

procedure TForm1.clHttpRequestLoadData(Sender: TObject;
  AItem: TclHttpRequestItem; var AData: TStream);
begin
  if (AItem is TclSubmitFileRequestItem) and (TclSubmitFileRequestItem(AItem).FileName = 'chart.png') then
  begin
    AData := TMemoryStream.Create();
    Image1.Picture.SaveToStream(AData);
    AData.Position := 0;
  end;
end;

end.
