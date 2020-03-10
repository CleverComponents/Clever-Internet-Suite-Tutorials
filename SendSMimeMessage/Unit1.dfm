object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 352
  ClientWidth = 526
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 8
    Top = 8
    Width = 31
    Height = 13
    Caption = 'To List'
  end
  object Label3: TLabel
    Left = 8
    Top = 35
    Width = 36
    Height = 13
    Caption = 'Subject'
  end
  object Label7: TLabel
    Left = 270
    Top = 89
    Width = 46
    Height = 13
    Caption = 'Password'
  end
  object Label6: TLabel
    Left = 270
    Top = 62
    Width = 52
    Height = 13
    Caption = 'User Name'
  end
  object Port: TLabel
    Left = 272
    Top = 35
    Width = 20
    Height = 13
    Caption = 'Port'
  end
  object Server: TLabel
    Left = 272
    Top = 8
    Width = 32
    Height = 13
    Caption = 'Server'
  end
  object edtSubject: TEdit
    Left = 53
    Top = 32
    Width = 196
    Height = 21
    TabOrder = 0
    Text = 'ABC Company: New Catalog'
  end
  object edtToList: TEdit
    Left = 53
    Top = 5
    Width = 196
    Height = 21
    TabOrder = 1
  end
  object memMessage: TMemo
    Left = 8
    Top = 113
    Width = 510
    Height = 192
    Lines.Strings = (
      'Dear Mr.Howden send me pleace you catalog.')
    TabOrder = 2
  end
  object edtServer: TEdit
    Left = 352
    Top = 5
    Width = 166
    Height = 21
    TabOrder = 3
    Text = 'smtp.yandex.ru'
  end
  object edtPort: TEdit
    Left = 352
    Top = 32
    Width = 166
    Height = 21
    TabOrder = 4
    Text = '465'
  end
  object edtUserName: TEdit
    Left = 352
    Top = 59
    Width = 166
    Height = 21
    TabOrder = 5
  end
  object edtPassword: TEdit
    Left = 352
    Top = 86
    Width = 166
    Height = 21
    PasswordChar = '*'
    TabOrder = 6
    Text = 'warpten123'
  end
  object btnSend: TButton
    Left = 429
    Top = 311
    Width = 89
    Height = 33
    Caption = 'Send'
    TabOrder = 7
    OnClick = btnSendClick
  end
  object clSmtp1: TclSmtp
    MailAgent = 'Clever Internet Suite'
    Left = 224
    Top = 192
  end
  object clSMimeMessage1: TclSMimeMessage
    ToList = <>
    CCList = <>
    BCCList = <>
    Date = 43889.538586608800000000
    CharSet = 'iso-8859-1'
    ContentType = 'text/plain'
    Config.SignAlgorithmName = 'sha-512'
    Config.SignAlgorithm = '2.16.840.1.101.3.4.2.3'
    Config.EncryptAlgorithm = '2.16.840.1.101.3.4.1.2'
    OnGetSigningCertificate = clSMimeMessage1GetSigningCertificate
    OnGetEncryptionCertificate = clSMimeMessage1GetEncryptionCertificate
    Left = 296
    Top = 192
  end
  object CertificateSender: TclCertificateStore
    StoreName = 'MY'
    CSP = 'Microsoft Base Cryptographic Provider v1.0'
    ValidFrom = 43889.000000000000000000
    ValidTo = 44254.000000000000000000
    Left = 424
    Top = 168
  end
  object CertificateRecipient: TclCertificateStore
    StoreName = 'MY'
    CSP = 'Microsoft Base Cryptographic Provider v1.0'
    ValidFrom = 43889.000000000000000000
    ValidTo = 44254.000000000000000000
    Left = 424
    Top = 232
  end
end
