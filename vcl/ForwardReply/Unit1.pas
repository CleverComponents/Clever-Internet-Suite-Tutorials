unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, clMailMessage, clSmtp, clTcpClient, clMC, clPop3, Unit2,
  clHtmlParser;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtServer: TEdit;
    edtUser: TEdit;
    edtPassword: TEdit;
    btnReceive: TButton;
    ListBox1: TListBox;
    btnReply: TButton;
    btnForward: TButton;
    clPop31: TclPop3;
    clSmtp1: TclSmtp;
    clMailMessage1: TclMailMessage;
    clHtmlParser1: TclHtmlParser;
    clHtmlTextParser2: TclHtmlParser;
    procedure btnReceiveClick(Sender: TObject);
    procedure btnReplyClick(Sender: TObject);
    procedure btnForwardClick(Sender: TObject);
    procedure clHtmlTextParser2ParseTag(Sender: TObject; ATag: TclHtmlTag);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FTextLines: TStrings;

    function GetMessageText(AHtml: TStrings): string;
    procedure MakeHtmlReply(ABody: TclTextBody; AHtml: TStrings);
    procedure MakeTextReply(ABody: TclTextBody; AText: TStrings);
    function SendEmailMessage(const AToAddress, ASubject: string): Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnReceiveClick(Sender: TObject);
var
  i: Integer;
begin
  clPop31.Server := edtServer.Text;
  clPop31.UserName := edtUser.Text;
  clPop31.Password := edtPassword.Text;
  clPop31.Open();

  ListBox1.Items.Clear();

  for i := 1 to clPop31.MessageCount do
  begin
    clPop31.RetrieveHeader(i, clMailMessage1);

    ListBox1.Items.Add(clMailMessage1.Subject + ', ' + clMailMessage1.From.FullAddress);
  end;

  clPop31.Close();
end;

procedure TForm1.btnReplyClick(Sender: TObject);
begin
  if ListBox1.ItemIndex < 0 then
  begin
    ShowMessage('No messages selected');
    Exit;
  end;

  clPop31.Server := edtServer.Text;
  clPop31.UserName := edtUser.Text;
  clPop31.Password := edtPassword.Text;
  clPop31.Open();

  try
    clPop31.Retrieve(ListBox1.ItemIndex + 1, clMailMessage1);
  finally
    clPop31.Close();
   end;

  if SendEmailMessage(clMailMessage1.From.FullAddress, 'Re: ' + clMailMessage1.Subject) then
  begin
    ShowMessage('Message was replied');
  end;
end;

procedure TForm1.clHtmlTextParser2ParseTag(Sender: TObject; ATag: TclHtmlTag);
begin
  if (ATag.IsText) then
    FTextLines.Add(ATag.Text);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FTextLines := TStringList.Create();
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FTextLines.Free();
end;

procedure TForm1.btnForwardClick(Sender: TObject);
begin
  if ListBox1.ItemIndex < 0 then
  begin
    ShowMessage('No messages selected');
    Exit;
  end;

  clPop31.Server := edtServer.Text;
  clPop31.UserName := edtUser.Text;
  clPop31.Password := edtPassword.Text;
  clPop31.Open();
  

  clPop31.Retrieve(ListBox1.ItemIndex + 1, clMailMessage1);

  clPop31.Close();

  if SendEmailMessage('', 'Fw: ' + clMailMessage1.Subject) then
  begin
    ShowMessage('Message was forwarded');
  end;
end;

function TForm1.SendEmailMessage(const AToAddress, ASubject: string): Boolean;
var
  dlg: TMessageForm;
  text: string;
begin
  dlg := TMessageForm.Create(nil);
  try
    dlg.edtTo.Text := AToAddress;
    dlg.edtSubject.Text := ASubject;

    if (clMailMessage1.Html <> nil) then
    begin
      MakeHtmlReply(clMailMessage1.Html, dlg.memText.Lines);
    end else
    if (clMailMessage1.Text <> nil) then
    begin
      MakeTextReply(clMailMessage1.Text, dlg.memText.Lines);
    end;

    Result := (dlg.ShowModal() = mrOK);
    
    if Result then
    begin
      clSmtp1.Server := edtServer.Text;
      clSmtp1.UserName := edtUser.Text;
      clSmtp1.Password := edtPassword.Text;

      clSmtp1.Open();

      if (clMailMessage1.Html <> nil) then
      begin
        text := '';
        if (clMailMessage1.Text <> nil) then
        begin
          text := GetMessageText(dlg.memText.Lines);
        end;

        clMailMessage1.BuildMessage(text, dlg.memText.Lines.Text);
      end else
      begin
        clMailMessage1.BuildMessage(dlg.memText.Lines.Text, '');
      end;

      clMailMessage1.From.FullAddress := dlg.edtFrom.Text;
      clMailMessage1.ToList.EmailAddresses := dlg.edtTo.Text;
      clMailMessage1.Subject := dlg.edtSubject.Text;

      clSmtp1.Send(clMailMessage1);
    end;
  finally
    clSmtp1.Close();
    dlg.Free();
  end;
end;

function TForm1.GetMessageText(AHtml: TStrings): string;
begin
  FTextLines.Clear();
  clHtmlTextParser2.Parse(AHtml);
  Result := FTextLines.Text;
end;

procedure TForm1.MakeTextReply(ABody: TclTextBody; AText: TStrings);
var
  i: Integer;
begin
  AText.Add('Reply follows here');
  AText.Add('');
  AText.Add('');

  for i := 0 to ABody.Strings.Count - 1 do
  begin
    AText.Add('> ' + ABody.Strings[i]);
  end;
end;

procedure TForm1.MakeHtmlReply(ABody: TclTextBody; AHtml: TStrings);
const
  BLOCKQUOTEStart = '<BLOCKQUOTE + style="PADDING-RIGHT: 0px; PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #000000 2px solid; MARGIN-RIGHT: 0px">';
  BLOCKQUOTEEnd = '</BLOCKQUOTE>';
var
  tag: TclHtmlTag;
  s, reply: string;
  id: Integer;
begin
  reply := '<DIV>Reply follows here</DIV>';
  s := ABody.Strings.Text;

  clHtmlParser1.Parse(s);

  tag := clHtmlParser1.Tags.TagByName('BODY');
  Insert(reply + BLOCKQUOTEStart, s, tag.InnerTextPos);

  id := clHtmlParser1.Tags.IndexOf(clHtmlParser1.Tags.TagByName('BODY', tag.NextTag));
  tag := clHtmlParser1.Tags[id - 1];
  Insert(BLOCKQUOTEEnd, s, tag.InnerTextPos + Length(reply + BLOCKQUOTEStart));

  AHtml.Text := s;
end;

end.
