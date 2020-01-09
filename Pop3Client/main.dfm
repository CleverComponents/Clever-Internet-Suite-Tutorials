object Form1: TForm1
  Left = 192
  Top = 114
  Caption = 'POP3 client '
  ClientHeight = 364
  ClientWidth = 623
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 12
    Top = 18
    Width = 54
    Height = 13
    Caption = 'POP server'
  end
  object Label2: TLabel
    Left = 12
    Top = 50
    Width = 22
    Height = 13
    Caption = 'User'
  end
  object Label3: TLabel
    Left = 12
    Top = 78
    Width = 46
    Height = 13
    Caption = 'Password'
  end
  object Label4: TLabel
    Left = 13
    Top = 152
    Width = 147
    Height = 13
    Caption = 'Messages. Double click to view'
  end
  object edtPop3Server: TEdit
    Left = 79
    Top = 16
    Width = 533
    Height = 21
    TabOrder = 0
    Text = 'pop.domain.com'
  end
  object edtUser: TEdit
    Left = 78
    Top = 43
    Width = 533
    Height = 21
    TabOrder = 1
    Text = 'user@domain.com'
  end
  object edtPassword: TEdit
    Left = 78
    Top = 70
    Width = 533
    Height = 21
    PasswordChar = '*'
    TabOrder = 2
    Text = 'password'
  end
  object btnCheckMail: TButton
    Left = 13
    Top = 110
    Width = 113
    Height = 25
    Caption = 'Check Mail'
    TabOrder = 3
    OnClick = btnCheckMailClick
  end
  object lbMessages: TListBox
    Left = 12
    Top = 168
    Width = 599
    Height = 183
    ItemHeight = 13
    TabOrder = 4
    OnDblClick = lbMessagesDblClick
  end
  object clPOP31: TclPop3
    Left = 120
    Top = 256
  end
  object clMailMessage1: TclMailMessage
    ToList = <>
    CCList = <>
    BCCList = <>
    Date = 38524.526523229200000000
    CharSet = 'iso-8859-1'
    ContentType = 'text/plain'
    Left = 160
    Top = 256
  end
end
