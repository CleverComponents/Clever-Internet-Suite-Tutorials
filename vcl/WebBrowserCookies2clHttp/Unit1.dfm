object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 514
  ClientWidth = 554
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 8
    Width = 19
    Height = 13
    Caption = 'URL'
  end
  object btnLogin: TButton
    Left = 24
    Top = 232
    Width = 75
    Height = 25
    Caption = 'Login'
    TabOrder = 2
    OnClick = btnLoginClick
  end
  object Panel1: TPanel
    Left = 0
    Top = 32
    Width = 554
    Height = 177
    Caption = 'Panel1'
    TabOrder = 1
  end
  object btnGetCookie: TButton
    Left = 144
    Top = 232
    Width = 75
    Height = 25
    Caption = 'Get Cookie'
    TabOrder = 3
    OnClick = btnGetCookieClick
  end
  object Memo1: TMemo
    Left = 0
    Top = 272
    Width = 554
    Height = 242
    Align = alBottom
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 5
  end
  object btnSubmit: TButton
    Left = 256
    Top = 232
    Width = 75
    Height = 25
    Caption = 'Submit'
    TabOrder = 4
    OnClick = btnSubmitClick
  end
  object edtURL: TEdit
    Left = 41
    Top = 5
    Width = 505
    Height = 21
    TabOrder = 0
  end
  object clHttp1: TclHttp
    UserAgent = 'Mozilla/4.0 (compatible; Clever Internet Suite)'
    CookieManager = clCookieManager1
    Left = 368
    Top = 88
  end
  object clCookieManager1: TclCookieManager
    Left = 328
    Top = 88
  end
end
