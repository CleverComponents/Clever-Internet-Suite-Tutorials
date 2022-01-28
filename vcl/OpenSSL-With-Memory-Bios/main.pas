unit main;

interface

//enable it if you want to capture the produced TLS packets during the handshake
//see more https://github.com/CleverComponents/Clever-Internet-Suite-Tutorials/tree/master/vcl/SilentSocketReceiver
{.$DEFINE SENDPACKETS}

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, clOpenSSL, clOpenSslSession
  {$IFDEF SENDPACKETS},clSocket{$ENDIF}
  ;

type
  TMainForm = class(TForm)
    btnLibInit: TButton;
    btnTransferData: TButton;
    memLog: TMemo;
    procedure btnLibInitClick(Sender: TObject);
    procedure btnTransferDataClick(Sender: TObject);
  private
    FAcceptCert: Boolean;
    FFatalError: Boolean;

    function GetOpenSslError: Exception;
    procedure SetCertificate(AContext: PSSL_CTX; const ACertificate: string);
    procedure SetPrivateKey(AContext: PSSL_CTX; const APrivateKey: string);
    procedure Connect(c_ssl, s_ssl: PSSL; c_in_bio, c_out_bio, s_in_bio, s_out_bio: PBIO);
    function GetCertificateInfo(crt: PX509): string;
    function TransferData(src_ssl, dst_ssl: PSSL; src_out_bio,
      dst_in_bio: PBIO; const src_buf: TBytes): TBytes;
    procedure Disconnect(src_ssl, dst_ssl: PSSL; src_in_bio, src_out_bio,
      dst_in_bio, dst_out_bio: PBIO);
    procedure CheckFatalError(errno: Integer);
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

//https://opensource.com/article/19/6/cryptography-basics-openssl-part-1
//https://www.roxlu.com/2014/042/using-openssl-with-memory-bios

//load weak certificates https://github.com/adrienverge/openfortivpn/issues/682
//https://cpp.hotexamples.com/ru/examples/-/-/PEM_read_bio_X509_AUX/cpp-pem_read_bio_x509_aux-function-examples.html
//https://cpp.hotexamples.com/examples/-/-/BIO_s_mem/cpp-bio_s_mem-function-examples.html

//https://www.openssl.org/docs/man3.0/man3/SSL_CTX_set_verify.html

