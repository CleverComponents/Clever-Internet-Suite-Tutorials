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
  TComposeAction = (caCancel, caSend, caSave);
  TReplyForwardKind = (rfReply, rfReplyAll, rfForward);

  TfrmComposeMessage = class(TForm)
    MainMenu1: TMainMenu;
    mitFile: TMenuItem;
    mitSend: TMenuItem;
    mitSaveDraft: TMenuItem;
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
    procedure mitSaveDraftClick(Sender: TObject);
    procedure mitCloseClick(Sender: TObject);
    procedure mitAddFileClick(Sender: TObject);
    procedure mitDeleteFileClick(Sender: TObject);
    procedure mitSaveFileClick(Sender: TObject);
    procedure mitPriorityClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lvFilesChange(Sender: TObject; Item: TListItem; Change: TItemChange);
    procedure clHtmlParser1ParseTag(Sender: TObject; ATag: TclHtmlTag);
    procedure clHtmlParser1ParseImage(Sender: TObject; AImage: TclHtmlImage);
    procedure clMailMessage1SaveAttachment(Sender: TObject; ABody:
        TclAttachmentBody; var AFileName: string; var AData: TStream; var Handled:
        Boolean);
    procedure Cut1Click(Sender: TObject);
    procedure Copy1Click(Sender: TObject);
    procedure Paste1Click(Sender: TObject);
    procedure SelectAll1Click(Sender: TObject);
  private
    FMessageText: TStrings;
    FMessageHtml: TStrings;
    FImages: TStrings;
    FEditMode: Boolean;

    procedure ShowCopies;
    procedure HideCopies;
    procedure HideFiles;
    function GetMessageSource: TStrings;
    function ComposeEmail: TComposeAction;
    procedure LoadEmail(AMessageSource: TStrings);

    class procedure DeleteTempFiles;
    class function GetMessageTempDir: string;
    class function GetUniqueTempFileName(const FileName: String): string;
    class function GetAttachFileName(ABody: TclAttachmentBody): string;
    class function GetBodyFileName: string;
  public
    function ComposeNew(const AFrom: string): TComposeAction;
    procedure ViewMessage(AMessageSource: TStrings);
    function EditMessage(AMessageSource: TStrings): TComposeAction;
    function ReplyOrForward(AKind: TReplyForwardKind;
      const AFrom: string; AMessageSource: TStrings): TComposeAction;

    property MessageSource: TStrings read GetMessageSource;
  end;

implementation

{$R *.dfm}

procedure TfrmComposeMessage.FormCreate(Sender: TObject);
begin
  FMessageText := TStringList.Create();
  FMessageHtml := TStringList.Create();
  FImages := TStringList.Create();

  HideCopies();
  HideFiles();
end;

procedure TfrmComposeMessage.FormDestroy(Sender: TObject);
begin
  DeleteTempFiles();

  FImages.Free();
  FMessageHtml.Free();
  FMessageText.Free();
end;

function TfrmComposeMessage.ComposeEmail: TComposeAction;
var
  attachments: TStrings;
  i: Integer;
  html: string;
begin
  FMessageHtml.SaveToFile(GetBodyFileName(), TEncoding.UTF8);
  TMSFNCRichEditorHTMLIO1.Load(GetBodyFileName(), TEncoding.UTF8);

  mitSend.Enabled := FEditMode;
  mitSaveDraft.Enabled := FEditMode;

  mitEdit.Enabled := FEditMode;

  mitPriority.Enabled := FEditMode;
  mitHigh.Enabled := FEditMode;
  mitMedium.Enabled := FEditMode;
  mitLow.Enabled := FEditMode;

  mitAddFile.Enabled := FEditMode;
  mitAddFile2.Enabled := FEditMode;

  TMSFNCRichEditor1.ReadOnly := not FEditMode;

  TMSFNCRichEditorEditToolBar1.Enabled := FEditMode;
  TMSFNCRichEditorFormatToolBar1.Enabled := FEditMode;

  edtFrom.ReadOnly := not FEditMode;
  edtTo.ReadOnly := not FEditMode;
  edtCC.ReadOnly := not FEditMode;
  edtBCC.ReadOnly := not FEditMode;
  edtSubject.ReadOnly := not FEditMode;

  ShowModal();

  case ModalResult of
    mrOk: Result := caSend;
    mrIgnore: Result := caSave;
  else
    Result := caCancel;
  end;

  if (Result <> caCancel) then
  begin
    attachments := TStringList.Create();
    try
      //convert the Rich-text format to HTML
      TMSFNCRichEditorHTMLIO1.Save(GetBodyFileName(), TEncoding.UTF8);
      FMessageHtml.LoadFromFile(GetBodyFileName(), TEncoding.UTF8);

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

      clMailMessage1.CharSet := 'UTF-8';

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

