unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, clCryptSignature, clUtils, clEncoder, clCryptEncoder;

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
function Rsa2X509Convert(const ARsaPublicKey: string): string;
var
  rsaKey: TclRsaKey;
  key: TclByteArray;
begin
  rsaKey := TclCryptApiRsaKey.Create();
  try
    rsaKey.Init();

    key := TclEncoder.DecodeToBytes(ARsaPublicKey, cmBase64);

    rsaKey.SetRsaPublicKey(key);
    key := rsaKey.GetPublicKeyInfo();

    Result := TclEncoder.Encode(key, cmBase64);
  finally
    rsaKey.Free();
  end;
end;

//converts from RSA Public Key PEM format to X509 Subject Key Info PEM format
function Rsa2X509PemConvert(const ARsaPublicKey: string): string;
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

    Result := encoder.Encode(key);
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

  x509KeyInfo := Rsa2X509Convert(RsaKey);

  memX509SubjectKeyInfo.Lines.Text := x509KeyInfo;
end;

procedure TForm1.btnConverRsaPemKeyClick(Sender: TObject);
var
  RsaKeyPem, x509KeyInfo: string;
begin
  RsaKeyPem := memRsaPublicPemKey.Lines.Text;

  x509KeyInfo := Rsa2X509PemConvert(RsaKeyPem);

  memX509SubjectKeyInfo.Lines.Text := x509KeyInfo;
end;

end.
