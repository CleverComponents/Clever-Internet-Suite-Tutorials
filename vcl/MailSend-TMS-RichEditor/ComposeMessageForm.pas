unit ComposeMessageForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, System.ImageList, System.Generics.Collections,
  Vcl.ImgList, System.Actions, Vcl.ActnList, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.ExtCtrls, clMailMessage, Vcl.ToolWin, VCL.TMSFNCTypes,
  VCL.TMSFNCUtils, VCL.TMSFNCGraphics, VCL.TMSFNCGraphicsTypes,
  VCL.TMSFNCScrollControl, VCL.TMSFNCRichEditorBase, VCL.TMSFNCRichEditor,
  VCL.TMSFNCRichEditorToolBar, VCL.TMSFNCCustomControl, VCL.TMSFNCToolBar,
  VCL.TMSFNCCustomComponent, VCL.TMSFNCRichEditorIO,
  clUtils, clHtmlParser;

type
  TfrmComposeMessage = class(TForm)
    MainMenu1: TMainMenu;
    mitFile: TMenuItem;
    mitSend: TMenuItem;
    mitClose: TMenuItem;
    mitEdit: TMenuItem;
    Cut1: TMenuItem;
    Copy1: TMenuItem;
    Paste1: TMenuItem;
    SelectAll1: TMenuItem;
    mitPriority: TMenuItem;
    mitHigh: TMenuItem;
    mitMedium: TMenuItem;
    mitLow: TMenuItem;
    mitAttachment: TMenuItem;
    mitAddFile: TMenuItem;
    mitDeleteFile: TMenuItem;
    mitSaveFile: TMenuItem;
    pmFiles: TPopupMenu;
    mitAddFile2: TMenuItem;
    mitDeleteFile2: TMenuItem;
    mitSaveFile2: TMenuItem;
    ImageList1: TImageList;
    ilPriority: TImageList;
    SaveDialog: TSaveDialog;
    OpenDialog: TOpenDialog;
    Panel1: TPanel;
    Splitter1: TSplitter;
    Panel2: TPanel;
    lblTo: TLabel;
    lblFrom: TLabel;
    lblSubject: TLabel;
    lblCC: TLabel;
    lblBCC: TLabel;
    edtSubject: TEdit;
    edtFrom: TEdit;
    edtTo: TEdit;
    btnShowCC: TButton;
    edtCC: TEdit;
    edtBCC: TEdit;
    lvFiles: TListView;
    ToolBar1: TToolBar;
    TMSFNCRichEditor1: TTMSFNCRichEditor;
    TMSFNCRichEditorEditToolBar1: TTMSFNCRichEditorEditToolBar;
    TMSFNCRichEditorFormatToolBar1: TTMSFNCRichEditorFormatToolBar;
    TMSFNCRichEditorHTMLIO1: TTMSFNCRichEditorHTMLIO;
    clHtmlParser1: TclHtmlParser;
    clMailMessage1: TclMailMessage;
    procedure btnShowCCClick(Sender: TObject);
    procedure mitSendClick(Sender: TObject);
    procedure mitCloseClick(Sender: TObject);
    procedure mitAddFileClick(Sender: TObject);
    procedure mitDeleteFileClick(Sender: TObject);
    procedure mitSaveFileClick(Sender: TObject);
    procedure mitPriorityClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lvFilesChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure clHtmlParser1ParseTag(Sender: TObject; ATag: TclHtmlTag);
    procedure clHtmlParser1ParseImage(Sender: TObject; AImage: TclHtmlImage);
    procedure Cut1Click(Sender: TObject);
    procedure Copy1Click(Sender: TObject);
    procedure Paste1Click(Sender: TObject);
    procedure SelectAll1Click(Sender: TObject);
  private
    FMessageText: TStrings;
    FMessageHtml: TStrings;
    FImages: TStrings;

    procedure ShowCopies;
    procedure HideCopies;
    procedure ShowFiles;
    procedure HideFiles;
    function GetMessageSource: TStrings;
  public
    function ComposeEmail(const AFrom: string): Boolean;

    property MessageSource: TStrings read GetMessageSource;

    class procedure DeleteTempFiles;
    class function GetMessageTempDir: string;
    class function GetUniqueTempFileName(const FileName: String): string;
    class function GetAttachFileName(ABody: TclAttachmentBody): string;
    class function GetBodyFileName: string;
  end;

implementation

{$R *.dfm}

procedure TfrmComposeMessage.btnShowCCClick(Sender: TObject);
begin
  if not edtCC.Visible then
  begin
    ShowCopies();
  end else
  begin
    HideCopies();
  end;
end;