procedure TfrmComposeMessage.LoadEmail(AMessageSource: TStrings);
var
  i: Integer;
  html: string;
begin
  lvFiles.Items.Clear();
  DeleteTempFiles();

  if Assigned(AMessageSource) then
    clMailMessage1.MessageSource := AMessageSource;

  edtSubject.Text := clMailMessage1.Subject;
  edtFrom.Text := clMailMessage1.From.FullAddress;
  edtTo.Text := clMailMessage1.ToList.EmailAddresses;
  edtCC.Text := clMailMessage1.CCList.EmailAddresses;
  edtBCC.Text := clMailMessage1.BCCList.EmailAddresses;
  mitHigh.Checked := (clMailMessage1.Priority = mpHigh);
  mitMedium.Checked := (clMailMessage1.Priority = mpNormal);
  mitLow.Checked := (clMailMessage1.Priority = mpLow);

  if Assigned(clMailMessage1.Html) and (clMailMessage1.Html.Strings.Text <> '') then
    html := clMailMessage1.Html.Strings.Text
  else if Assigned(clMailMessage1.Text) and (clMailMessage1.Text.Strings.Text <> '') then
    html := '<pre>' + clMailMessage1.Text.Strings.Text + '</pre>'
  else
    html := '<html><body></body></html>';

  //collect images paths
  for i := 0 to clMailMessage1.Images.Count -1 do
  begin
    if (clMailMessage1.Images[i].ContentID <> '') then
    begin
      html := StringReplace(html, 'cid:' + clMailMessage1.Images[i].ContentID,
        'file://' + clMailMessage1.Images[i].FileName, [rfIgnoreCase, rfReplaceAll]);
    end;
  end;

  FMessageHtml.Text := html;
end;

function TfrmComposeMessage.ComposeNew(const AFrom: string): TComposeAction;
begin
  FEditMode := True;

  edtFrom.Text := AFrom;
  edtTo.Text := '';
  edtCC.Text := '';
  edtBCC.Text := '';
  edtSubject.Text := '';

  lvFiles.Items.Clear();
  DeleteTempFiles();

  Result := ComposeEmail();
end;

procedure TfrmComposeMessage.ViewMessage(AMessageSource: TStrings);
begin
  FEditMode := False;
  LoadEmail(AMessageSource);
  ComposeEmail();
end;

function TfrmComposeMessage.EditMessage(AMessageSource: TStrings): TComposeAction;
begin
  FEditMode := True;
  LoadEmail(AMessageSource);
  Result := ComposeEmail();
end;

function TfrmComposeMessage.ReplyOrForward(AKind: TReplyForwardKind;
  const AFrom: string; AMessageSource: TStrings): TComposeAction;
