object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Send SMTP from Office365 using OAuth 2.0'
  ClientHeight = 323
  ClientWidth = 445
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
    Top = 16
    Width = 32
    Height = 13
    Caption = 'Server'
  end
  object Label2: TLabel
    Left = 24
    Top = 48
    Width = 24
    Height = 13
    Caption = 'From'
  end
  object Label3: TLabel
    Left = 24
    Top = 75
    Width = 12
    Height = 13
    Caption = 'To'
  end
  object Label4: TLabel
    Left = 24
    Top = 102
    Width = 36
    Height = 13
    Caption = 'Subject'
  end
  object edtServer: TEdit
    Left = 72
    Top = 13
    Width = 345
    Height = 21
    Color = clBtnFace
    Enabled = False
    ReadOnly = True
    TabOrder = 0
    Text = 'smtp.office365.com'
  end
  object edtFrom: TEdit
    Left = 72
    Top = 45
    Width = 201
    Height = 21
    TabOrder = 1
    Text = 'sender@hotmail.com'
  end
  object edtTo: TEdit
    Left = 72
    Top = 72
    Width = 201
    Height = 21
    TabOrder = 2
    Text = 'recipient@domain.com'
  end
  object edtSubject: TEdit
    Left = 72
    Top = 99
    Width = 345
    Height = 21
    TabOrder = 3
    Text = 'This is a subject line'
  end
  object memText: TMemo
    Left = 72
    Top = 126
    Width = 345
    Height = 139
    Lines.Strings = (
      'Hello,'
      ''
      'This is a message body.')
    ScrollBars = ssVertical
    TabOrder = 4
  end
  object btnSend: TButton
    Left = 288
    Top = 280
    Width = 129
    Height = 25
    Caption = 'Send'
    TabOrder = 5
    OnClick = btnSendClick
  end
  object clOAuth1: TclOAuth
    UserAgent = 'CleverComponents OAUTH 2.0'
    EnterCodeFormCaption = 'Enter Authorization Code'
    SuccessHtmlResponse = 
      '<html><body><h3 style="color:green;margin:30px">OAuth Authorizat' +
      'ion Successful!</h3></body></html>'
    FailedHtmlResponse = 
      '<html><body><h3 style="color:red;margin:30px">OAuth Authorizatio' +
      'n Failed!</h3></body></html>'
    Left = 184
    Top = 200
  end
  object clSmtp1: TclSmtp
    MailAgent = 'Clever Internet Suite'
    Left = 264
    Top = 200
  end
  object clMailMessage1: TclMailMessage
    ToList = <>
    CCList = <>
    BCCList = <>
    Date = 44752.636476840280000000
    CharSet = 'iso-8859-1'
    ContentType = 'text/plain'
    Left = 336
    Top = 200
  end
end
