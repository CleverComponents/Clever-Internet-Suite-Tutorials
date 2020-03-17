object Form1: TForm1
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Get FTP Directory Tree'
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
    Left = 8
    Top = 19
    Width = 22
    Height = 13
    Caption = 'Host'
  end
  object Label2: TLabel
    Left = 303
    Top = 19
    Width = 20
    Height = 13
    Caption = 'Port'
  end
  object Label3: TLabel
    Left = 8
    Top = 56
    Width = 22
    Height = 13
    Caption = 'User'
  end
  object Label4: TLabel
    Left = 303
    Top = 56
    Width = 46
    Height = 13
    Caption = 'Password'
  end
  object Label5: TLabel
    Left = 8
    Top = 94
    Width = 41
    Height = 13
    Caption = 'Rood Dir'
  end
  object Button1: TButton
    Left = 355
    Top = 89
    Width = 121
    Height = 41
    Caption = 'Get Dir Tree'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 8
    Top = 144
    Width = 468
    Height = 279
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 1
  end
  object edtHost: TEdit
    Left = 56
    Top = 16
    Width = 201
    Height = 21
    TabOrder = 2
    Text = 'localhost'
  end
  object edtPort: TEdit
    Left = 355
    Top = 16
    Width = 121
    Height = 21
    TabOrder = 3
    Text = '21'
  end
  object edtUser: TEdit
    Left = 56
    Top = 53
    Width = 121
    Height = 21
    TabOrder = 4
    Text = 'CleverTester'
  end
  object edtPassword: TEdit
    Left = 355
    Top = 53
    Width = 121
    Height = 21
    PasswordChar = '*'
    TabOrder = 5
    Text = 'clevertester'
  end
  object edtRoot: TEdit
    Left = 56
    Top = 91
    Width = 201
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