const
  SERVER_CERT_SHA1: string =
    '-----BEGIN CERTIFICATE-----'#13#10 +
    'MIIEFzCCAv+gAwIBAgIUAoPdp25aKqtcwMmy8eaoMTKshcUwDQYJKoZIhvcNAQEF'#13#10 +
    'BQAwgZoxCzAJBgNVBAYTAlJVMQ0wCwYDVQQIDARUdWxhMQ0wCwYDVQQHDARUdWxh'#13#10 +
    'MRowGAYDVQQKDBFDbGV2ZXIgQ29tcG9uZW50czEQMA4GA1UECwwHVGVzdGluZzEV'#13#10 +
    'MBMGA1UEAwwMQ2xldmVyVGVzdGVyMSgwJgYJKoZIhvcNAQkBFhlDbGV2ZXJUZXN0'#13#10 +
    'ZXJAY29tcGFueS5tYWlsMB4XDTIyMDEyNDE4MDUxM1oXDTIzMDEyNDE4MDUxM1ow'#13#10 +
    'gZoxCzAJBgNVBAYTAlJVMQ0wCwYDVQQIDARUdWxhMQ0wCwYDVQQHDARUdWxhMRow'#13#10 +
    'GAYDVQQKDBFDbGV2ZXIgQ29tcG9uZW50czEQMA4GA1UECwwHVGVzdGluZzEVMBMG'#13#10 +
    'A1UEAwwMQ2xldmVyVGVzdGVyMSgwJgYJKoZIhvcNAQkBFhlDbGV2ZXJUZXN0ZXJA'#13#10 +
    'Y29tcGFueS5tYWlsMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA34gN'#13#10 +
    'uQ4pxsCUah6WxWuYMZUyR8+TwMtDxGxF0dDZAoayCoZHt7osV/GLockGM+ch/1Xt'#13#10 +
    'R0hu+aT1qRuo8x8lnpSIripOAlCm7XvbmSiVS2vakJ/mYobUo1z/fH0dxAZ1Lmp6'#13#10 +
    'Rhp+dbzFcWlNIAWxvQETH3qC9r7YQRWNeDRj9SiGoR99uZc20gtd0SPU9o6l4hqm'#13#10 +
    'hCsmMTZ9LbqjTzMppF/ght/9krvKhf0vIf/DdbLQyuDjfI936Kl028TD+gtb/Y8/'#13#10 +
    'EGKEqoIM1oRxf00Fhpb2XwbdMOemttiB9kuvhGFUgWvpWPXsZK1pIewLxfVpGDHM'#13#10 +
    'Kyi+cq4KjTue1enKewIDAQABo1MwUTAdBgNVHQ4EFgQUnXxjzil3qnr0US2ZPhjy'#13#10 +
    'sXxD6w8wHwYDVR0jBBgwFoAUnXxjzil3qnr0US2ZPhjysXxD6w8wDwYDVR0TAQH/'#13#10 +
    'BAUwAwEB/zANBgkqhkiG9w0BAQUFAAOCAQEA2JlJlYm7RUYv4ei+lekOooSmHnUZ'#13#10 +
    'NgoIB9seKtWCMhRakAKPtDTYRSgt9AsVjJKWOl8vapBOmhLYh7G13QJWFOD68Wuz'#13#10 +
    'bzv06mtfhFPI5YvVePEJjv5AFzD7OmPK0bzD43nWD0W/fgBeMk76qMTJztH24s8k'#13#10 +
    'k8ol8i98VPoCDhAZnAVrpje688jPEYEeYa/XLv9RUo2qpyifU6JEDDrm3FQTk4Ms'#13#10 +
    'QJ2u+V+SH2SfPL61Ku/Oc4W34pzhdkeU8asN2lRfgo2UCJiKcoRBPil7oY8j3HfW'#13#10 +
    'KTspoAWjJWg/wDA3LNZKdkUyJzaimLTTec4Cn7BFzFcqJaW33bNHidVYzQ=='#13#10 +
    '-----END CERTIFICATE-----'#13#10;

  SERVER_PKEY_SHA1: string =
    '-----BEGIN PRIVATE KEY-----'#13#10 +
    'MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDfiA25DinGwJRq'#13#10 +
    'HpbFa5gxlTJHz5PAy0PEbEXR0NkChrIKhke3uixX8YuhyQYz5yH/Ve1HSG75pPWp'#13#10 +
    'G6jzHyWelIiuKk4CUKbte9uZKJVLa9qQn+ZihtSjXP98fR3EBnUuanpGGn51vMVx'#13#10 +
    'aU0gBbG9ARMfeoL2vthBFY14NGP1KIahH325lzbSC13RI9T2jqXiGqaEKyYxNn0t'#13#10 +
    'uqNPMymkX+CG3/2Su8qF/S8h/8N1stDK4ON8j3foqXTbxMP6C1v9jz8QYoSqggzW'#13#10 +
    'hHF/TQWGlvZfBt0w56a22IH2S6+EYVSBa+lY9exkrWkh7AvF9WkYMcwrKL5yrgqN'#13#10 +
    'O57V6cp7AgMBAAECggEAQdKcC+LOTX8XFRq11iOlWPBwsnG/NhYE+hnSA4Nm69YD'#13#10 +
    'JpM9Gi6h8TGpJvZ9s5n7ymcgrI15VF0NlAMXoKQK3WQqzXKarxbV2PfQhgzLzb5Q'#13#10 +
    'Sac0Xc4LXqG7gAqN0dP+/LCRGgSiOYRhddCGzAexO5FN8saOOx+eqaexlXSD/MQp'#13#10 +
    '4Z5RMyYQCLnU6FaeFwkedWN5uUJJckoHLMkoU34fwpXbwWyi7U45Vbsa3HGZpEeS'#13#10 +
    '5IErtRR3rg9y0iIt7vvL1RFGOHWI1Ou3x5SLdUSbPuxkzKfCdmyZd6rG9Hu8x65F'#13#10 +
    'g9Rtoxd0EueKTOR2zspCsWMGaiQhbkMAV6vErSH31QKBgQDw1B8t+BthohKA6jZD'#13#10 +
    '0Yt/fEZpaCHT1z5VBGObo9GCYUIzl3sb13vjEsbbu1zFHsp5qZyuxpTSbu/g0gUO'#13#10 +
    'aEdphuNkUL+TdDlRTV1RHWMYck/9A5BCewsmsi7J2UcVMrKQ9+udxRsDthxhJSfa'#13#10 +
    'EpmxxNdom7LK8d5nIEh7Wwpb7QKBgQDtnPpv+/eEC+YjHpvSFS1rfWiyErDdtyiF'#13#10 +
    'xuuh/TWAz1rZuLqyY3Anmf56TPtul4UYCFjFWiXaxmc1h0xQToVKgBn8U5gS+Qfx'#13#10 +
    'OReyzp8z3MKcMc89ypMBVn/3ESE2Z/RTCG5EpWx8jUaah6Fli2pk9aM7L3B913De'#13#10 +
    'rebX/RODBwKBgCJtoLt4oal2ewC0+ub9GN0zzfkZquRW/BE5XGgOpk/mSYmImU/k'#13#10 +
    'oVBYCde11FBV04pLBhwyRWpD88UHITPrEnJylyVrKcgRsHQABFwpQFZpWSgJj2EB'#13#10 +
    'qBlzFZ9DkZblNYPl/WgDmpYQPcRhhG33hMNWKZlJ0OiUZUAG7HW+ESANAoGBAINn'#13#10 +
    'Y6wYaOpydiQH4l5M7eBa61JHOd5zUwqgVmEwGa2RfomXOlA646RS6kOSXR3s12LS'#13#10 +
    'At2pG/Qf8qXMm+xxcA8iRryfMiOT6suBKlTtJWfV9x3QAe8HH0MHJh9pLrfax2g/'#13#10 +
    '6lM2NIewzVHaHex9LCqHGW06r/g386iB/X6G64pzAoGBAJjctpfUfh4KgNpKW4qm'#13#10 +
    'WjW3ty6P9nNTdaRf8G0YszONzNs8od2yetcvE1cyE0jeaR9PyfQJFEeaEMykxOZ9'#13#10 +
    'XtzwcHumLbgM79nSNt2QhsY/qWni1iUe3HEBp2lqlZz8ARTn2Upct6BEsdRIZ8VX'#13#10 +
    'gakHQJhkDJcs4j9/R7VZgPcm'#13#10 +
    '-----END PRIVATE KEY-----'#13#10;

  SERVER_CERT_SHA256: string =
    '-----BEGIN CERTIFICATE-----'#13#10 +
    'MIIEFzCCAv+gAwIBAgIUSrNJhP/g4w5PFWj5I2qrZUE8pcAwDQYJKoZIhvcNAQEL'#13#10 +
    'BQAwgZoxCzAJBgNVBAYTAlJVMQ0wCwYDVQQIDARUdWxhMQ0wCwYDVQQHDARUdWxh'#13#10 +
    'MRowGAYDVQQKDBFDbGV2ZXIgQ29tcG9uZW50czEQMA4GA1UECwwHVGVzdGluZzEV'#13#10 +
    'MBMGA1UEAwwMQ2xldmVyVGVzdGVyMSgwJgYJKoZIhvcNAQkBFhlDbGV2ZXJUZXN0'#13#10 +
    'ZXJAY29tcGFueS5tYWlsMB4XDTIyMDExOTE3MjM0MloXDTIzMDExOTE3MjM0Mlow'#13#10 +
    'gZoxCzAJBgNVBAYTAlJVMQ0wCwYDVQQIDARUdWxhMQ0wCwYDVQQHDARUdWxhMRow'#13#10 +
    'GAYDVQQKDBFDbGV2ZXIgQ29tcG9uZW50czEQMA4GA1UECwwHVGVzdGluZzEVMBMG'#13#10 +
    'A1UEAwwMQ2xldmVyVGVzdGVyMSgwJgYJKoZIhvcNAQkBFhlDbGV2ZXJUZXN0ZXJA'#13#10 +
    'Y29tcGFueS5tYWlsMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAncL+'#13#10 +
    'CpTrdJlHSM6mdGCjEwXvOiXHcVwasKdJrFT7NBsf3HJEGz/BWXh8071TgEJ6YACO'#13#10 +
    'v7fks7w+eEytQ4wZupXHRExRbR0Lc3w+SEaEEgh1KwdIZZzYd6AKqz5NE9gKXjNq'#13#10 +
    'aWdMwDXtyVS/d9fNP22lJjmhRJdQ2GbNJ+qeMGJStu8Vt/gCGekeCaafAX+ANCbd'#13#10 +
    'yRT3hzJ/MR7Xdvn3a2RKsvA8cXwIalPj/H8FOKBmNKYWUIPaT/9rjKJTFhW8j1uW'#13#10 +
    'u1w1msqs+9nDcpQt/C5LyyKDvSyFFSripL9mh3nl4Q/8rPHLBaAXz3k+PFBsJOGu'#13#10 +
    'BEqE+ZN2MtKANbhPRwIDAQABo1MwUTAdBgNVHQ4EFgQUFsH/CikSk4Y1D1s+LN3L'#13#10 +
    'yuN4re0wHwYDVR0jBBgwFoAUFsH/CikSk4Y1D1s+LN3LyuN4re0wDwYDVR0TAQH/'#13#10 +
    'BAUwAwEB/zANBgkqhkiG9w0BAQsFAAOCAQEAeTN57pDZU7fa6V/g5qhUXXEmUPz8'#13#10 +
    'RVesvtXVLz6uXRZ6QfjdmBM1CnG6p5rSj6tLOfuQnmRqlv23ZQDj+PkDf5ud7RK9'#13#10 +
    'FohrUOeiGWWfPVmCfG8yfsYVHza2IG0FEc5oLoJwjLjJRtG4gbXdM1solbM3p8IO'#13#10 +
    'r/NCpUVBk6pwGqXtzhCdND1cQTLyrWDM3IwSpHqq0A8h1s9SWOUcPNQVqIUYMGoz'#13#10 +
    'UnAzT8VeqJKa7wDyOuPgJz9YKVdRmgZ2f9bUsskH1aKYWct1eRvZmG64fY8isC6O'#13#10 +
    'diJ3U515M3SJb8gJK4IQ5nu3k+39tyVEXxUnGH2pWBP4A55TjuSBi+17tQ=='#13#10 +
    '-----END CERTIFICATE-----'#13#10;

  SERVER_PKEY_SHA256: string =
    '-----BEGIN PRIVATE KEY-----'#13#10 +
    'MIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCdwv4KlOt0mUdI'#13#10 +
    'zqZ0YKMTBe86JcdxXBqwp0msVPs0Gx/cckQbP8FZeHzTvVOAQnpgAI6/t+SzvD54'#13#10 +
    'TK1DjBm6lcdETFFtHQtzfD5IRoQSCHUrB0hlnNh3oAqrPk0T2ApeM2ppZ0zANe3J'#13#10 +
    'VL93180/baUmOaFEl1DYZs0n6p4wYlK27xW3+AIZ6R4Jpp8Bf4A0Jt3JFPeHMn8x'#13#10 +
    'Htd2+fdrZEqy8DxxfAhqU+P8fwU4oGY0phZQg9pP/2uMolMWFbyPW5a7XDWayqz7'#13#10 +
    '2cNylC38LkvLIoO9LIUVKuKkv2aHeeXhD/ys8csFoBfPeT48UGwk4a4ESoT5k3Yy'#13#10 +
    '0oA1uE9HAgMBAAECggEABBKwtF075vq+GGcdbQvBqhARKRMonwidt8nZ4RUglyvM'#13#10 +
    'GsjocTuoJkMyFdVhfoI43pmlFdYNlYZapoh0QLYxQ9vyFRVTVNnXHdgrU3peloiZ'#13#10 +
    'Xc8GU3lFLXF4VQt6ufRt8BiruqTsGlpKFVSWzOVJa0XNabs7KqYtdCjTSyCHjQAy'#13#10 +
    'eXbjgrfDovnlz1Ehh2UYFa3AZbLCa7NgHrkZDRzO/LMWeIhI98jtfkXA+xcA7FIm'#13#10 +
    'abQoKFNKxkcR7ph0gPjPZr/ALd3PXk9thoGxgP0x45smedqZQMEkbuvPgS3Y4Pju'#13#10 +
    'VqcNB5DyH8ap5NmkI7nddCEqAwRznt+t8ex6Q38BYQKBgQDFBTWOo/LK8Bb6Yl/M'#13#10 +
    'bb+kLIlJ/83GZn5ySXh8DIqLODnqehNwxAh37isEfugfezPMdO5A4aRABYCaTGTV'#13#10 +
    'ktYCOCCf8bTlO9ET+OHfF+eOxV/WJcDEcCSwXgIfa/N7lcpZEaJgsPF+Z/qqAoWh'#13#10 +
    'GOnzXhHCyBymyi4WVBgY5M3vxQKBgQDM/SsobH1LU1j669MZ6UqHfL8nidwNp2Qw'#13#10 +
    '5kFSm8fEVL4roIpC5DznJlXFVtvja9zBG+zPTuGN8xE+ilGZItK8ORk8JCH7n+nj'#13#10 +
    'KJvmXoCcrA7mqqqBqxRcRVg02ZNSnK8Mkhe4CGlZNz+AoqhrThD1wF02QKXnXX9G'#13#10 +
    'NYKyXW7HmwKBgFqEoCyeyofOcuAqnlTv/2JQS+tBqasDoAimFML5iBWaiZFe8NuY'#13#10 +
    'VUO0mvL/02nTUuMWvff1M19up708Z/9v7P8sBmE1zaScLNz+NdgnxW1k5TkgM0aN'#13#10 +
    'N24IYvVIxZ78HPF7Fp1R7kHjR9kgO4DeT25Ow943zmIa9b2weTnGtY75AoGAWi25'#13#10 +
    '8cOgbyXQjDp4mPqPhgE0GtHEE+Gi6vwwmoXboRxiuNCcYocD3/B2ZSUsAOVvrSh6'#13#10 +
    'ykx6X7chy/CPqx2ttY4s8s82f/q+qucvhm3miIYM3B8SeY7omxsKjd11uS8itxYC'#13#10 +
    'Bzz0E4KBljZ4fxRN0773gql4EsuH9TwPLiZ6WKcCgYBKgc4TKi2bevPAzhWvn0QG'#13#10 +
    'W79+rCJ1kfGz2AKdzAgwH7w9EN6zi37/1h3JMp2szQ7gDOnqOPlrnhggItonZDkR'#13#10 +
    'mozDFt/lvtRUKtQdGKGpoXsT64o+4hMLa+FOx8h19525hKNuSWW0klHAbUatHmDw'#13#10 +
    'pnmvHPPZZWH+u8bKDc5Www=='#13#10 +
    '-----END PRIVATE KEY-----'#13#10;

  SERVER_CERT_WEAK: string =
    '-----BEGIN CERTIFICATE-----'#13#10 +
    'MIIDRDCCAiwCAf8wDQYJKoZIhvcNAQEFBQAwaDELMAkGA1UEBhMCVVMxCzAJBgNV'#13#10 +
    'BAgMAkNBMQswCQYDVQQHDAJMQTEVMBMGA1UECgwMVGVzdCBSb290IENBMQswCQYD'#13#10 +
    'VQQLDAJJVDEbMBkGA1UEAwwSd3d3LnRlc3Ryb290Y2EuY29tMB4XDTEzMDIyNzE4'#13#10 +
    'MjE1NloXDTIzMDIyNTE4MjE1NlowaDELMAkGA1UEBhMCVVMxCzAJBgNVBAgMAkNB'#13#10 +
    'MQswCQYDVQQHDAJMQTEVMBMGA1UECgwMVGVzdCBDb21wYW55MQswCQYDVQQLDAJJ'#13#10 +
    'VDEbMBkGA1UEAwwSd3d3LnRlc3RzZXJ2ZXIuY29tMIIBIjANBgkqhkiG9w0BAQEF'#13#10 +
    'AAOCAQ8AMIIBCgKCAQEAzkHv+S30g5Dc+F1RJ1PUq9Hbh1YkEUJdYEj7ti+UfONV'#13#10 +
    'NOT24hXzg8zaNSVO2Bhm+l8vzOVYMnjK9xcGSq5R5I633+lEeFdxURfsSJv9Vymq'#13#10 +
    'tHUj5eNkmjzWBVrf4HvnZTJtRJljs941zYUgyJT9tkQXaerGFKJ6sfdXYfhGrkuK'#13#10 +
    'gA1e71TwpRFYcfyYbQ3htENTh2CFBv7l5gjrITcmEJwpcU3U4nx4ZTr0IPLmV2kr'#13#10 +
    'K8IJysY4dqgRcmduEI5ZgbYGkdG8L7QjggFXA6QNDPu8DfmXeeqS0gIffEm22bk7'#13#10 +
    'b2fMnPfnFsJLsDdyhgrdYktnWhtZNij0y80tV4YCTwIDAQABMA0GCSqGSIb3DQEB'#13#10 +
    'BQUAA4IBAQDMLn9VnUQt6BWx73J1lExYO/LWulMOnMR/WSVFy9dSwry+E807ekMY'#13#10 +
    'WC8b3gpgDIqfkZjmttE9VtAdss2Baten+oBW+K13339sxHvcn30OxOs/Bln0yvaZ'#13#10 +
    'Be+Zir7iE450b1IdYI98PMTSKgrK2e3vx/uUOCgG2yvs6/1v5rz5er/M1SQNzdMS'#13#10 +
    'blelHWRQ1/ExwoUWBfIBkx/A4lTPmLgoC9fnXSiLhHKbZdfCJD8KLzEV0Se+ocn/'#13#10 +
    'vl+6tlcUznap0TsRQpC67T/NGUimxdAhb6G1/U6z9bq0QQIuDxpOIpvwIgLvfRFx'#13#10 +
    'qZQxmxOcK28fejHngmek7ZJNYKQbNewP'#13#10 +
    '-----END CERTIFICATE-----'#13#10;

  SERVER_PKEY_WEAK: string =
    '-----BEGIN PRIVATE KEY-----'#13#10 +
    'MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDOQe/5LfSDkNz4'#13#10 +
    'XVEnU9Sr0duHViQRQl1gSPu2L5R841U05PbiFfODzNo1JU7YGGb6Xy/M5VgyeMr3'#13#10 +
    'FwZKrlHkjrff6UR4V3FRF+xIm/1XKaq0dSPl42SaPNYFWt/ge+dlMm1EmWOz3jXN'#13#10 +
    'hSDIlP22RBdp6sYUonqx91dh+EauS4qADV7vVPClEVhx/JhtDeG0Q1OHYIUG/uXm'#13#10 +
    'COshNyYQnClxTdTifHhlOvQg8uZXaSsrwgnKxjh2qBFyZ24QjlmBtgaR0bwvtCOC'#13#10 +
    'AVcDpA0M+7wN+Zd56pLSAh98SbbZuTtvZ8yc9+cWwkuwN3KGCt1iS2daG1k2KPTL'#13#10 +
    'zS1XhgJPAgMBAAECggEAIT83s27Y7yw2skI4hqJYsamOPW6BOdb8vjyFdoSM5uSu'#13#10 +
    'I2yU7zSioCgxNEfjQaoNT2ZwihKd+OTHsrSfawJWaQUoVot/YfaWaX/1sm6Sk64/'#13#10 +
    'uf733mKdIM+VoB9Z3xGZ5xIN0vT2wVOcUJiZBDwf+XVYYNZbP5BBPtaj20LuAcIZ'#13#10 +
    'OmW9uigdXQkQ1dylUkRPitjJ92bbysrTr621JTBSmvKnF7ctcF/Ql6VfS5RcqzYI'#13#10 +
    '6U1vozoFkjmUnExlYZHC6qKCFG73Z+IcC7ojdMpzMp4/EqiveV/9EVdFlLRB1YAa'#13#10 +
    'tND93xU9mo7L26XQzy79Xf2dWRUgUvaJ/7EvLA1RoQKBgQD2ZhJ9ogqfQ0ahq0D6'#13#10 +
    '5neZo6bPbckEKshv1GKR5ixnYpPp1kCIxM8oIzb9fOvTX4MOMeRzPJyrJNwhVgfY'#13#10 +
    'otWLrvkNviGHXN0frmkdj/Y/WSWh7clzzwXmGbB/8NPG4yzREvQ8vhKBkAmZln6K'#13#10 +
    'ICl8J5NxOxF6GgYJ793GcsfZVQKBgQDWS3DYMVQ3eRgFajkQ/8+Gacgdu+8/SyM1'#13#10 +
    'WptHOlPvKfqg3nZYPlAjMnVmk0Q7l/d2EtFBPP07/Jz0IvC/pMz0S8XfW/NigcRn'#13#10 +
    '0R5Nci3BXbmQEjxNGt0m0sX4C4/Bx8ei8pugipX96OemT/bWP05RskL6tWsofGsb'#13#10 +
    '8zgIQcldEwKBgCyx90iyzBp3qahJ2E+q3qcP+IJH9965pAIlFHxCtGtMhmg0ZSBq'#13#10 +
    'EunE+YSh1GVTPgKlKjt9Ey44UXX6lRHG99WOt762bn6Pac0FZivmoVR8Z0coSxKm'#13#10 +
    'yvsiTdHnbYL2UnraZVNfZxv5dMRXeDy1+NB8nVI81L7BWbcTu7bzuyzBAoGAY0j4'#13#10 +
    's3HHbxwvwPKCFhovcDs6eGxGYLDTUzjzkIC5uqlccYQgmKnmPyh1tFyu1F2ITbBS'#13#10 +
    'O0OioFRd887sdB5KxzUELIRRs2YkNWVyALfR8zEVdGa+gYrcw8wL5OyWYlXJbPmy'#13#10 +
    'mSMcc1OhYDDUUFdsVfWdisLbLxrWFVEOuOSiAvkCgYEA2viHsxoFxOrhnZQOhaLT'#13#10 +
    'RPrgaSojv9pooHQ6fJwplewt91tb1OchDIeZk9Sl1hqPAXB0167of43GDOw2vfnq'#13#10 +
    'Ust7RtiyJhQhSkz0qp4aH4P9l+dZJIWnpgjcyWkcz893br9gEuVnQgh13V/lcxOn'#13#10 +
    'JtpaCFuHNTU3PcFiuQW+cN0='#13#10 +
    '-----END PRIVATE KEY-----'#13#10;

