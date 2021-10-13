object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Bitstamp API Example'
  ClientHeight = 289
  ClientWidth = 554
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    554
    289)
  PixelsPerInch = 96
  TextHeight = 13
  object btnSubmit: TButton
    Left = 16
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Submit'
    TabOrder = 0
    OnClick = btnSubmitClick
  end
  object memResponse: TMemo
    Left = 16
    Top = 64
    Width = 521
    Height = 209
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 1
  end
  object http: TclHttp
    UserAgent = 'Mozilla/4.0 (compatible; Clever Internet Suite)'
    Left = 136
    Top = 16
  end
  object request: TclHttpRequest
    Header.Accept = '*/*'
    Left = 184
    Top = 16
  end
end
