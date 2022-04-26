unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  System.UITypes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, clTcpClient, clSFtp, Vcl.StdCtrls, clSFtpUtils,
  clTcpClientSsh, KnownHosts;

type
  TMainForm = class(TForm)
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
    lbFileList: TListBox;
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
    Image1: TImage;
    btnKnownHosts: TButton;
    procedure btnLoginClick(Sender: TObject);
    procedure cbAuthorizationChange(Sender: TObject);
    procedure btnLogoutClick(Sender: TObject);
    procedure btnOpenDirClick(Sender: TObject);
    procedure btnGoUpClick(Sender: TObject);
    procedure btnDownloadClick(Sender: TObject);
    procedure btnUploadClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure clSFtp1VerifyServer(Sender: TObject; const AHost, AKeyType,
      AFingerPrint, AHostKey: string; var AVerified: Boolean);
    procedure clSFtp1DirectoryListing(Sender: TObject; const AFileName: string;
      AFileAttrs: TclSFtpFileAttrs);
    procedure lbFileListDblClick(Sender: TObject);
    procedure btnKnownHostsClick(Sender: TObject);
    procedure clSFtp1Progress(Sender: TObject; ABytesProceed,
      ATotalBytes: Int64);
  private
    FHostKeyRepository: TStrings;
    procedure UpdateStatuses;
    procedure DoOpenDir (const ADir: string);
    procedure FillDirList;
    procedure UpdateControls;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FHostKeyRepository := TStringList.Create();
  if FileExists('hostkeyrepository.txt') then
  begin
    //Load information about trusted SFTP servers.
    FHostKeyRepository.LoadFromFile('hostkeyrepository.txt');
  end;

  UpdateControls();
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  //Save information about trusted SFTP servers.
  FHostKeyRepository.SaveToFile('hostkeyrepository.txt');
  FHostKeyRepository.Free();
end;

procedure TMainForm.lbFileListDblClick(Sender: TObject);
begin
  if (lbFileList.ItemIndex > -1) and
    (lbFileList.Items[lbFileList.ItemIndex] = '/..') then
  begin
    btnGoUpClick(Sender);
  end else
  begin
    btnOpenDirClick(Sender);
  end;
end;

procedure TMainForm.clSFtp1VerifyServer(Sender: TObject; const AHost, AKeyType,
  AFingerPrint, AHostKey: string; var AVerified: Boolean);
var
  hostInfo: string;
begin
  //Use the host address together with the server's fingerprint
  //to uniquely identify the SFTP host.
  hostInfo := AHost + ';' + AFingerPrint;

  //Check, whether this host was previously verified.
  AVerified := FHostKeyRepository.IndexOf(hostInfo) > -1;

  //If yes, go ahead and connect.
  if AVerified then Exit;

  //Otherwise, ask user to confirm or decline the connection.
  AVerified := (MessageDlg(Format('You are trying to connect to ''%s'' host,'#13#10
    + 'Key Type: %s'#13#10
    + 'Finger Print: %s'#13#10#13#10
    + 'Do you wish to proceed ?', [AHost, AKeyType, AFingerPrint]),
    mtWarning, [mbYes, mbNo], 0) = mrYes);

  //If the connection is verified and trusted by user,
  //save the connection details to the host-key repository.
  if AVerified then
  begin
    FHostKeyRepository.Add(hostInfo);
  end;
end;

procedure TMainForm.UpdateStatuses;
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

procedure TMainForm.btnLogoutClick(Sender: TObject);
begin
  clSFtp1.Close();
  lbFileList.Items.Clear();
  UpdateStatuses();
  ProgressBar.Position := 0;
end;

procedure TMainForm.btnOpenDirClick(Sender: TObject);
begin
  if (lbFileList.ItemIndex > -1) and
    (lbFileList.Items[lbFileList.ItemIndex] <> '') and
    (lbFileList.Items[lbFileList.ItemIndex][1] = '/') then
  begin
    DoOpenDir(clSFtp1.CurrentDir + lbFileList.Items[lbFileList.ItemIndex]);
  end;
end;

procedure TMainForm.btnUploadClick(Sender: TObject);
var
 stream: TStream;
 fileName: string;
begin
  if OpenDialog1.Execute() then
  begin
    stream := TFileStream.Create(OpenDialog1.FileName, fmOpenRead);
    try
      fileName := ExtractFileName(OpenDialog1.FileName);
      ProgressBar.Position := 0;
      clSFtp1.PutFile(stream, fileName);
      FillDirList();
      ShowMessage('Done');
    finally
      stream.Free();
    end;
  end;
end;

procedure TMainForm.UpdateControls;
var
  isUserPassword: Boolean;
begin
  isUserPassword := (cbAuthorization.ItemIndex = 0);

  edtPassword.Enabled := isUserPassword;
  edtPrivateKeyFile.Enabled := not isUserPassword;
  edtPassphrase.Enabled := not isUserPassword;
end;

procedure TMainForm.cbAuthorizationChange(Sender: TObject);
begin
  UpdateControls();
end;

procedure TMainForm.clSFtp1DirectoryListing(Sender: TObject;
  const AFileName: string; AFileAttrs: TclSFtpFileAttrs);
  const
  dirPrefix: array[Boolean] of string = ('', '/');
begin
  lbFileList.Items.Add(dirPrefix[AFileAttrs.IsDir] + AFileName);
end;

procedure TMainForm.clSFtp1Progress(Sender: TObject; ABytesProceed, ATotalBytes: Int64);
begin
  if (ABytesProceed = 0) or (ATotalBytes = 0) then
  begin
    ProgressBar.Position := 0;
  end else
  begin
    ProgressBar.Position := Round(ABytesProceed / ATotalBytes * 100);
  end;
end;

procedure TMainForm.DoOpenDir(const ADir: string);
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

procedure TMainForm.FillDirList;
begin
  lbFileList.Items.BeginUpdate();
  try
    lbFileList.Items.Clear();
    clSFtp1.DirectoryListing();
  finally
    lbFileList.Items.EndUpdate();
  end;
  lbFileList.Sorted := False;
  lbFileList.Sorted := True;
end;

procedure TMainForm.btnDownloadClick(Sender: TObject);
var
  stream: TStream;
begin
  if (lbFileList.ItemIndex > -1) and
    (lbFileList.Items[lbFileList.ItemIndex] <> '') and
    (lbFileList.Items[lbFileList.ItemIndex][1] <> '/') then
    begin
      SaveDialog1.FileName := lbFileList.Items[lbFileList.ItemIndex];
      if SaveDialog1.Execute() then
      begin
        stream := TFileStream.Create(SaveDialog1.FileName, fmCreate);
        try
          ProgressBar.Position := 0;
          clSFtp1.GetFile(lbFileList.Items[lbFileList.ItemIndex], stream);
          ShowMessage('Done');
        finally
          stream.Free();
        end;
      end;
    end;
end;

procedure TMainForm.btnGoUpClick(Sender: TObject);
begin
  clSFtp1.ChangeToParentDir();
  FillDirList();
end;

procedure TMainForm.btnKnownHostsClick(Sender: TObject);
var
  dlg: TKnownHostsForm;
begin
  dlg := TKnownHostsForm.Create(nil);
  try
    dlg.ShowKnownHosts(FHostKeyRepository);
  finally
    dlg.Free();
  end;
end;

procedure TMainForm.btnLoginClick(Sender: TObject);
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
  ProgressBar.Position := 0;
end;

end.