procedure TMainForm.btnLibInitClick(Sender: TObject);
var
  res: Integer;
begin
  //starting from v 1.1.0, the library doesn't need to be explicitly initialized
  //use btnTransferDataClick after start instead

  res := OPENSSL_init_ssl(0, nil);
  Assert(1 = res);
  res := OPENSSL_init_crypto(0, nil);
  Assert(1 = res);

  //if you call it, all subsequent operations will fail
  OPENSSL_cleanup();

  res := OPENSSL_init_crypto(0, nil);
  Assert(0 = res);

  ShowMessage('Done - restart the app, see the comments in btnLibInitClick');
end;

function TMainForm.GetOpenSslError: Exception;
var
  last, err: Cardinal;
  msg: string;
  buf: PAnsiChar;
begin
  msg := '';
  err := ERR_get_error();
  last := err;

  GetMem(buf, 1024);
  try
    while (err > 0) do
    begin
      ERR_error_string_n(err, buf, 1024);

      if (msg <> '') then
      begin
        msg := msg + '; ';
      end;

      msg := msg + string(AnsiString(buf));
      err := ERR_get_error();
    end;
  finally
    FreeMem(buf);
  end;

  Result := Exception.Create(IntToStr(last) + ' ' + msg);
end;

procedure TMainForm.SetCertificate(AContext: PSSL_CTX; const ACertificate: string);
var
  bio_cert: PBIO;
  ssl_cert: PX509;
  buf: TBytes;
