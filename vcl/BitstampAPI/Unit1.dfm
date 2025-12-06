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
  DesignSize = (
    554
    289)
  TextHeight = 13
  object Label1: TLabel
    Left = 139
    Top = 16
    Width = 301
    Height = 19
    Caption = 'Learn more https://www.bitstamp.net/api/'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
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
    Left = 256
    Top = 80
  end
  object request: TclHttpRequest
    Header.Accept = '*/*'
    Left = 312
    Top = 80
  end
end
