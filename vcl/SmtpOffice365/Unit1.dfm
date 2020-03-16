object Form1: TForm1
  Left = 0
  Top = 0
  AutoSize = True
  BorderStyle = bsDialog
  Caption = 'SMTP Client with SSL / TLS support'
  ClientHeight = 293
  ClientWidth = 377
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 0
    Top = 3
    Width = 32
    Height = 13
    Caption = 'Server'
  end
  object Label2: TLabel
    Left = 0
    Top = 30
    Width = 20
    Height = 13
    Caption = 'Port'
  end
  object Label3: TLabel
    Left = 0
    Top = 57
    Width = 22
    Height = 13
    Caption = 'User'
  end
  object Label4: TLabel
    Left = 168
    Top = 57
    Width = 46
    Height = 13
    Caption = 'Password'
  end
  object Label6: TLabel
    Left = 0
    Top = 84
    Width = 12
    Height = 13
    Caption = 'To'
  end
  object Label7: TLabel
    Left = 0
    Top = 110
    Width = 36
    Height = 13
    Caption = 'Subject'
  end
  object edtServer: TEdit
    Left = 56
    Top = 0
    Width = 289
    Height = 21
    TabOrder = 0
    Text = 'smtp.office365.com'
  end
  object edtPort: TEdit
    Left = 56
    Top = 27
    Width = 97
    Height = 21
    TabOrder = 1
    Text = '587'
  end
  object edtUser: TEdit
    Left = 56
    Top = 54
    Width = 97
    Height = 21
    TabOrder = 2
  end
  object edtPassword: TEdit
    Left = 230
    Top = 54
    Width = 115
    Height = 21
    PasswordChar = '*'
    TabOrder = 3
  end
  object edtTo: TEdit
    Left = 56
    Top = 81
    Width = 321
    Height = 21
    TabOrder = 4
    Text = 'recipient@sample.com'
  end
  object edtSubject: TEdit
    Left = 56
    Top = 107
    Width = 321
    Height = 21
    TabOrder = 5
    Text = 'Sample message'
  end
  object memBody: TMemo
    Left = 0
    Top = 134
    Width = 377
    Height = 128
    Lines.Strings = (
      'This is a sample email')
    TabOrder = 6
  end
  object btnSend: TButton
    Left = 256
    Top = 268
    Width = 121
    Height = 25
    Caption = 'Send'
    TabOrder = 7
    OnClick = btnSendClick
  end
  object clSmtp1: TclSmtp
    OnVerifyServer = clSmtp1VerifyServer
    MailAgent = 'Clever Internet Suite v 7.0'
    Left = 184
    Top = 208
  end
  object clMailMessage1: TclMailMessage
    ToList = <>
    CCList = <>
    BCCList = <>
    Date = 40009.488706053240000000
    CharSet = 'iso-8859-1'
    ContentType = 'text/plain'
    Left = 240
    Top = 200
  end
end
