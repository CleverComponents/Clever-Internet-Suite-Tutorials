unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.Generics.Collections, clMailMessage,
  clSMimeMessage, clCertificate;

type
  TMyAttachment = class;

  TForm1 = class(TForm)
    btnLoad: TButton;
    btnSave: TButton;
    memSource: TMemo;
    clMailMessage1: TclMailMessage;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    clSMimeMessage1: TclSMimeMessage;
    btnCreate: TButton;
    rbUseMailMessage: TRadioButton;
    rbUseSMime: TRadioButton;
    procedure btnCreateClick(Sender: TObject);
    procedure btnLoadClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure clMailMessage1SaveAttachment(Sender: TObject;
      ABody: TclAttachmentBody; var AFileName: string; var AData: TStream;
      var Handled: Boolean);
    procedure clMailMessage1AttachmentSaved(Sender: TObject;
      ABody: TclAttachmentBody; const AFileName: string; AData: TStream);
    procedure clMailMessage1LoadAttachment(Sender: TObject;
      ABody: TclAttachmentBody; var AFileName: string; var AData: TStream;
      var Handled: Boolean);
  private
    //if you use a previous version of Delphi, replace generics with their classical analogues
    FAttachments: TObjectList<TMyAttachment>;
    FAttachmentIndex: Integer;

    function GetMailMessage: TclMailMessage;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

  TMyAttachment = class
  private
    FFileName: string;
    FAttachment: TStream;
  public
    constructor Create(const AFileName: string);
    destructor Destroy; override;
    procedure SaveAttachment(const AText: string); overload;
    procedure SaveAttachment(AStream: TStream); overload;
    procedure LoadAttachment(AStream: TStream);

    property FileName: string read FFileName;
    property Attachment: TStream read FAttachment;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnCreateClick(Sender: TObject);
var
  msg: TclMailMessage;
  att: TMyAttachment;
  cert: TclCertificate;
begin
  if not SaveDialog1.Execute() then Exit;

  //generate a simple message source with both text and html bodies, and two attachments

  msg := GetMailMessage();

  //initialize the attahcments collection
  FAttachments.Clear();

  //create two sample attachments
  att := TMyAttachment.Create('file1.ext');
  FAttachments.Add(att);
  att.SaveAttachment('qwe asd zxc');

  att := TMyAttachment.Create('file2.ext');
  FAttachments.Add(att);
  att.SaveAttachment('ddd bbb');

  //build a new message

  //Use this property to access created attachments in the same order as they were created.
  FAttachmentIndex := 0;

  msg.BuildMessage('The message text', '<html><body>The message HTML</body></html>', [],
    ['file1.ext', 'file2.ext']);
  msg.Subject := 'Subject line';
  msg.From.Email := 'sender@domain.com';
  msg.ToList.EmailAddresses := 'recipient@another.com';

  //sign, if S/MIME is selected
  if rbUseSMime.Checked then
  begin
    //Generate a self-signed test certificate to sign the message.
    //Note, the certificate email must be the same as the sender's email.
    clSMimeMessage1.Certificates.Close();
    clSMimeMessage1.Certificates.Open('MY');

    cert := clSMimeMessage1.Certificates.CreateSelfSigned(
      'CN=CleverTester,O=CleverComponents,E=' + msg.From.Email, 0);

    //Generated certificates are not added automatically to the collection.
    //You must do it yourself.
    clSMimeMessage1.Certificates.Items.Add(cert);

    //Every time you manipulate with the message content, the component must request the the attachments.
    FAttachmentIndex := 0;

    clSMimeMessage1.Sign();
  end;

  //Use this property to access created attachments in the same order as they were created.
  FAttachmentIndex := 0;

  memSource.Lines := msg.MessageSource;
  memSource.Lines.SaveToFile(SaveDialog1.FileName);
end;

procedure TForm1.btnLoadClick(Sender: TObject);
begin
  if not OpenDialog1.Execute() then Exit;

  memSource.Lines.LoadFromFile(OpenDialog1.FileName);

  //initialize the attahcments collection
  FAttachments.Clear();

  //This causes the message parsing. Alternatively, you can use the LoadMessage method.
  GetMailMessage().MessageSource := memSource.Lines;

  if rbUseSMime.Checked then
  begin
    clSMimeMessage1.Verify();
  end;