begin
  buf := TEncoding.ANSI.GetBytes(ACertificate);

  bio_cert := nil;
  ssl_cert := nil;
  try
    bio_cert := BIO_new_mem_buf(@buf[0], Length(buf));
    if (bio_cert = nil) then
    begin
      raise GetOpenSslError();
    end;

    ssl_cert := PEM_read_bio_X509_AUX(bio_cert, nil, nil, nil);
    if (ssl_cert = nil) then
    begin
      raise GetOpenSslError();
    end;

    if (SSL_CTX_use_certificate(AContext, ssl_cert) <> 1) then
    begin
      raise GetOpenSslError();
    end;
  finally
    X509_free(ssl_cert);
    BIO_free(bio_cert);
  end;
end;

procedure TMainForm.SetPrivateKey(AContext: PSSL_CTX; const APrivateKey: string);
var
  bio_pkey: PBIO;
  ssl_pkey: PEVP_PKEY;
  buf: TBytes;
begin
  buf := TEncoding.ANSI.GetBytes(APrivateKey);

  bio_pkey := nil;
  ssl_pkey := nil;
  try
    bio_pkey := BIO_new_mem_buf(@buf[0], Length(buf));
    if (bio_pkey = nil) then
    begin
      raise GetOpenSslError();
    end;

    ssl_pkey := PEM_read_bio_PrivateKey(bio_pkey, nil, nil, nil);
    if (ssl_pkey = nil) then
    begin
      raise GetOpenSslError();
    end;

    if (SSL_CTX_use_PrivateKey(AContext, ssl_pkey) <> 1) then
    begin
      raise GetOpenSslError();
    end;

    if (SSL_CTX_check_private_key(AContext) <> 1) then
    begin
      raise GetOpenSslError();
    end;
  finally
    EVP_PKEY_free(ssl_pkey);
    BIO_free(bio_pkey);
  end;