begin
  FEditMode := True;

  LoadEmail(AMessageSource);

  edtFrom.Text := AFrom;

  case AKind of
    rfReply, rfReplyAll:
    begin
      edtTo.Text := clMailMessage1.ReplyTo;
      if (edtTo.Text = '') then
      begin
        edtTo.Text := clMailMessage1.From.FullAddress;
      end;

      if (AKind = rfReplyAll) then
      begin
        edtTo.Text := edtTo.Text + ', ' + clMailMessage1.ToList.EmailAddresses;
        if (clMailMessage1.CCList.Count > 0) then
        begin
          edtTo.Text := edtTo.Text + ', ' + clMailMessage1.CCList.EmailAddresses;
        end;
        if (clMailMessage1.BCCList.Count > 0) then
        begin
          edtTo.Text := edtTo.Text + ', ' + clMailMessage1.BCCList.EmailAddresses;
        end;
      end;

      if Pos('Re:', edtSubject.Text) = 0 then
      begin
        edtSubject.Text := 'Re: ' + edtSubject.Text
      end;

      FMessageHtml.Insert(0, '<pre>');
      FMessageHtml.Insert(1, clMailMessage1.From.FullAddress + ' wrote: <br/><br/>');
      FMessageHtml.Insert(2, '</pre>');
    end;

    rfForward:
    begin
      edtTo.Text := '';
      if Pos('Fwd:', edtSubject.Text) = 0 then
      begin
        edtSubject.Text := 'Fwd: ' + edtSubject.Text
      end;

      FMessageHtml.Insert(0, '<pre>');
      FMessageHtml.Insert(2, '----- Forwarded Message -----<br/>');
      FMessageHtml.Insert(3, 'From: ' + clMailMessage1.From.FullAddress + '<br/>');
      FMessageHtml.Insert(4, 'To: ' + clMailMessage1.ToList.EmailAddresses + '<br/>');
      FMessageHtml.Insert(5, 'Sent: ' + DateTimeToStr(clMailMessage1.Date) + '<br/>');
      FMessageHtml.Insert(6, 'Subject: ' + clMailMessage1.Subject + '<br/><br/>');
      FMessageHtml.Insert(7, '</pre>');
    end;
  end;

  Result := ComposeEmail();
end;

procedure TfrmComposeMessage.Copy1Click(Sender: TObject);
begin
  if FEditMode and (ActiveControl = TMSFNCRichEditor1) then
  begin
    TMSFNCRichEditor1.CopyToClipboard();
  end;
end;

procedure TfrmComposeMessage.Cut1Click(Sender: TObject);
begin
  if FEditMode and (ActiveControl = TMSFNCRichEditor1) then
  begin
    TMSFNCRichEditor1.CutToClipboard();
  end;
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
  buf: array[0..MAX_PATH] of Char;
  len: DWORD;
  tmp: string;
begin
  len := GetTempPath(MAX_PATH, buf);
  if (len = 0) then
    tmp := ExtractFilePath(ParamStr(0))
  else
    tmp := string(buf);

  Result := AddTrailingPathDelimiter(tmp) + 'CleverMailClient\';
  ForceFileDirectories(Result);
end;

class function TfrmComposeMessage.GetUniqueTempFileName(const FileName: String): string;
var
  base, ext: String;
  i: Integer;
begin
  Result := GetMessageTempDir() + ExtractFileName(FileName);
  if not FileExists(Result) then Exit;

  base := ChangeFileExt(ExtractFileName(FileName), '');
  ext := ExtractFileExt(FileName);

  i := 1;
  repeat
    Result := GetMessageTempDir() + base + '(' + IntToStr(i) + ')' + ext;
    Inc(i);
  until not FileExists(Result);
end;

class procedure TfrmComposeMessage.DeleteTempFiles;
begin
  DeleteRecursiveDir(GetMessageTempDir());
end;

procedure TfrmComposeMessage.mitAddFileClick(Sender: TObject);
var
  fileName: string;
  item: TListItem;
begin
  if OpenDialog.Execute() then
  begin
    fileName := GetUniqueTempFileName(OpenDialog.FileName);
    CopyFile(PChar(OpenDialog.FileName), PChar(fileName), False);

    item := lvFiles.Items.Add();
    item.Caption := ExtractFileName(fileName);
  end;
end;

procedure TfrmComposeMessage.mitCloseClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrmComposeMessage.mitSaveDraftClick(Sender: TObject);
begin
  ModalResult := mrIgnore;
end;

procedure TfrmComposeMessage.mitDeleteFileClick(Sender: TObject);
begin
  if Assigned(lvFiles.Selected) then
  begin
    DeleteFile(GetMessageTempDir() + lvFiles.Selected.Caption);
    lvFiles.Selected.Delete();
  end;
