object Form1: TForm1
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'HTTP Download - Asynchronous Sample'
  ClientHeight = 376
  ClientWidth = 610
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 24
    Width = 19
    Height = 13
    Caption = 'URL'
  end
  object Label2: TLabel
    Left = 24
    Top = 51
    Width = 16
    Height = 13
    Caption = 'File'
  end
  object Label3: TLabel
    Left = 24
    Top = 285
    Width = 37
    Height = 13
    Caption = 'Cookies'
  end
  object edtURL: TEdit
    Left = 88
    Top = 21
    Width = 393
    Height = 21
    TabOrder = 0
  end
  object edtFile: TEdit
    Left = 88
    Top = 48
    Width = 393
    Height = 21
    TabOrder = 1
  end
  object btnStart: TButton
    Left = 512
    Top = 88
    Width = 75
    Height = 25
    Caption = 'Start'
    TabOrder = 3
    OnClick = btnStartClick
  end
  object lbDownloads: TListBox
    Left = 24
    Top = 88
    Width = 457
    Height = 185
    ItemHeight = 13
    TabOrder = 5
  end
  object btnStop: TButton
    Left = 512
    Top = 119
    Width = 75
    Height = 25
    Caption = 'Stop'
    TabOrder = 4
    OnClick = btnStopClick
  end
  object btnAdd: TButton
    Left = 512
    Top = 19
    Width = 75
    Height = 25
    Caption = 'Add'
    TabOrder = 2
    OnClick = btnAddClick
  end
  object memCookies: TMemo
    Left = 24
    Top = 304
    Width = 457
    Height = 64
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 6
  end
  object clCookieManager1: TclCookieManager
    OnAddCookie = clCookieManager1AddCookie
    OnDeleteCookie = clCookieManager1DeleteCookie
    OnUpdateCookie = clCookieManager1UpdateCookie
    Left = 536
    Top = 176
  end
end