end;

procedure TMainForm.Connect(c_ssl, s_ssl: PSSL; c_in_bio, c_out_bio, s_in_bio, s_out_bio: PBIO);
var
  res: Integer;
  buf: TBytes;
  c_ready, s_ready: Boolean;
{$IFDEF SENDPACKETS}
  con: TclTcpClientConnection;
{$ENDIF}
begin
{$IFDEF SENDPACKETS}
  StartupSocket();
  con := TclTcpClientConnection.Create();
  try
    con.NetworkStream := TclNetworkStream.Create();
    con.TimeOut := -1;
    con.Open(TclHostResolver.GetIPAddress('localhost'), 2110);
{$ENDIF}

    SetLength(buf, 8192);

    SSL_set_connect_state(c_ssl);
    SSL_set_accept_state(s_ssl);

    c_ready := False;
    s_ready := False;

    repeat
      if (not c_ready) then
      begin
        res := SSL_do_handshake(c_ssl);
        if (res <> 1) then
        begin
          res := SSL_get_error(c_ssl, res);
          CheckFatalError(res);
          if (res = SSL_ERROR_WANT_READ) then
          begin
            res := BIO_read(c_out_bio, @buf[0], Length(buf));
            while (res > 0) do
            begin
              {$IFDEF SENDPACKETS}con.WriteBytes(buf, 0, res);{$ENDIF}
              Assert(res = BIO_write(s_in_bio, @buf[0], res));
              res := BIO_read(c_out_bio, @buf[0], Length(buf));
            end;
          end else
          if (res = SSL_ERROR_WANT_WRITE) then
          begin
            Assert(False);
          end else
          begin
            raise GetOpenSslError();
          end;
        end else
        begin
          res := BIO_read(c_out_bio, @buf[0], Length(buf));
          while (res > 0) do
          begin
            {$IFDEF SENDPACKETS}con.WriteBytes(buf, 0, res);{$ENDIF}
            Assert(res = BIO_write(s_in_bio, @buf[0], res));
            res := BIO_read(c_out_bio, @buf[0], Length(buf));
          end;

          c_ready := True;
        end;
      end;

      if (not s_ready) then
      begin
        res := SSL_do_handshake(s_ssl);
        if (res <> 1) then
        begin
          res := SSL_get_error(s_ssl, res);
          CheckFatalError(res);
          if (res = SSL_ERROR_WANT_READ) then
          begin
            res := BIO_read(s_out_bio, @buf[0], Length(buf));
            while (res > 0) do
            begin
              {$IFDEF SENDPACKETS}con.WriteBytes(buf, 0, res);{$ENDIF}
              Assert(res = BIO_write(c_in_bio, @buf[0], res));
              res := BIO_read(s_out_bio, @buf[0], Length(buf));
            end;
          end else
          if (res = SSL_ERROR_WANT_WRITE) then
          begin
            Assert(False);
          end else
          begin
            raise GetOpenSslError();
          end;
        end else
        begin
          res := BIO_read(s_out_bio, @buf[0], Length(buf));
          while (res > 0) do
          begin
            {$IFDEF SENDPACKETS}con.WriteBytes(buf, 0, res);{$ENDIF}
            Assert(res = BIO_write(c_in_bio, @buf[0], res));
            res := BIO_read(s_out_bio, @buf[0], Length(buf));
          end;

          s_ready := True;
        end;
      end;

    until c_ready and s_ready;

