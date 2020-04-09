object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Send JSon GET Request'
  ClientHeight = 153
  ClientWidth = 451
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object btnSendJSonString: TButton
    Left = 24
    Top = 88
    Width = 121
    Height = 25
    Caption = 'Send JSon String'
    TabOrder = 0
    OnClick = btnSendJSonStringClick
  end
  object btnSendSerializedObject: TButton
    Left = 160
    Top = 88
    Width = 121
    Height = 25
    Caption = 'Send Serialized Object'
    TabOrder = 1
    OnClick = btnSendSerializedObjectClick
  end
  object btnSendJSonObject: TButton
    Left = 296
    Top = 88
    Width = 121
    Height = 25
    Caption = 'Send JSon Object'
    TabOrder = 2
    OnClick = btnSendJSonObjectClick
  end
  object clHttp1: TclHttp
    UserAgent = 'Mozilla/4.0 (compatible; Clever Internet Suite)'
    Left = 80
    Top = 32
  end
  object clHttpRequest1: TclHttpRequest
    Header.Accept = '*/*'
    Left = 152
    Top = 32
  end
end
