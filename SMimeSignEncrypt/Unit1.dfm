object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 300
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object btnSendSigned: TButton
    Left = 80
    Top = 120
    Width = 75
    Height = 25
    Caption = 'Send Signed'
    TabOrder = 0
    OnClick = btnSendSignedClick
  end
  object btnSendEncrypted: TButton
    Left = 192
    Top = 120
    Width = 97
    Height = 25
    Caption = 'Send Encrypted'
    TabOrder = 1
    OnClick = btnSendEncryptedClick
  end
  object clSmtp1: TclSmtp
    MailAgent = 'Clever Internet Suite'
    Left = 160
    Top = 48
  end
  object clSMimeMessage1: TclSMimeMessage
    ToList = <>
    CCList = <>
    BCCList = <>
    Date = 43405.945957372690000000
    CharSet = 'iso-8859-1'
    ContentType = 'text/plain'
    Config.SignAlgorithmName = 'sha-512'
    Config.SignAlgorithm = '2.16.840.1.101.3.4.2.3'
    Config.EncryptAlgorithm = '2.16.840.1.101.3.4.1.2'
    OnGetSigningCertificate = clSMimeMessage1GetSigningCertificate
    OnGetEncryptionCertificate = clSMimeMessage1GetEncryptionCertificate
    Left = 88
    Top = 48
  end
  object clCertificateStore1: TclCertificateStore
    StoreName = 'MY'
    CSP = 'Microsoft Base Cryptographic Provider v1.0'
    ValidFrom = 43405.000000000000000000
    ValidTo = 43770.000000000000000000
    Left = 224
    Top = 48
  end
end
