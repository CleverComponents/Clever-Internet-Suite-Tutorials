unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, clTcpClient, clTcpClientTls, clHttp,
  StdCtrls, clHttpRequest, ExtCtrls, Vcl.Imaging.jpeg,
  clJson, Vcl.Imaging.pngimage;

type
  TForm1 = class(TForm)
    clHttpRequest: TclHttpRequest;
    btnSend: TButton;
    clHttpTG: TclHttp;
    Image1: TImage;
    memResponse: TMemo;
    edtChannelName: TEdit;
    btnLoadImage: TButton;
    OpenDialog1: TOpenDialog;
    procedure btnSendClick(Sender: TObject);
    procedure clHttpRequestLoadData(Sender: TObject; AItem: TclHttpRequestItem;
      var AData: TStream);
    procedure FormCreate(Sender: TObject);
    procedure btnLoadImageClick(Sender: TObject);
  private
    { Private declarations }
    procedure ParseTelegramResponse(const AResponse: string);
    function GetBotToken: string;
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
var
  s: string;
  botToken: string;
begin
  // Clear previous response
  memResponse.Lines.Clear;

  // Get bot token
  botToken := GetBotToken();

  // Validate bot token format
  // Telegram bot tokens have format: 1234567890:ABCdefGHIjklMNOpqrSTUvwxYZ
  if (botToken = '') then
  begin
    raise Exception.Create('Please set your bot token in the GetBotToken function.');
  end;

  if (Pos(':', botToken) = 0) then
  begin
    raise Exception.Create('Invalid bot token format. Token should be in format: 1234567890:ABCdefGHIjklMNOpqrSTUvwxYZ');
  end;

  // Validate channel name
  if Trim(edtChannelName.Text) = '' then
  begin
    raise Exception.Create('Please enter a channel name (e.g., @channel_name)');
  end;

  // Check if image is loaded
  if Image1.Picture.Graphic = nil then
  begin
    raise Exception.Create('Please load an image first');
  end;

  // Prepare HTTP request
  clHttpRequest.Clear();

  // Add chat_id parameter (can be @channel_name or numeric chat_id)
  clHttpRequest.AddFormField('chat_id', edtChannelName.Text);

  // Add caption (optional) - uncomment to add a caption
  // clHttpRequest.AddFormField('caption', 'Photo sent from Delphi');

  // Add photo file - will be provided via OnLoadData event
  // Telegram API expects the file parameter to be named "photo" for sendPhoto method
  clHttpRequest.AddSubmitFile('photo', 'photo.jpg');

  // Send request to Telegram API
  // URL format: https://api.telegram.org/bot<BOT_TOKEN>/sendPhoto
  s := clHttpTG.Post(Format(urlTGSendPhoto, [botToken]), clHttpRequest);

  // Parse and display response
  ParseTelegramResponse(s);
end;

procedure TForm1.clHttpRequestLoadData(Sender: TObject;
  AItem: TclHttpRequestItem; var AData: TStream);
begin
  if (AItem is TclSubmitFileRequestItem) and
     (TclSubmitFileRequestItem(AItem).FileName = 'photo.jpg') then
  begin
    AData := TMemoryStream.Create();
    try
      Image1.Picture.Graphic.SaveToStream(AData);
      AData.Position := 0;
    except
      FreeAndNil(AData);
      raise;
    end;
  end;
end;

procedure TForm1.ParseTelegramResponse(const AResponse: string);
var
  jsonObj: TclJSONObject;
  okValue: Boolean;
  description: WideString;
begin
  memResponse.Lines.Text := AResponse;

  // Try to parse JSON response using clJson
  jsonObj := TclJSONBase.ParseObject(AResponse);
  try
    // Check if response is OK using BooleanByName
    okValue := jsonObj.BooleanByName('ok');

    if okValue then
    begin
      memResponse.Lines.Add('');
      memResponse.Lines.Add('Photo sent successfully!');
    end else
    begin
      // Get error description if available using ValueByName
      description := jsonObj.ValueByName('description');
      if description <> '' then
      begin
        memResponse.Lines.Add('');
        memResponse.Lines.Add('Error: ' + description);
      end else
      begin
        memResponse.Lines.Add('');
        memResponse.Lines.Add('Error: Unknown error (no description provided)');
      end;
    end;
  finally
    jsonObj.Free();
  end;
end;

function TForm1.GetBotToken: string;
begin
  // IMPORTANT: Replace this with your actual Telegram Bot token
  // Telegram Bot tokens have the following format:
  // 1234567890:ABCdefGHIjklMNOpqrSTUvwxYZ
  //
  // How to get a bot token:
  // 1. Open Telegram and search for @BotFather
  // 2. Start a chat with @BotFather
  // 3. Send /newbot command
  // 4. Follow the instructions to create a new bot
  // 5. Copy the token provided by @BotFather
  // 6. Paste it here (replace the placeholder below)

  // Example (replace with your actual token):
  // Result := '1234567890:ABCdefGHIjklMNOpqrSTUvwxYZ';

  // For testing, return empty string to prompt user
  Result := '';
  // After getting your token, uncomment and modify the line below:
  // Result := 'YOUR_BOT_TOKEN_HERE';
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  // Initialize form
  Caption := 'Send Photo to Telegram Channel';
  edtChannelName.Text := '@channel_name';

  // Set up HTTP component
  clHttpTG.UserAgent := 'Mozilla/4.0 (compatible; Clever Internet Suite)';

  // Optional: Set timeout values
  clHttpTG.TimeOut := 30000; // 30 seconds
  clHttpTG.ConnectTimeout := 10000; // 10 seconds

  // Configure OpenDialog for image loading
  OpenDialog1.Filter := 'Image files (*.jpg;*.jpeg;*.png;*.bmp)|*.jpg;*.jpeg;*.png;*.bmp|All files (*.*)|*.*';
  OpenDialog1.DefaultExt := 'jpg';

  // Display instructions
  memResponse.Lines.Clear;
  memResponse.Lines.Add('=== Telegram Photo Sender ===');
  memResponse.Lines.Add('');
  memResponse.Lines.Add('INSTRUCTIONS:');
  memResponse.Lines.Add('1. Get your bot token from @BotFather in Telegram');
  memResponse.Lines.Add('2. Add your bot as admin to your channel');
  memResponse.Lines.Add('3. Open Unit1.pas and set your token in GetBotToken() function');
  memResponse.Lines.Add('4. Enter your channel name (e.g., @my_channel)');
  memResponse.Lines.Add('5. Click "Load Image" to select a photo');
  memResponse.Lines.Add('6. Click "Send" to upload to Telegram');
  memResponse.Lines.Add('');
  memResponse.Lines.Add('Note: The bot token is stored in code, not on the form.');
end;

procedure TForm1.btnLoadImageClick(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    Image1.Picture.LoadFromFile(OpenDialog1.FileName);
    memResponse.Lines.Add('Image loaded: ' + ExtractFileName(OpenDialog1.FileName));
  end;
end;

end.