procedure TfrmComposeMessage.clHtmlParser1ParseImage(Sender: TObject; AImage: TclHtmlImage);
begin
  FImages.Add(StringReplace(AImage.Src, 'file://', '', [rfIgnoreCase]));
end;

procedure TfrmComposeMessage.clHtmlParser1ParseTag(Sender: TObject; ATag: TclHtmlTag);
begin
  if (ATag.IsText and (Trim(ATag.Text) <> '')) then
  begin
    FMessageText.Add(StringReplace(ATag.Text, '&nbsp;', ' ', [rfIgnoreCase, rfReplaceAll]));
  end;
end;

class procedure TfrmComposeMessage.DeleteTempFiles;
begin
  DeleteRecursiveDir(GetMessageTempDir());
end;

procedure TfrmComposeMessage.FormCreate(Sender: TObject);
begin
  FMessageText := TStringList.Create();
  FMessageHtml := TStringList.Create();
  FImages := TStringList.Create();

  HideCopies();
  HideFiles();
  ActiveControl := TMSFNCRichEditor1;
end;

procedure TfrmComposeMessage.FormDestroy(Sender: TObject);
begin
  FImages.Free();
  FMessageHtml.Free();
  FMessageText.Free();
end;

function TfrmComposeMessage.ComposeEmail(const AFrom: string): Boolean;
var
  attachments: TStrings;
  i: Integer;
  html: string;
begin
  DeleteTempFiles();

  edtFrom.Text := AFrom;

  Result := (ShowModal() = mrOK);

  if (Result) then
  begin
    attachments := TStringList.Create();
    try
      //convert the Rich-text format to HTML
      TMSFNCRichEditorHTMLIO1.Save(GetBodyFileName(), TEncoding.Unicode);
      FMessageHtml.LoadFromFile(GetBodyFileName(), TEncoding.Unicode);

      //convert HTML to text and extract embedded images
      FMessageText.Clear();
      FImages.Clear();
      clHtmlParser1.Parse(FMessageHtml);

      //collect attachments
      if (lvFiles.Items.Count > 0) then
      begin
        for i := 0 to lvFiles.Items.Count - 1 do
        begin
          attachments.Add(GetMessageTempDir() + lvFiles.Items[i].Caption);
        end;
      end;

      //get body HTML
      html := StringReplace(FMessageHtml.Text, 'file://', '', [rfIgnoreCase, rfReplaceAll]);

      //build a new E-mail message
      clMailMessage1.BuildMessage(FMessageText.Text, html, FImages, attachments);

      clMailMessage1.Subject := edtSubject.Text;
      clMailMessage1.From.FullAddress := edtFrom.Text;
      clMailMessage1.ToList.EmailAddresses := edtTo.Text;
      clMailMessage1.CCList.EmailAddresses := edtCC.Text;
      clMailMessage1.BCCList.EmailAddresses := edtBCC.Text;

      if mitLow.Checked then
        clMailMessage1.Priority := mpLow
      else if mitHigh.Checked then
        clMailMessage1.Priority := mpHigh
      else
        clMailMessage1.Priority := mpNormal;
    finally
      attachments.Free();
    end;
  end;
end;

procedure TfrmComposeMessage.Copy1Click(Sender: TObject);
begin
  TMSFNCRichEditor1.CopyToClipboard();
end;

procedure TfrmComposeMessage.Cut1Click(Sender: TObject);
begin
  TMSFNCRichEditor1.CutToClipboard();
end;

class function TfrmComposeMessage.GetAttachFileName(ABody: TclAttachmentBody): string;
var
  i: Integer;
  c: Char;
begin
  Result := ExtractFileName(ABody.FileName);
  if (Result = '') then
  begin
    for i := 1 to Length(ABody.ContentID) do
    begin
      c := ABody.ContentID[i];
      if (CharInSet(c, ['0'..'9', 'a'..'z', 'A'..'Z', '.'])) then
      begin
        Result := Result + ABody.ContentID[i];
      end;
    end;
    if (Result = '') then
    begin
      Result := 'noname.dat';
    end;
  end;
end;

class function TfrmComposeMessage.GetBodyFileName: string;
begin
  Result := GetMessageTempDir() + 'body.html';
end;

function TfrmComposeMessage.GetMessageSource: TStrings;
begin
  Result := clMailMessage1.MessageSource;
end;

class function TfrmComposeMessage.GetMessageTempDir: string;
var
  Buffer: array[0..MAX_PATH - 1] of Char;
  l: Integer;