{$IFDEF SENDPACKETS}
  finally
    con.Free();
    CleanupSocket();
  end;
{$ENDIF}
end;

procedure TMainForm.CheckFatalError(errno: Integer);
begin
  FFatalError := FFatalError or (errno = SSL_ERROR_SSL) or (errno = SSL_ERROR_SYSCALL);
end;

procedure TMainForm.Disconnect(src_ssl, dst_ssl: PSSL;
  src_in_bio, src_out_bio, dst_in_bio, dst_out_bio: PBIO);
var
  res: Integer;
  buf: TBytes;
  src_ready, dst_ready: Boolean;
begin
  if FFatalError then Exit;

  SetLength(buf, 8192);

  src_ready := False;
  dst_ready := False;

  repeat
    if not src_ready then
    begin
      res := SSL_shutdown(src_ssl);
      if (res = 0) then
      begin
        res := BIO_read(src_out_bio, @buf[0], Length(buf));
        while (res > 0) do
        begin
          Assert(res = BIO_write(dst_in_bio, @buf[0], res));
          res := BIO_read(src_out_bio, @buf[0], Length(buf));
        end;
      end else
      if (res < 0) then
      begin
        //use SSL_read to read pending data, received from peer
        res := SSL_get_error(src_ssl, res);
        if (res = SSL_ERROR_WANT_READ) then
        begin
          Assert(False);
        end else
        if (res = SSL_ERROR_WANT_WRITE) then
        begin
          Assert(False);
        end else
        begin
          raise GetOpenSslError();
        end;
      end else
      begin
        src_ready := True;
      end;
    end;

    if not dst_ready then
    begin
      res := SSL_read(dst_ssl, @buf[0], Length(buf));
      if (res < 1) then
      begin
        res := SSL_get_error(dst_ssl, res);
        if (res = SSL_ERROR_ZERO_RETURN) then
        begin
          res := SSL_shutdown(dst_ssl);
          if (res = 1) then
          begin
            res := BIO_read(dst_out_bio, @buf[0], Length(buf));
            while (res > 0) do
            begin
              Assert(res = BIO_write(src_in_bio, @buf[0], res));
              res := BIO_read(dst_out_bio, @buf[0], Length(buf));
            end;

            dst_ready := True;
          end else
          if (res < 0) then
          begin
            //use SSL_read to read pending data, received from peer
            res := SSL_get_error(dst_ssl, res);
            if (res = SSL_ERROR_WANT_READ) then
            begin
              Assert(False);
            end else
            if (res = SSL_ERROR_WANT_WRITE) then
            begin
              Assert(False);
            end else
            begin
              raise GetOpenSslError();
            end;
          end else
          begin
            Assert(False);
          end;

        end else
        if (res = SSL_ERROR_WANT_READ) then
        begin
          Assert(False); //TODO renegotiation and shutdown handling
        end else
        if (res = SSL_ERROR_WANT_WRITE) then
        begin
          Assert(False); //TODO renegotiation and shutdown handling
        end else
        begin
          raise GetOpenSslError();
        end;
      end;
    end;

  until src_ready and dst_ready;
