object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Http Get using TTask'
  ClientHeight = 384
  ClientWidth = 622
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  object URL: TLabel
    Left = 13
    Top = 9
    Width = 19
    Height = 13
    Caption = 'URL'
  end
  object Button1: TButton
    Left = 541
    Top = 4
    Width = 73
    Height = 25
    Caption = 'Get'
    ModalResult = 1
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 13
    Top = 50
    Width = 601
    Height = 326
    Lines.Strings = (
      'Memo1')
    ScrollBars = ssBoth
    TabOrder = 1
  end
  object edtUrl: TEdit
    Left = 54
    Top = 6
    Width = 481
    Height = 21
    TabOrder = 2
    Text = 'https://www.microsoft.com/'
  end
  object cbShowText: TCheckBox
    Left = 13
    Top = 28
    Width = 97
    Height = 17
    Caption = 'Show Text Only'
    TabOrder = 3
  end
  object clHttp1: TclHttp
    UserAgent = 'Mozilla/4.0 (compatible; Clever Internet Suite)'
    Left = 541
    Top = 248
  end
  object clHtmlParser1: TclHtmlParser
    OnParseTag = clHtmlParser1ParseTag
    Left = 480
    Top = 248
  end
end
