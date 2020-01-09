object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'SFtp Client '
  ClientHeight = 465
  ClientWidth = 667
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 36
    Height = 13
    Caption = 'IP/Host'
  end
  object Label2: TLabel
    Left = 8
    Top = 40
    Width = 22
    Height = 13
    Caption = 'User'
  end
  object Label3: TLabel
    Left = 446
    Top = 40
    Width = 20
    Height = 13
    Caption = 'Port'
  end
  object Label4: TLabel
    Left = 8
    Top = 80
    Width = 46
    Height = 13
    Caption = 'Password'
  end
  object Label5: TLabel
    Left = 8
    Top = 107
    Width = 74
    Height = 13
    Caption = 'Private Key File'
  end
  object Label6: TLabel
    Left = 312
    Top = 107
    Width = 55
    Height = 13
    Caption = 'Passphrase'
  end
  object Label7: TLabel
    Left = 8
    Top = 152
    Width = 40
    Height = 13
    Caption = 'Start Dir'
  end
  object Label8: TLabel
    Left = 8
    Top = 185
    Width = 64
    Height = 13
    Caption = 'Remove Host'
  end
  object Label9: TLabel
    Left = 312
    Top = 80
    Width = 64
    Height = 13
    Caption = 'Authorization'
  end
  object edtHost: TEdit
    Left = 108
    Top = 5
    Width = 453
    Height = 21
    TabOrder = 0
    Text = 'localhost'
  end
  object edtUser: TEdit
    Left = 108
    Top = 37
    Width = 181
    Height = 21
    TabOrder = 1
    Text = 'CleverTester'
  end
  object edtPort: TEdit
    Left = 472
    Top = 37
    Width = 89
    Height = 21
    TabOrder = 2
    Text = '22'
  end
  object edtPassword: TEdit
    Left = 108
    Top = 77
    Width = 181
    Height = 21
    PasswordChar = '*'
    TabOrder = 3
    Text = 'clevertester'
  end
  object edtPrivateKeyFile: TEdit
    Left = 108
    Top = 104
    Width = 181
    Height = 21
    TabOrder = 4
    Text = 'rsa-private-key.pem'
  end
  object edtPassphrase: TEdit
    Left = 384
    Top = 104
    Width = 177
    Height = 21
    PasswordChar = '*'
    TabOrder = 5
    Text = 'secret'
  end
  object edtStartDir: TEdit
    Left = 108
    Top = 149
    Width = 453
    Height = 21
    TabOrder = 6
    Text = '/'
  end
  object cbAuthorization: TComboBox
    Left = 384
    Top = 77
    Width = 177
    Height = 21
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 7
    Text = 'User/Password'
    OnChange = cbAuthorizationChange
    Items.Strings = (
      'User/Password'
      'Private Key')
  end
  object lbList: TListBox
    Left = 8
    Top = 211
    Width = 553
    Height = 231
    ItemHeight = 13
    TabOrder = 8
  end
  object ProgressBar: TProgressBar
    Left = 0
    Top = 448
    Width = 667
    Height = 17
    Align = alBottom
    TabOrder = 9
  end
  object btnLogin: TButton
    Left = 567
    Top = 3
    Width = 92
    Height = 25
    Caption = 'Login'
    TabOrder = 10
    OnClick = btnLoginClick
  end
  object btnLogout: TButton
    Left = 567
    Top = 34
    Width = 92
    Height = 25
    Caption = 'Logout'
    TabOrder = 11
    OnClick = btnLogoutClick
  end
  object btnOpenDir: TButton
    Left = 567
    Top = 77
    Width = 92
    Height = 25
    Caption = 'OpenDir'
    TabOrder = 12
    OnClick = btnOpenDirClick
  end
  object btnGoUp: TButton
    Left = 567
    Top = 108
    Width = 92
    Height = 25
    Caption = 'GoUp'
    TabOrder = 13
    OnClick = btnGoUpClick
  end
  object btnDownload: TButton
    Left = 567
    Top = 149
    Width = 92
    Height = 25
    Caption = 'Download'
    TabOrder = 14
    OnClick = btnDownloadClick
  end
  object btnUpload: TButton
    Left = 567
    Top = 180
    Width = 92
    Height = 25
    Caption = 'Upload'
    TabOrder = 15
    OnClick = btnUploadClick
  end
  object OpenDialog1: TOpenDialog
    Left = 144
    Top = 320
  end
  object SaveDialog1: TSaveDialog
    Left = 224
    Top = 320
  end
  object clSFtp1: TclSFtp
    SshAgent = 'Clever_Internet_Suite'
    OnVerifyServer = clSFtp1VerifyServer
    OnDirectoryListing = clSFtp1DirectoryListing
    Left = 296
    Top = 336
  end
end
