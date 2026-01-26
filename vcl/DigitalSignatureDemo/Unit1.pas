unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, clEncryptor, StdCtrls, clCertificate,
  clCertificateStore, ExtCtrls;

type
  TForm1 = class(TForm)
    clEncryptor1: TclEncryptor;
    btnSign: TButton;
    btnVerifyFile: TButton;
    clCertificateStore1: TclCertificateStore;
    OpenDialog1: TOpenDialog;
    Label3: TLabel;
    edtSourceFile: TEdit;
    btnSource: TButton;
    edtDestinationFile: TEdit;
    Label5: TLabel;
    btnDestinationFile: TButton;
    Label8: TLabel;
    edtSRC: TEdit;
    btnSRC: TButton;
    SaveDialog1: TSaveDialog;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    cbCertificateLocation: TComboBox;
    edtCertificateFileName: TEdit;
    btnSelectCertificateFile: TButton;
    cbCertificate: TComboBox;
    edtCertificatePassword: TEdit;
    btnLoadCertificate: TButton;
    OpenDialog2: TOpenDialog;
    Label1: TLabel;
    edtDST: TEdit;
    btnDST: TButton;
    Bevel1: TBevel;
    lbExtractedCertificates: TListBox;
    OpenDialog3: TOpenDialog;
    Label2: TLabel;
    SaveDialog2: TSaveDialog;
    procedure btnSignClick(Sender: TObject);
    procedure btnVerifyFileClick(Sender: TObject);
    procedure btnSourceClick(Sender: TObject);
    procedure btnDestinationFileClick(Sender: TObject);
    procedure btnSRCClick(Sender: TObject);
    procedure btnSelectCertificateFileClick(Sender: TObject);
    procedure btnLoadCertificateClick(Sender: TObject);
    procedure cbCertificateLocationChange(Sender: TObject);
    procedure btnDSTClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}




procedure TForm1.btnDSTClick(Sender: TObject);
begin
  if SaveDialog2.Execute then
  begin
    edtDST.Text := SaveDialog2.FileName;
  end;
end;

procedure TForm1.btnDestinationFileClick(Sender: TObject);
begin
 if SaveDialog1.Execute then
 begin
   edtDestinationFile.Text := SaveDialog1.FileName;
 end;
end;

procedure TForm1.btnLoadCertificateClick(Sender: TObject);
var
 i: Integer;
 cert: TclCertificate;
begin
  clCertificateStore1.Close();
  cbCertificate.Clear();

  case cbCertificateLocation.ItemIndex of
    0: clCertificateStore1.ImportFromPFX(edtCertificateFileName.Text, edtCertificatePassword.Text);
    1: clCertificateStore1.Open('MY');
  end;

  for i := 0 to clCertificateStore1.Items.Count - 1 do
  begin
    cert := clCertificateStore1.Items[i];
    if (cert.FriendlyName <> '') then
    begin
      cbCertificate.Items.Add(cert.FriendlyName);
    end else
    begin
      cbCertificate.Items.Add(cert.IssuedTo);
    end;
  end;

  if (cbCertificate.Items.Count > 0) then
  begin
    cbCertificate.ItemIndex := 0;
  end;
end;

procedure TForm1.btnSelectCertificateFileClick(Sender: TObject);
begin
 if OpenDialog2.Execute then
 begin
    edtCertificateFileName.Text := OpenDialog2.FileName;
 end;
end;

procedure TForm1.btnSourceClick(Sender: TObject);
begin
  if OpenDialog1.Execute() then
  begin
    edtSourceFile.Text := OpenDialog1.FileName;
  end;
end;

procedure TForm1.btnSRCClick(Sender: TObject);
begin
  if OpenDialog3.Execute then
  begin
    edtSRC.Text := OpenDialog3.FileName;
  end;
end;

procedure TForm1.cbCertificateLocationChange(Sender: TObject);
begin
  edtCertificateFileName.Enabled := (cbCertificateLocation.ItemIndex = 0);
  btnSelectCertificateFile.Enabled := edtCertificateFileName.Enabled;
  edtCertificatePassword.Enabled := edtCertificateFileName.Enabled;
end;

procedure TForm1.btnSignClick(Sender: TObject);
var
  src, dst: TStream;
  cert: TclCertificate;
begin
  src := nil;
  dst := nil;
  if (cbCertificate.ItemIndex < 0) then Exit;
  try
    src := TFileStream.Create(edtSourceFile.Text, fmOpenRead or fmShareDenyWrite);
    dst := TFileStream.Create(edtDestinationFile.Text, fmCreate);

    cert := clCertificateStore1.Items[cbCertificate.ItemIndex];

    // Use the signature algorithm from the certificate itself
    // This ensures compatibility with the certificate's capabilities
    clEncryptor1.SignAlgorithm := cert.SignatureAlgorithm;

    // IANA recommended algorithm for P7M signatures (SHA-512)
    // clEncryptor1.SignAlgorithm := '1.2.840.113549.1.1.13'; // SHA-512

    // Alternative algorithm for better Windows compatibility (SHA-256)
    //clEncryptor1.SignAlgorithm := '1.2.840.113549.1.1.11'; // SHA-256

    // Another alternative for maximum compatibility (SHA-1) - less secure
    // clEncryptor1.SignAlgorithm := '1.2.840.113549.1.1.5'; // SHA-1

    clEncryptor1.Sign(src, dst, False, True, cert, nil);
  finally
    dst.Free();
    src.Free();
  end;
  ShowMessage('Done');
end;

procedure TForm1.btnVerifyFileClick(Sender: TObject);
var
  cert: TclCertificate;
  src, dst: TStream;
  i: Integer;
begin
  clEncryptor1.ExtractCertificates(edtSRC.Text);

  lbExtractedCertificates.Items.Clear();
  for i := 0 to clEncryptor1.ExtractedCertificates.Items.Count - 1 do
  begin
    cert := clEncryptor1.ExtractedCertificates.Items[i];
    if (cert.FriendlyName <> '') then
    begin
      lbExtractedCertificates.Items.Add(cert.FriendlyName);
    end else
    begin
      lbExtractedCertificates.Items.Add(cert.IssuedTo);
    end;
  end;

  cert := clEncryptor1.ExtractedCertificates.Items.GetTopInChain();

  if(cert <> nil) then
  begin
    ShowMessage('Signing certificate: ' + cert.IssuedTo);
  end;

  src := nil;
  dst := nil;
  try
    src := TFileStream.Create(edtSRC.Text, fmOpenRead);
    dst := TFileStream.Create(edtDST.Text, fmCreate);

    clEncryptor1.IsExtractCertificates := False;
    clEncryptor1.VerifyEnveloped(src, dst, cert);
  finally
    dst.Free();
    src.Free();
  end;

 end;


end.
