object Form1: TForm1
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Send mail with German Umlauts and other UTF-8 characters'
  ClientHeight = 159
  ClientWidth = 487
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  TextHeight = 13
  object Button1: TButton
    Left = 152
    Top = 72
    Width = 161
    Height = 25
    Caption = 'Compose and Send'
    TabOrder = 0
    OnClick = Button1Click
  end
  object clSmtp1: TclSmtp
    MailAgent = 'Clever Internet Suite'
    Left = 232
    Top = 16
  end
  object clMailMessage1: TclMailMessage
    ToList = <>
    CCList = <>
    BCCList = <>
    Date = 46007.753734305560000000
    CharSet = 'iso-8859-1'
    ContentType = 'text/plain'
    Left = 112
    Top = 24
  end
end
