object Form1: TForm1
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Making and Extracting the content of a .p7m file.'
  ClientHeight = 443
  ClientWidth = 544
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label3: TLabel
    Left = 5
    Top = 6
    Width = 52
    Height = 13
    Caption = 'Source File'
  end
  object Label5: TLabel
    Left = 5
    Top = 33
    Width = 71
    Height = 13
    Caption = 'Destination file'
  end
  object Label8: TLabel
    Left = 5
    Top = 230
    Width = 50
    Height = 13
    Caption = 'Source file'
  end
  object Label9: TLabel
    Left = 2
    Top = 62
    Width = 96
    Height = 13
    Caption = ' Certificate Location'
  end
  object Label10: TLabel
    Left = 5
    Top = 89
    Width = 99
    Height = 13
    Caption = 'Certificate File Name'
  end
  object Label11: TLabel
    Left = 5
    Top = 149
    Width = 119
    Height = 13
    Caption = 'Select Signing Certificate'
  end
  object Label12: TLabel
    Left = 5
    Top = 120
    Width = 99
    Height = 13
    Caption = 'Certificate Password'
  end
  object Label1: TLabel
    Left = 5
    Top = 257
    Width = 71
    Height = 13
    Caption = 'Destination file'
  end
  object Bevel1: TBevel
    Left = -17
    Top = 216
    Width = 566
    Height = 5
  end
  object Label2: TLabel
    Left = 5
    Top = 284
    Width = 105
    Height = 13
    Caption = 'Extracted Certificates'
  end
  object btnSign: TButton
    Left = 5
    Top = 176
    Width = 97
    Height = 35
    Caption = 'Sign'
    TabOrder = 0
    OnClick = btnSignClick
  end
  object btnVerifyFile: TButton
    Left = 4
    Top = 405
    Width = 97
    Height = 35
    Caption = 'Verify'
    TabOrder = 1
    OnClick = btnVerifyFileClick
  end
  object edtSourceFile: TEdit
    Left = 146
    Top = 3
    Width = 363
    Height = 21
    TabOrder = 2
  end
  object btnSource: TButton
    Left = 515
    Top = 3
    Width = 23
    Height = 21
    Caption = '...'
    TabOrder = 3
    OnClick = btnSourceClick
  end
  object edtDestinationFile: TEdit
    Left = 146
    Top = 30
    Width = 363
    Height = 21
    TabOrder = 4
  end
  object btnDestinationFile: TButton
    Left = 515
    Top = 30
    Width = 23
    Height = 21
    Caption = '...'
    TabOrder = 5
    OnClick = btnDestinationFileClick
  end
  object edtSRC: TEdit
    Left = 146
    Top = 227
    Width = 363
    Height = 21
    TabOrder = 6
  end
  object btnSRC: TButton
    Left = 515
    Top = 227
    Width = 23
    Height = 21
    Caption = '...'
    TabOrder = 7
    OnClick = btnSRCClick
  end
  object cbCertificateLocation: TComboBox
    Left = 146
    Top = 59
    Width = 183
    Height = 21
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 8
    Text = '*.PFX File'
    OnChange = cbCertificateLocationChange
    Items.Strings = (
      '*.PFX File'
      'Windows Personal Certificate Store')
  end
  object edtCertificateFileName: TEdit
    Left = 146
    Top = 86
    Width = 363
    Height = 21
    TabOrder = 9
  end
  object btnSelectCertificateFile: TButton
    Left = 515
    Top = 86
    Width = 23
    Height = 21
    Caption = '...'
    TabOrder = 10
    OnClick = btnSelectCertificateFileClick
  end
  object cbCertificate: TComboBox
    Left = 146
    Top = 146
    Width = 359
    Height = 21
    Style = csDropDownList
    TabOrder = 11
  end
  object edtCertificatePassword: TEdit
    Left = 146
    Top = 117
    Width = 183
    Height = 21
    PasswordChar = '*'
    TabOrder = 12
    Text = '123'
  end
  object btnLoadCertificate: TButton
    Left = 335
    Top = 115
    Width = 62
    Height = 25
    Caption = 'Load'
    TabOrder = 13
    OnClick = btnLoadCertificateClick
  end
  object edtDST: TEdit
    Left = 146
    Top = 254
    Width = 363
    Height = 21
    TabOrder = 14
  end
  object btnDST: TButton
    Left = 515
    Top = 254
    Width = 23
    Height = 21
    Caption = '...'
    TabOrder = 15
    OnClick = btnDSTClick
  end
  object lbExtractedCertificates: TListBox
    Left = 5
    Top = 303
    Width = 531
    Height = 97
    ItemHeight = 13
    TabOrder = 16
  end
  object clEncryptor1: TclEncryptor
    SignAlgorithm = '2.16.840.1.101.3.4.2.3'
    EncryptAlgorithm = '2.16.840.1.101.3.4.1.42'
    Left = 352
    Top = 176
  end
  object clCertificateStore1: TclCertificateStore
    StoreName = 'MY'
    CSP = 'Microsoft Base Cryptographic Provider v1.0'
    ValidFrom = 43934.000000000000000000
    ValidTo = 44299.000000000000000000
    Left = 272
    Top = 176
  end
  object OpenDialog1: TOpenDialog
    Left = 192
    Top = 176
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = '.p7m'
    Filter = 'p7m|*.p7m|all|*.*'
    Left = 128
    Top = 176
  end
  object OpenDialog2: TOpenDialog
    Filter = 'pfx|*.pfx|p12|*.p12|all|*.*'
    Left = 416
    Top = 176
  end
  object OpenDialog3: TOpenDialog
    DefaultExt = '.p7m'
    Filter = 'p7m|*.p7m|all|*.*'
    Left = 480
    Top = 176
  end
  object SaveDialog2: TSaveDialog
    Left = 16
    Top = 308
  end
end
