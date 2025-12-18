unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, clMailMessage, clSMimeMessage,
  clTcpClient, clTcpClientTls, clTcpCommandClient, clMC, clSmtp, clCryptApi, StdCtrls,
  clCertificateStore, clCertificate, DB;

type
  TForm1 = class(TForm)
    clMailMessage1: TclMailMessage;
    btnSend: TButton;
    clSmtp1: TclSmtp;
    procedure clMailMessage1LoadAttachment(Sender: TObject;
      ABody: TclAttachmentBody; var AFileName: string; var AData: TStream;
      var Handled: Boolean);
    procedure btnSendClick(Sender: TObject);
  private
    BlobField1: TBlobField;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnSendClick(Sender: TObject);
begin
  //composing a new message
  clMailMessage1.BuildMessage('The message text', ['filename.ext']);
  clMailMessage1.Subject := 'Subject line follows here';
  clMailMessage1.From.FullAddress := 'sender@domain.com';
  clMailMessage1.ToList.Clear();
  clMailMessage1.ToList.Add('recipient@another.com');

  //sending the message
end;

procedure TForm1.clMailMessage1LoadAttachment(Sender: TObject;
  ABody: TclAttachmentBody; var AFileName: string; var AData: TStream;
  var Handled: Boolean);
begin
  if (AFileName = 'filename.ext') then
  begin
    //loading the attachment content from a database
    AData := TMemoryStream.Create();
    BlobField1.SaveToStream(AData);
    AData.Position := 0;
    Handled := True;
  end;
end;

end.
