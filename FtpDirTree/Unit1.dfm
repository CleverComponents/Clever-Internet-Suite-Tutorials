object Form1: TForm1
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Form1'
  ClientHeight = 431
  ClientWidth = 484
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
    Left = 24
    Top = 8
    Width = 22
    Height = 13
    Caption = 'Host'
  end
  object Label2: TLabel
    Left = 315
    Top = 8
    Width = 20
    Height = 13
    Caption = 'Port'
  end
  object Label3: TLabel
    Left = 24
    Top = 45
    Width = 22
    Height = 13
    Caption = 'User'
  end
  object Label4: TLabel
    Left = 256
    Top = 45
    Width = 46
    Height = 13
    Caption = 'Password'
  end
  object Label5: TLabel
    Left = 24
    Top = 83
    Width = 41
    Height = 13
    Caption = 'Rood Dir'
  end
  object Button1: TButton
    Left = 354
    Top = 78
    Width = 75
    Height = 25
    Caption = 'Get Dir Tree'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 0
    Top = 120
    Width = 484
    Height = 311
    Align = alBottom
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 1
  end
  object edtHost: TEdit
    Left = 72
    Top = 5
    Width = 161
    Height = 21
    TabOrder = 2
  end
  object edtPort: TEdit
    Left = 356
    Top = 5
    Width = 73
    Height = 21
    TabOrder = 3
    Text = '21'
  end
  object edtUser: TEdit
    Left = 72
    Top = 42
    Width = 121
    Height = 21
    TabOrder = 4
  end
  object edtPassword: TEdit
    Left = 308
    Top = 42
    Width = 121
    Height = 21
    PasswordChar = '*'
    TabOrder = 5
  end
  object edtRoot: TEdit
    Left = 72
    Top = 80
    Width = 121
    Height = 21
    TabOrder = 6
    Text = '/'
  end
  object clFtp1: TclFtp
    OnDirectoryListing = clFtp1DirectoryListing
    Left = 56
    Top = 160
  end
end