begin
  l := GetTempPath(MAX_PATH, Buffer);
  SetString(Result, Buffer, l);
  if (Result <> '') and (Result[Length(Result)] <> '\') then
  begin
    Result := Result + '\';
  end;
  Result := Result + 'CleverMailClient\';
  ForceDirectories(Result);
end;

class function TfrmComposeMessage.GetUniqueTempFileName(const FileName: String): string;
var
  Dir, Name, Ext: String;
  i: Integer;
begin
  Dir := GetMessageTempDir();
  if not FileExists(Dir + FileName) then
  begin
    Result := FileName;
    Exit;
  end;
  Ext := ExtractFileExt(FileName);
  Name := Copy(FileName, 1, Length(FileName) - Length(Ext));
  Name := Name + '(';
  Ext  := ')' + Ext;
  i := 1;
  while FileExists(Dir+Name+IntToStr(i)+Ext) do
  begin
    Inc(i);
  end;
  Result := Name + IntToStr(i) + Ext;
end;

procedure TfrmComposeMessage.HideCopies;
var
  h: Integer;
begin
  lblCC.Visible := False;
  edtCC.Visible := False;
  lblBCC.Visible := False;
  edtBCC.Visible := False;

  h := Panel2.Height - edtSubject.Top;
  edtSubject.Top := edtCC.Top;
  lblSubject.Top := lblCC.Top;
  Panel1.Height := edtSubject.Top + h;
  Panel2.Height := edtSubject.Top + h;
  btnShowCC.Caption := '+';
end;

procedure TfrmComposeMessage.mitAddFileClick(Sender: TObject);
var
  Item: TListItem;
  NewName: string;
begin
  if OpenDialog.Execute() then
  begin
    NewName := GetMessageTempDir() + GetUniqueTempFileName(ExtractFileName(OpenDialog.FileName));
    CopyFile(PChar(OpenDialog.FileName), PChar(NewName), False);
    Item := lvFiles.Items.Add();
    Item.Caption := ExtractFileName(NewName);
    Item.ImageIndex := 37;

    ShowFiles();
  end;
end;

procedure TfrmComposeMessage.mitCloseClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrmComposeMessage.mitDeleteFileClick(Sender: TObject);
var
  Index: Integer;
begin
  if (lvFiles.Selected = nil) then Exit;

  DeleteFile(GetMessageTempDir() + lvFiles.Selected.Caption);
  Index := lvFiles.Selected.Index;
  lvFiles.Selected.Delete();

  if Index>=lvFiles.Items.Count then
  begin
    Dec(Index);
  end;
  if (Index >= 0) then
  begin
    lvFiles.Selected := lvFiles.Items[Index];
  end;
end;

procedure TfrmComposeMessage.mitPriorityClick(Sender: TObject);
begin
  ilPriority.GetIcon(TMenuItem(Sender).Tag, Icon);
end;

procedure TfrmComposeMessage.mitSaveFileClick(Sender: TObject);
begin
  if (lvFiles.Selected = nil) then Exit;

  SaveDialog.FileName := lvFiles.Selected.Caption;
  if SaveDialog.Execute then
  begin
    CopyFile(PChar(GetMessageTempDir() + lvFiles.Selected.Caption), PChar(SaveDialog.FileName), False);
  end;
end;

procedure TfrmComposeMessage.mitSendClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TfrmComposeMessage.Paste1Click(Sender: TObject);
begin
  TMSFNCRichEditor1.PasteFromClipboard();
end;

procedure TfrmComposeMessage.lvFilesChange(Sender: TObject; Item: TListItem; Change: TItemChange);
begin
  mitDeleteFile.Enabled := (lvFiles.Selected <> nil);
  mitDeleteFile2.Enabled := mitDeleteFile.Enabled;
  mitSaveFile.Enabled := (lvFiles.Selected <> nil);
  mitSaveFile2.Enabled := mitSaveFile.Enabled;
end;

procedure TfrmComposeMessage.SelectAll1Click(Sender: TObject);
begin
  TMSFNCRichEditor1.SelectAll();
end;

procedure TfrmComposeMessage.ShowCopies;
var
  h: Integer;
begin
  lblCC.Visible := True;
  edtCC.Visible := True;
  lblBCC.Visible := True;
  edtBCC.Visible := True;

  h := Panel2.Height - edtSubject.Top;
  edtSubject.Top := edtBCC.Top + (edtBCC.Top - edtCC.Top);
  lblSubject.Top := lblBCC.Top + (lblBCC.Top - lblCC.Top);
  Panel1.Height := edtSubject.Top + h;
  Panel2.Height := edtSubject.Top + h;
  btnShowCC.Caption := '-';
end;

procedure TfrmComposeMessage.ShowFiles;
begin
  if lvFiles.Width = 0 then
  begin
    lvFiles.Width := Splitter1.MinSize;
  end;
end;

procedure TfrmComposeMessage.HideFiles;
begin
  lvFiles.Width := 0;
end;

end.
