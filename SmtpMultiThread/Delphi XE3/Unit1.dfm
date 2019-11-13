object Form1: TForm1
  Left = 192
  Top = 114
  BorderStyle = bsDialog
  Caption = 'Multithreaded Mail Sender'
  ClientHeight = 333
  ClientWidth = 504
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 16
    Width = 62
    Height = 13
    Caption = 'SMTP server'
  end
  object Label2: TLabel
    Left = 24
    Top = 40
    Width = 53
    Height = 13
    Caption = 'User Name'
  end
  object Label3: TLabel
    Left = 24
    Top = 64
    Width = 46
    Height = 13
    Caption = 'Password'
  end
  object Label4: TLabel
    Left = 24
    Top = 88
    Width = 72
    Height = 13
    Caption = 'DB Connection'
  end
  object btnStart: TButton
    Left = 112
    Top = 152
    Width = 75
    Height = 25
    Caption = 'Start Thread'
    TabOrder = 5
    OnClick = btnStartClick
  end
  object edtServer: TEdit
    Left = 112
    Top = 16
    Width = 201
    Height = 21
    TabOrder = 0
    Text = 'localhost'
  end
  object edtUser: TEdit
    Left = 112
    Top = 40
    Width = 113
    Height = 21
    TabOrder = 1
    Text = 'username'
  end
  object edtPassword: TEdit
    Left = 112
    Top = 64
    Width = 113
    Height = 21
    PasswordChar = '*'
    TabOrder = 2
    Text = 'secret'
  end
  object edtConnectionString: TEdit
    Left = 112
    Top = 88
    Width = 369
    Height = 21
    TabOrder = 3
    Text = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=c:\database1.mdb;Pe' +
      'rsist Security Info=False'
  end
  object btnStop: TButton
    Left = 200
    Top = 152
    Width = 75
    Height = 25
    Caption = 'Stop All'
    TabOrder = 6
    OnClick = btnStopClick
  end
  object edtCount: TEdit
    Left = 112
    Top = 120
    Width = 121
    Height = 21
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 4
    Text = 'edtCount'
  end
  object memLog: TMemo
    Left = 0
    Top = 184
    Width = 504
    Height = 149
    Align = alBottom
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 7
  end
end