end;

procedure TForm1.btnSaveClick(Sender: TObject);
begin
  if not SaveDialog1.Execute() then Exit;

  //You can use this property to access the saved attachments in the same order as they were parsed.
  FAttachmentIndex := 0;

  //This makes the component to re-compose the message source using the TclMailMessage settings.
  //You can use the SaveMessage method to save the message source to a stream, or to a file.
  memSource.Lines := GetMailMessage().MessageSource;

  memSource.Lines.SaveToFile(SaveDialog1.FileName);
end;

procedure TForm1.clMailMessage1SaveAttachment(Sender: TObject;
  ABody: TclAttachmentBody; var AFileName: string; var AData: TStream;
  var Handled: Boolean);
begin
  //create a TMyAttachment instance
  FAttachments.Add(TMyAttachment.Create(AFileName));

  //provide the TclMailMessage component with a separated instance of the stream
  //because the component always closes all streams after the process completed
  AData := TMemoryStream.Create();
  Handled := True;
end;

procedure TForm1.clMailMessage1AttachmentSaved(Sender: TObject;
  ABody: TclAttachmentBody; const AFileName: string; AData: TStream);
begin
  //Save the attachment content before the TclMailMessage component closes the AData stream.
  //The OnSaveAttachment event always followed by OnAttachmentSaved.
  //So the FAttachments.Last property returns the recently added item within the OnSaveAttachment event handler.

  //skip the S/MIME signature body
  if not (ABody is TclEnvelopedBody) then
  begin
    FAttachments.Last.SaveAttachment(AData);
  end;
end;

procedure TForm1.clMailMessage1LoadAttachment(Sender: TObject;
  ABody: TclAttachmentBody; var AFileName: string; var AData: TStream;
  var Handled: Boolean);
begin
  //You can use the same approach as in the OnSaveAttachment event handler to
  //copy the attachment content to a new stream instance
  //Alternatively, you can use the saved attachment stream, assuming that after composing the message source
  //the collected attachments are not required anymore.
  //All collected attachment streams become closed after reading the TclMailMessage.MessageSource property.
  //However, in such a case, you should set FAttachments[FAttachmentIndex].Attachment := nil;
  //in order to prevent the stream instance to be freed twice.

  AData := TMemoryStream.Create();
  FAttachments[FAttachmentIndex].LoadAttachment(AData);
  AData.Position := 0;

  //Selects the next attachment within the collection.
  Inc(FAttachmentIndex);
  Handled := True;
end;

constructor TForm1.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FAttachments := TObjectList<TMyAttachment>.Create(True);
end;

destructor TForm1.Destroy;
begin
  FAttachments.Free();
  inherited Destroy();
end;

function TForm1.GetMailMessage: TclMailMessage;
begin
  if rbUseMailMessage.Checked then
  begin
    Result := clMailMessage1;
  end else
  begin
    Result := clSMimeMessage1;
  end;
end;

{ TMyAttachment }

constructor TMyAttachment.Create(const AFileName: string);
begin
  inherited Create();

  FFileName := AFileName;
  //The TMyAttachment object keeps own copy of stream
  //this functionality allows to use a database, or another storage to save attachments
  FAttachment := TMemoryStream.Create();
end;

destructor TMyAttachment.Destroy;
begin
  FAttachment.Free();
  inherited Destroy();
end;

procedure TMyAttachment.LoadAttachment(AStream: TStream);
begin
  //loading the stream content from FAttachment
  FAttachment.Position := 0;
  TMemoryStream(FAttachment).SaveToStream(AStream);
end;

procedure TMyAttachment.SaveAttachment(const AText: string);
var
  stream: TStream;
begin
  stream := TStringStream.Create(AText, TEncoding.Default);
  try
    SaveAttachment(stream);
  finally
    stream.Free();
  end;
end;

procedure TMyAttachment.SaveAttachment(AStream: TStream);
begin
  //saving the stream content to FAttachment
  FAttachment.Size := 0;
  TMemoryStream(FAttachment).LoadFromStream(AStream);
end;

end.