end;

function TMainForm.TransferData(src_ssl, dst_ssl: PSSL;
  src_out_bio, dst_in_bio: PBIO; const src_buf: TBytes): TBytes;
var
  res: Integer;
  buf: TBytes;
begin
  SetLength(buf, 8192);

  res := SSL_write(src_ssl, @src_buf[0], Length(src_buf));
  if (res < 1) then
  begin
    res := SSL_get_error(src_ssl, res);
    CheckFatalError(res);
    if (res = SSL_ERROR_WANT_READ) then
    begin
      Assert(False); //TODO renegotiation handling
    end else
    if (res = SSL_ERROR_WANT_WRITE) then
    begin
      Assert(False); //TODO renegotiation handling
    end else
    begin
      raise GetOpenSslError();
    end;
  end;

  res := BIO_read(src_out_bio, @buf[0], Length(buf));
  while (res > 0) do
  begin
    Assert(res = BIO_write(dst_in_bio, @buf[0], res));
    res := BIO_read(src_out_bio, @buf[0], Length(buf));
  end;

  SetLength(Result, Length(src_buf));

  res := SSL_read(dst_ssl, @Result[0], Length(Result));
  if (res < 1) then
  begin
    res := SSL_get_error(dst_ssl, res);
    CheckFatalError(res);
    if (res = SSL_ERROR_WANT_READ) then
    begin
      Assert(False); //TODO renegotiation and shutdown handling
    end else
    if (res = SSL_ERROR_WANT_WRITE) then
    begin
      Assert(False); //TODO renegotiation and shutdown handling
    end else
    begin
      raise GetOpenSslError();
    end;
  end;
  Assert(res = Length(Result));
end;

function TMainForm.GetCertificateInfo(crt: PX509): string;
var
  crt_subj: PX509_NAME;
  bio: PBIO;
  buf: TBytes;
  len: Integer;
begin
  Result := '';

  crt_subj := X509_get_subject_name(crt);

  bio := BIO_new(BIO_s_mem());
  if (bio = nil) then
  begin
    raise GetOpenSslError();
  end;
  try
    len := X509_NAME_print_ex(bio, crt_subj, 0,
      XN_FLAG_SEP_CPLUS_SPC or XN_FLAG_FN_SN or ASN1_STRFLGS_UTF8_CONVERT);
    if (len < 0) then
    begin
      raise GetOpenSslError();
    end;
    SetLength(buf, len);

    Assert(len = Integer(BIO_ctrl(bio, BIO_CTRL_PENDING, 0, nil)));

    Assert(len = BIO_read(bio, @buf[0], Length(buf)));

    Result := Result + TEncoding.UTF8.GetString(buf, 0, len) + #13#10;
  finally
    BIO_free(bio);
  end;

  //TODO X509_get_version
  //TODO X509_get_issuer_name
  //X509_get_serialNumber
  //X509_get0_notBefore
  //X509_get0_notAfter
  //X509_set_pubkey
  //X509_get_signature_type
  //fingerprint
  //get certificate chain
  //set trusted root
end;

function SSL_verify_callback(preverify_ok: Integer; x509_ctx: PX509_STORE_CTX): Integer; cdecl;
var
  ssl: PSSL;
  frm: TMainForm;
  ssl_idx: Integer;
  crt: PX509;
  crt_subj: PX509_NAME;
  crt_subj_str: array[0..2048] of AnsiChar;
  srt_info, err_info: string;
  err, err_depth: Integer;
