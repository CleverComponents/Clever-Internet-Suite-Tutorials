object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 
    'How to modify a subject line of the email within the raw .eml so' +
    'urce'
  ClientHeight = 289
  ClientWidth = 554
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object btnSend: TButton
    Left = 200
    Top = 112
    Width = 75
    Height = 25
    Caption = 'Send'
    TabOrder = 0
    OnClick = btnSendClick
  end
  object clSmtp1: TclSmtp
    MailAgent = 'Clever Internet Suite'
    Left = 112
    Top = 56
  end
end
