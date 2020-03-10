object Form1: TForm1
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Send Signed E-mail'
  ClientHeight = 462
  ClientWidth = 473
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 24
    Height = 13
    Caption = 'From'
  end
  object Label2: TLabel
    Left = 8
    Top = 35
    Width = 12
    Height = 13
    Caption = 'To'
  end
  object Label3: TLabel
    Left = 8
    Top = 62
    Width = 36
    Height = 13
    Caption = 'Subject'
  end
  object Label5: TLabel
    Left = 8
    Top = 224
    Width = 86
    Height = 13
    Caption = 'Certificate Source'
  end
  object Label6: TLabel
    Left = 8
    Top = 253
    Width = 99
    Height = 13
    Caption = 'Certificate File Name'
  end
  object Label7: TLabel
    Left = 8
    Top = 313
    Width = 119
    Height = 13
    Caption = 'Select Signing Certificate'
  end
  object Label8: TLabel
    Left = 8
    Top = 340
    Width = 51
    Height = 13
    Caption = 'SMTP Host'
  end
  object Label9: TLabel
    Left = 368
    Top = 340
    Width = 20
    Height = 13
    Caption = 'Port'
  end
  object Label10: TLabel
    Left = 8
    Top = 372
    Width = 52
    Height = 13
    Caption = 'User Name'
  end
  object Label11: TLabel
    Left = 300
    Top = 372
    Width = 46
    Height = 13
    Caption = 'Password'
  end
  object Label12: TLabel
    Left = 8
    Top = 284
    Width = 99
    Height = 13
    Caption = 'Certificate Password'
  end
  object edtFrom: TEdit
    Left = 72
    Top = 5
    Width = 393
    Height = 21
    TabOrder = 0
    Text = 'sender@example.com'
  end
  object edtRecipient: TEdit
    Left = 72
    Top = 32
    Width = 393
    Height = 21
    TabOrder = 1
    Text = 'recipient@domain.com'
  end
  object edtSubject: TEdit
    Left = 72
    Top = 59
    Width = 393
    Height = 21
    TabOrder = 2
    Text = 'Using NIST sha-512 algorithm'
  end
  object memText: TMemo
    Left = 8
    Top = 88
    Width = 457
    Height = 105
    Lines.Strings = (
      
        'This example was build with Delphi and smime signing using NIST ' +
        'sha-512 algorithm.')
    TabOrder = 3
  end
  object cbSign: TCheckBox
    Left = 8
    Top = 199
    Width = 97
    Height = 17
    Caption = 'Sign E-mail'
    Checked = True
    State = cbChecked
    TabOrder = 4
    OnClick = cbSignClick
  end
  object cbCertificateSource: TComboBox
    Left = 143
    Top = 221
    Width = 201
    Height = 21
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 5
    Text = '*.PFX File'
    OnChange = cbCertificateSourceChange
    Items.Strings = (
      '*.PFX File'
      'Windows Personal Certificate Store')
  end
  object edtCertificateFileName: TEdit
    Left = 143
    Top = 250
    Width = 291
    Height = 21
    TabOrder = 6
  end
  object btnSelectCertificateFile: TButton
    Left = 440
    Top = 248
    Width = 25
    Height = 25
    Caption = '...'
    TabOrder = 7
    OnClick = btnSelectCertificateFileClick
  end
  object cbCertificate: TComboBox
    Left = 143
    Top = 310
    Width = 322
    Height = 21
    Style = csDropDownList
    TabOrder = 10
  end
  object edtSmtpHost: TEdit
    Left = 72
    Top = 337
    Width = 272
    Height = 21
    TabOrder = 11
    Text = 'mail.domain.com'
  end
  object edtSmtpPort: TEdit
    Left = 400
    Top = 337
    Width = 65
    Height = 21
    TabOrder = 12
    Text = '25'
  end
  object edtSmtpUser: TEdit
    Left = 72
    Top = 369
    Width = 201
    Height = 21
    TabOrder = 13
    Text = 'sender@example.com'
  end
  object edtSmtpPassword: TEdit
    Left = 352
    Top = 369
    Width = 113
    Height = 21
    PasswordChar = '*'
    TabOrder = 14
    Text = 'secret'
  end
  object btnSend: TButton
    Left = 145
    Top = 396
    Width = 201
    Height = 41
    Caption = 'Send E-mail'
    TabOrder = 15
    OnClick = btnSendClick
  end
  object ProgressBar1: TProgressBar
    Left = 0
    Top = 445
    Width = 473
    Height = 17
    Align = alBottom
    TabOrder = 16
  end
  object edtCertificatePassword: TEdit
    Left = 143
    Top = 281
    Width = 201
    Height = 21
    PasswordChar = '*'
    TabOrder = 8
    Text = '123'
  end
  object btnLoadCertificate: TButton
    Left = 350
    Top = 279
    Width = 115
    Height = 25
    Caption = 'Load'
    TabOrder = 9
    OnClick = btnLoadCertificateClick
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '*.pfx'
    Filter = '*.pfx|*.pfx|*.p12|*.p12|(All)|*.*'
    FilterIndex = 0
    Left = 104
    Top = 128
  end
  object clSMimeMessage1: TclSMimeMessage
    ToList = <>
    CCList = <>
    BCCList = <>
    Date = 43347.730945289350000000
    CharSet = 'iso-8859-1'
    ContentType = 'text/plain'
    Config.SignAlgorithmName = 'sha-1'
    Config.SignAlgorithm = '1.2.840.113549.1.1.5'
    Config.EncryptAlgorithm = '1.2.840.113549.3.2'
    OnGetSigningCertificate = clSMimeMessage1GetSigningCertificate
    Left = 272
    Top = 128
  end
  object clSmtp1: TclSmtp
    OnProgress = clSmtp1Progress
    MailAgent = 'Clever Internet Suite'
    Left = 344
    Top = 128
  end
  object clCertificateStore1: TclCertificateStore
    StoreName = 'MY'
    CSP = 'Microsoft Base Cryptographic Provider v1.0'
    ValidFrom = 43347.000000000000000000
    ValidTo = 43712.000000000000000000
    Left = 184
    Top = 128
  end
end
