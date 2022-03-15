unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.Generics.Collections, clMailMessage;

type
  TMyAttachment = class;

  TForm1 = class(TForm)
    btnLoad: TButton;
    btnSave: TButton;
    memSource: TMemo;
    clMailMessage1: TclMailMessage;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
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
    procedure SaveAttachment(AStream: TStream);
    procedure LoadAttachment(AStream: TStream);

    property FileName: string read FFileName;
    property Attachment: TStream read FAttachment;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnLoadClick(Sender: TObject);
begin
  if not OpenDialog1.Execute() then Exit;

  memSource.Lines.LoadFromFile(OpenDialog1.FileName);

  //initialize the attahcments collection
  FAttachments.Clear();

  //This causes the message parsing. Alternatively, you can use the LoadMessage method.
  clMailMessage1.MessageSource := memSource.Lines;
end;

procedure TForm1.btnSaveClick(Sender: TObject);
begin
  if not SaveDialog1.Execute() then Exit;

{ //This code part allows you to generate a simple message source with both text and html bodies,
  //and two attachments. You need to create both file1.ext and file2.ext near the .dpr file.
  //I used this code to test the example.
  clMailMessage1.BuildMessage('The message text', '<html><body>The message HTML</body></html>', [],
    ['..\..\file1.ext', '..\..\file2.ext']);
  clMailMessage1.Subject := 'Subject line';
  clMailMessage1.From.Email := 'sender@domain.com';
  clMailMessage1.ToList.EmailAddresses := 'recipient@another.com';
  memSource.Lines := clMailMessage1.MessageSource;}

  //You can use this property to access the saved attachments in the same order as they were parsed.
  FAttachmentIndex := 0;

  //This makes the component to re-compose the message source using the TclMailMessage settings.
  //You can use the SaveMessage method to save the message source to a stream, or to a file.
  memSource.Lines := clMailMessage1.MessageSource;

  memSource.Lines.SaveToFile(SaveDialog1.FileName);
end;

procedure TForm1.clMailMessage1AttachmentSaved(Sender: TObject;
  ABody: TclAttachmentBody; const AFileName: string; AData: TStream);
begin
  //Save the attachment content before the TclMailMessage component closes the AData stream.
  //The OnSaveAttachment event always followed by OnAttachmentSaved.
  //So the FAttachments.Last property returns the recently added item within the OnSaveAttachment event handler.
  FAttachments.Last.SaveAttachment(AData);
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

procedure TMyAttachment.SaveAttachment(AStream: TStream);
begin
  //saving the stream content to FAttachment
  FAttachment.Size := 0;
  TMemoryStream(FAttachment).LoadFromStream(AStream);
end;

end.
