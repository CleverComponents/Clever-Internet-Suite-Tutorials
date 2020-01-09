unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, clTcpClient, clSFtp, Vcl.StdCtrls, clSFtpUtils,
  Vcl.ComCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtHost: TEdit;
    edtUser: TEdit;
    edtPort: TEdit;
    Label4: TLabel;
    edtPassword: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    edtPrivateKeyFile: TEdit;
    edtPassphrase: TEdit;
    Label7: TLabel;
    edtStartDir: TEdit;
    Label8: TLabel;
    cbAuthorization: TComboBox;
    Label9: TLabel;
    lbList: TListBox;
    ProgressBar: TProgressBar;
    btnLogin: TButton;
    btnLogout: TButton;
    btnOpenDir: TButton;
    btnGoUp: TButton;
    btnDownload: TButton;
    btnUpload: TButton;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    clSFtp1: TclSFtp;
    procedure btnLoginClick(Sender: TObject);
    procedure cbAuthorizationChange(Sender: TObject);
    procedure btnLogoutClick(Sender: TObject);
    procedure btnOpenDirClick(Sender: TObject);
    procedure btnGoUpClick(Sender: TObject);
    procedure btnDownloadClick(Sender: TObject);
    procedure btnUploadClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure clSFtp1DirectoryListing(Sender: TObject; const AFileName: string;
      AFileAttrs: TclSFtpFileAttrs);
    procedure clSFtp1VerifyServer(Sender: TObject; const AHost, AKeyType,
      AFingerPrint, AHostKey: string; var AVerified: Boolean);
  private
    procedure UpdateStatuses;
    procedure DoOpenDir (const ADir: string);
    procedure FillDirList;
    procedure UpdateControls;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.UpdateStatuses;
const
  states: array[Boolean] of string = ('SFTP Client (Sample)', 'SFTP Client - Connected (Sample)');
var
  enabled: Boolean;
begin
  enabled := clSFtp1.Active;
  Caption := states[enabled];
  btnOpenDir.Enabled := enabled;
  btnGoUp.Enabled := enabled;
  btnDownload.Enabled := enabled;
  btnUpload.Enabled := enabled;
end;

procedure TForm1.btnLogoutClick(Sender: TObject);
begin
  clSFtp1.Close();
  lbList.Items.Clear();
  UpdateStatuses();
end;

procedure TForm1.btnOpenDirClick(Sender: TObject);
begin
  if (lbList.ItemIndex > -1) and
    (lbList.Items[lbList.ItemIndex] <> '') and
    (lbList.Items[lbList.ItemIndex][1] = '/') then
    begin
      DoOpenDir(clSFtp1.CurrentDir + lbList.Items[lbList.ItemIndex]);
    end;
end;

procedure TForm1.btnUploadClick(Sender: TObject);
var
 stream: TStream;
 fileName: string;
begin
  if OpenDialog1.Execute() then
  begin
    stream := TFileStream.Create(OpenDialog1.FileName, fmOpenRead);
    try
      fileName := ExtractFileName(OpenDialog1.FileName);

      ProgressBar.Min := 0;
      ProgressBar.Max := stream.Size;
      ProgressBar.Position := 0;
      clSFtp1.PutFile(stream, fileName);
      ShowMessage('Done');
    finally
      stream.Free();
    end;
  end;
end;

procedure TForm1.UpdateControls;
var
  isUserPassword: Boolean;
begin
  isUserPassword := (cbAuthorization.ItemIndex = 0);

  edtPassword.Enabled := isUserPassword;
  edtPrivateKeyFile.Enabled := not isUserPassword;
  edtPassphrase.Enabled := not isUserPassword;
end;

procedure TForm1.cbAuthorizationChange(Sender: TObject);
begin
  UpdateControls();
end;

procedure TForm1.clSFtp1DirectoryListing(Sender: TObject;
  const AFileName: string; AFileAttrs: TclSFtpFileAttrs);
  const
  dirPrefix: array[Boolean] of string = ('', '/');
begin
  lbList.Items.Add(dirPrefix[AFileAttrs.IsDir] + AFileName);
end;

procedure TForm1.clSFtp1VerifyServer(Sender: TObject; const AHost, AKeyType,
  AFingerPrint, AHostKey: string; var AVerified: Boolean);
begin
  AVerified := (MessageDlg(Format('You are trying to connect to ''%s'' host,'#13#10
    + 'Key Type: %s'#13#10
    + 'Finger Print: %s'#13#10#13#10
    + 'Do you wish to proceed ?', [AHost, AKeyType, AFingerPrint]),
    mtWarning, [mbYes, mbNo], 0) = mrYes);
end;

procedure TForm1.DoOpenDir(const ADir: string);
var
  dir: string;
begin
  dir := ADir;
  if (Length(dir) > 1) and (dir[1] = '/') and (dir[2] = '/') then
  begin
    system.Delete(dir, 1, 1);
  end;
  clSFtp1.ChangeCurrentDir('/');
  clSFtp1.ChangeCurrentDir(dir);
  FillDirList();
end;

procedure TForm1.FillDirList;
begin
  lbList.Items.BeginUpdate();
  try
    lbList.Items.Clear();
    clSFtp1.DirectoryListing();
  finally
    lbList.Items.EndUpdate();
  end;
  lbList.Sorted := False;
  lbList.Sorted := True;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  UpdateControls();
end;

procedure TForm1.btnDownloadClick(Sender: TObject);
var
  size: Integer;
  stream: TStream;
begin
  if (lbList.ItemIndex > -1) and
    (lbList.Items[lbList.ItemIndex] <> '') and
    (lbList.Items[lbList.ItemIndex][1] <> '/') then
    begin
      SaveDialog1.FileName := lbList.Items[lbList.ItemIndex];
      if SaveDialog1.Execute() then
      begin
        size := clSFtp1.GetFileSize(lbList.Items[lbList.ItemIndex]);
        stream := nil;
        try
          stream := TFileStream.Create(SaveDialog1.FileName, fmCreate);
          ProgressBar.Min := 0;
          ProgressBar.Max := size;
          ProgressBar.Position := 0;
          clSFtp1.GetFile(lbList.Items[lbList.ItemIndex], stream);
          ShowMessage('Done');
        finally
          stream.Free();
        end;
      end;
    end;
end;

procedure TForm1.btnGoUpClick(Sender: TObject);
begin
  clSFtp1.ChangeToParentDir();
  FillDirList();
end;

procedure TForm1.btnLoginClick(Sender: TObject);
begin
  if clSFtp1.Active then
  begin
    ShowMessage('You are already connected. Please click Logout to disconnect.');
    Exit;
  end;

  clSFtp1.Server := edtHost.Text;
  clSFtp1.Port := StrToInt(edtPort.Text);

  clSFtp1.UserName := edtUser.Text;

  clSFtp1.Password := '';
  clSFtp1.UserKey.Clear();

  if (cbAuthorization.ItemIndex = 0) then //user/password authorization
  begin
    clSFtp1.Password := edtPassword.Text;
  end else //public key
  begin
    clSFtp1.UserKey.PrivateKeyFile := edtPrivateKeyFile.Text;
    clSFtp1.UserKey.PassPhrase := edtPassphrase.Text;
  end;

  clSFtp1.Open();

  if (edtStartDir.Text = '') then
  begin
    edtStartDir.Text := clSFtp1.CurrentDir;
  end;
  if (edtStartDir.Text <> '') and (edtStartDir.Text[1] = '/') then
  begin
    DoOpenDir(edtStartDir.Text);
  end;
  UpdateStatuses();
end;

end.
