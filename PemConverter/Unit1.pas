unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, clCryptSignature, clUtils, clEncoder, clCryptEncoder;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
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

procedure TForm1.Button1Click(Sender: TObject);
var
  RsaKeyPem, x509KeyInfo: string;
begin
  x509KeyInfo := Rsa2X509Convert(
'MEgCQQDCiZulctu+Tp2pZ7wfTyKhpSkYzqkRAwdmvNdvUVwgh8mwBAOdt9Mvhx+O' +
'VokrzfLIJqeBBkbwTzxfgVeU6CL3AgMBAAE=');
  ShowMessage(x509KeyInfo);

  RsaKeyPem :=
'-----BEGIN RSA PUBLIC KEY-----'#$D#$A +
'MEgCQQDCiZulctu+Tp2pZ7wfTyKhpSkYzqkRAwdmvNdvUVwgh8mwBAOdt9Mvhx+O'#$D#$A +
'VokrzfLIJqeBBkbwTzxfgVeU6CL3AgMBAAE='#$D#$A +
'-----END RSA PUBLIC KEY-----'#$D#$A;
  x509KeyInfo := Rsa2X509PemConvert(RsaKeyPem);
  ShowMessage(x509KeyInfo);
end;

end.