begin
  ssl_idx := SSL_get_ex_data_X509_STORE_CTX_idx();
  ssl := PSSL(X509_STORE_CTX_get_ex_data(x509_ctx, ssl_idx));
  if (ssl = nil) then
  begin
    Result := preverify_ok;
    Exit;
  end;

  frm := TMainForm(SSL_get_ex_data(ssl, 0));

  err := X509_STORE_CTX_get_error(x509_ctx);
  err_depth := X509_STORE_CTX_get_error_depth(x509_ctx);
  frm.memLog.Lines.Add(Format('Certificate validation error: %d, depth: %d', [err, err_depth]));

  if (err <> X509_V_OK) then
  begin
    err_info := string(AnsiString(X509_verify_cert_error_string(err)));
    frm.memLog.Lines.Add(err_info);
  end;

  crt := X509_STORE_CTX_get_current_cert(x509_ctx);
  if (crt <> nil) then
  begin
    crt_subj := X509_get_subject_name(crt);
    X509_NAME_oneline(crt_subj, @crt_subj_str[0], Length(crt_subj_str));
    frm.memLog.Lines.Add('X509_NAME_oneline: ' + string(AnsiString(crt_subj_str)));

    srt_info := frm.GetCertificateInfo(crt);
    frm.memLog.Lines.Add('Certificate:');
    frm.memLog.Lines.Text := frm.memLog.Lines.Text + srt_info;
  end;

  if frm.FAcceptCert then
  begin
    Result := 1;
  end else
  begin
    Result := 0;
  end;
end;

procedure TMainForm.btnTransferDataClick(Sender: TObject);
var
  c_ctx, s_ctx: PSSL_CTX;
  c_ssl, s_ssl: PSSL;
  c_in_bio, c_out_bio, s_in_bio, s_out_bio: PBIO;
  ex: Exception;
  src_buf, dst_buf: TBytes;
  src_str, dst_str: string;
begin
//TODO OPENSSL_add_all_algorithms_noconf
//SSL_get1_supported_ciphers
//SSL_get_cipher_list
//SSL_get_sigalgs

  c_ctx := nil;
  s_ctx := nil;
  c_ssl := nil;
  s_ssl := nil;
  try
    c_ctx := SSL_CTX_new(nil);
    if (c_ctx = nil) then
    begin
      ex := GetOpenSslError();
      try
        Assert('' <> ex.Message);
      finally
        ex.Free();
      end;
    end;

    c_ctx := SSL_CTX_new(TLSv1_2_client_method());
    if (c_ctx = nil) then
    begin
      raise GetOpenSslError();
    end;

    s_ctx := SSL_CTX_new(TLS_server_method());
    if (s_ctx = nil) then
    begin
      raise GetOpenSslError();
    end;

    FAcceptCert := True;

    SSL_CTX_set_verify(c_ctx, SSL_VERIFY_PEER, @SSL_verify_callback);
    SSL_CTX_set_verify(s_ctx, SSL_VERIFY_NONE, nil);

//    SetCertificate(c_ctx, SERVER_CERT_SHA1); //test requesting a client's certificate
//    SetPrivateKey(c_ctx, SERVER_PKEY_SHA1);

    SetCertificate(s_ctx, SERVER_CERT_SHA256);
    SetPrivateKey(s_ctx, SERVER_PKEY_SHA256);

    c_ssl := SSL_new(c_ctx);
    if (c_ssl = nil) then
    begin
      raise GetOpenSslError();
    end;

    if SSL_set_ex_data(c_ssl, 0, Self) <> 1 then
    begin
      raise GetOpenSslError();
    end;

    Assert(SSL_get_ex_data(c_ssl, 0) = Self);

    s_ssl := SSL_new(s_ctx);
    if (s_ssl = nil) then
    begin
      raise GetOpenSslError();
    end;

    Assert(nil = SSL_get_rbio(c_ssl));
    Assert(nil = SSL_get_wbio(c_ssl));

    c_in_bio := BIO_new(BIO_s_mem());
    if (c_in_bio = nil) then
    begin
      raise GetOpenSslError();
    end;
    SSL_set0_rbio(c_ssl, c_in_bio);

    c_out_bio := BIO_new(BIO_s_mem());
    if (c_out_bio = nil) then
    begin
      raise GetOpenSslError();
    end;
    SSL_set0_wbio(c_ssl, c_out_bio);

    Assert(nil <> SSL_get_rbio(c_ssl));
    Assert(nil <> SSL_get_wbio(c_ssl));

    s_in_bio := BIO_new(BIO_s_mem());
    if (s_in_bio = nil) then
    begin
      raise GetOpenSslError();
    end;
    SSL_set0_rbio(s_ssl, s_in_bio);

    s_out_bio := BIO_new(BIO_s_mem());
    if (s_out_bio = nil) then
    begin
      raise GetOpenSslError();
    end;
    SSL_set0_wbio(s_ssl, s_out_bio);

    Connect(c_ssl, s_ssl, c_in_bio, c_out_bio, s_in_bio, s_out_bio);

    //TODO re-negotiation https://www.openssl.org/docs/man3.0/man3/SSL_renegotiate.html
    //https://www.openssl.org/docs/man3.0/man3/BIO_set_ssl_renegotiate_bytes.html

    src_str := 'This is a test data from client to server.';
    src_buf := TEncoding.UTF8.GetBytes(src_str);
    dst_buf := TransferData(c_ssl, s_ssl, c_out_bio, s_in_bio, src_buf);
    dst_str := TEncoding.UTF8.GetString(dst_buf);
    Assert(src_str = dst_str);
    memLog.Lines.Add('C->S, server received: ' + dst_str);

    src_str := 'This is a server reply.';
    src_buf := TEncoding.UTF8.GetBytes(src_str);
    dst_buf := TransferData(s_ssl, c_ssl, s_out_bio, c_in_bio, src_buf);
    dst_str := TEncoding.UTF8.GetString(dst_buf);
    Assert(src_str = dst_str);
    memLog.Lines.Add('S->C, client received: ' + dst_str);

    Disconnect(c_ssl, s_ssl, c_in_bio, c_out_bio, s_in_bio, s_out_bio);
  finally
    SSL_free(s_ssl);
    SSL_free(c_ssl);
    SSL_CTX_free(s_ctx);
    SSL_CTX_free(c_ctx);
  end;

  ShowMessage('Done');
end;

end.