end;

procedure TfrmComposeMessage.mitPriorityClick(Sender: TObject);
begin
  mitHigh.Checked := (Sender = mitHigh);
  mitMedium.Checked := (Sender = mitMedium);
  mitLow.Checked := (Sender = mitLow);
end;

procedure TfrmComposeMessage.mitSaveFileClick(Sender: TObject);
begin
  if (not Assigned(lvFiles.Selected)) then Exit;

  SaveDialog.FileName := lvFiles.Selected.Caption;

  if SaveDialog.Execute() then
  begin
    CopyFile(PChar(GetMessageTempDir() + lvFiles.Selected.Caption), PChar(SaveDialog.FileName), False);
  end;
end;

procedure TfrmComposeMessage.mitSendClick(Sender: TObject);
begin
  ModalResult := mrOK;
end;

procedure TfrmComposeMessage.Paste1Click(Sender: TObject);
begin
  if FEditMode and (ActiveControl = TMSFNCRichEditor1) then
  begin
    TMSFNCRichEditor1.PasteFromClipboard();
  end;
end;

procedure TfrmComposeMessage.SelectAll1Click(Sender: TObject);
begin
  if FEditMode and (ActiveControl = TMSFNCRichEditor1) then
  begin
    TMSFNCRichEditor1.SelectAll();
  end;
end;

procedure TfrmComposeMessage.lvFilesChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
begin
  mitDeleteFile.Enabled := FEditMode and Assigned(lvFiles.Selected);
  mitSaveFile.Enabled := Assigned(lvFiles.Selected);
  mitDeleteFile2.Enabled := FEditMode and Assigned(lvFiles.Selected);
  mitSaveFile2.Enabled := Assigned(lvFiles.Selected);
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

procedure TfrmComposeMessage.btnShowCCClick(Sender: TObject);
begin
  if (edtCC.Visible) then
    HideCopies()
  else
    ShowCopies();
end;

procedure TfrmComposeMessage.clMailMessage1SaveAttachment(Sender: TObject;
    ABody: TclAttachmentBody; var AFileName: string; var AData: TStream; var
    Handled: Boolean);
var
  item: TListItem;
begin
  AFileName := GetAttachFileName(ABody);
  if (AFileName <> '') then
  begin
    AFileName := GetMessageTempDir() + AFileName;
  end else
  begin
    AFileName := GetUniqueTempFileName(AFileName);
  end;

  if (ABody.ContentID = '') then
  begin
    item := lvFiles.Items.Add();
    item.Caption := ExtractFileName(AFileName);
  end;

  AData := TFileStream.Create(AFileName, fmCreate);
end;

procedure TfrmComposeMessage.ShowCopies;
var
  h: Integer;
begin
  edtCC.Visible := True;
  lblCC.Visible := True;
  edtBCC.Visible := True;
  lblBCC.Visible := True;

  h := Panel2.Height - edtSubject.Top;
  edtSubject.Top := edtBCC.Top + (edtBCC.Top - edtCC.Top);
  lblSubject.Top := lblBCC.Top + (lblBCC.Top - lblCC.Top);
  Panel1.Height := edtSubject.Top + h;
  Panel2.Height := edtSubject.Top + h;
  btnShowCC.Caption := '-';
end;

procedure TfrmComposeMessage.HideCopies;
var
  h: Integer;
begin
  edtCC.Visible := False;
  lblCC.Visible := False;
  edtBCC.Visible := False;
  lblBCC.Visible := False;

  h := Panel2.Height - edtSubject.Top;
  edtSubject.Top := edtTo.Top + (edtCC.Top - edtTo.Top);
  lblSubject.Top := lblTo.Top + (lblCC.Top - lblTo.Top);
  Panel1.Height := edtSubject.Top + h;
  Panel2.Height := edtSubject.Top + h;
  btnShowCC.Caption := '+';
end;

procedure TfrmComposeMessage.HideFiles;
begin
  lvFiles.Width := 0;
end;

end.
