unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, clCryptSignature, clUtils, clEncoder, clCryptEncoder;

type
  TForm1 = class(TForm)
    btnConverRsaKey: TButton;
    Label2: TLabel;
    memRsaPublicKey: TMemo;
    Label3: TLabel;
    memX509SubjectKeyInfo: TMemo;
    btnConverRsaPemKey: TButton;
    Label1: TLabel;
    memRsaPublicPemKey: TMemo;
    cbUsePEMFormat: TCheckBox;
    procedure btnConverRsaKeyClick(Sender: TObject);
    procedure btnConverRsaPemKeyClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

//converts from RSA Public Key format to X509 Subject Key Info format
function Rsa2X509Convert(const ARsaPublicKey: string; AUsePemFormat: Boolean): string;
var
  rsaKey: TclRsaKey;
  key: TclByteArray;
  encoder: TclCryptEncoder;
begin
  encoder := TclCryptEncoder.Create(nil);
  rsaKey := TclCryptApiRsaKey.Create();
  try
    rsaKey.Init();

    key := TclEncoder.DecodeToBytes(ARsaPublicKey, cmBase64);

    rsaKey.SetRsaPublicKey(key);
    key := rsaKey.GetPublicKeyInfo();

    if AUsePemFormat then
    begin
      encoder.DataType := dtRsaPublicKey;
      Result := encoder.Encode(key);
    end else
    begin
      Result := TclEncoder.Encode(key, cmBase64);
    end;
  finally
    rsaKey.Free();
    encoder.Free();
  end;
end;

//converts from RSA Public Key PEM format to X509 Subject Key Info PEM format
function Rsa2X509PemConvert(const ARsaPublicKey: string; AUsePemFormat: Boolean): string;
var
  rsaKey: TclRsaKey;
  key: TclByteArray;
  encoder: TclCryptEncoder;
begin
  encoder := TclCryptEncoder.Create(nil);
  rsaKey := TclCryptApiRsaKey.Create();
  try
    rsaKey.Init();

    key := encoder.Decode(ARsaPublicKey);

    rsaKey.SetRsaPublicKey(key);
    key := rsaKey.GetPublicKeyInfo();

    if AUsePemFormat then
    begin
      Result := encoder.Encode(key);
    end else
    begin
      Result := TclEncoder.Encode(key, cmBase64);
    end;
  finally
    rsaKey.Free();
    encoder.Free();
  end;
end;

procedure TForm1.btnConverRsaKeyClick(Sender: TObject);
var
  RsaKey, x509KeyInfo: string;
begin
  RsaKey := memRsaPublicKey.Lines.Text;

  x509KeyInfo := Rsa2X509Convert(RsaKey, cbUsePEMFormat.Checked);

  memX509SubjectKeyInfo.Lines.Text := x509KeyInfo;
end;

procedure TForm1.btnConverRsaPemKeyClick(Sender: TObject);
var
  RsaKeyPem, x509KeyInfo: string;
begin
  RsaKeyPem := memRsaPublicPemKey.Lines.Text;

  x509KeyInfo := Rsa2X509PemConvert(RsaKeyPem, cbUsePEMFormat.Checked);

  memX509SubjectKeyInfo.Lines.Text := x509KeyInfo;
end;

end.
