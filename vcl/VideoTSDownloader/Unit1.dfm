object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Video TS Downloader'
  ClientHeight = 322
  ClientWidth = 577
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
  object Label5: TLabel
    Left = 8
    Top = 43
    Width = 39
    Height = 13
    Caption = 'Save To'
  end
  object Label6: TLabel
    Left = 8
    Top = 154
    Width = 83
    Height = 13
    Caption = 'Failed Downloads'
  end
  object Label7: TLabel
    Left = 8
    Top = 70
    Width = 62
    Height = 13
    Caption = 'Download By'
  end
  object Label9: TLabel
    Left = 8
    Top = 299
    Width = 37
    Height = 13
    Caption = 'Split On'
  end
  object Label4: TLabel
    Left = 144
    Top = 70
    Width = 42
    Height = 13
    Caption = 'Progress'
  end
  object Label2: TLabel
    Left = 8
    Top = 11
    Width = 43
    Height = 13
    Caption = 'M3U8 Url'
  end
  object Label3: TLabel
    Left = 8
    Top = 97
    Width = 54
    Height = 13
    Caption = 'User Agent'
  end
  object Label8: TLabel
    Left = 8
    Top = 124
    Width = 48
    Height = 13
    Caption = 'Try Count'
  end
  object Label10: TLabel
    Left = 168
    Top = 124
    Width = 38
    Height = 13
    Caption = 'Timeout'
  end
  object btnStart: TButton
    Left = 479
    Top = 42
    Width = 89
    Height = 28
    Caption = 'Start'
    TabOrder = 1
    OnClick = btnStartClick
  end
  object btnStop: TButton
    Left = 479
    Top = 76
    Width = 88
    Height = 28
    Caption = 'Stop'
    TabOrder = 2
    OnClick = btnStopClick
  end
  object edtSaveToFolder: TEdit
    Left = 96
    Top = 40
    Width = 377
    Height = 21
    TabOrder = 0
  end
  object memLog: TMemo
    Left = 8
    Top = 173
    Width = 559
    Height = 117
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 3
  end
  object edtDownloadBy: TEdit
    Left = 96
    Top = 67
    Width = 33
    Height = 21
    TabOrder = 4
    Text = '4'
  end
  object btnPrepareList: TButton
    Left = 160
    Top = 294
    Width = 155
    Height = 25
    Caption = 'Prepare ffmpeg List'
    TabOrder = 5
    OnClick = btnPrepareListClick
  end
  object edtSplitOn: TEdit
    Left = 51
    Top = 296
    Width = 86
    Height = 21
    TabOrder = 6
    Text = '2'
  end
  object edtM3U8Url: TEdit
    Left = 96
    Top = 8
    Width = 377
    Height = 21
    TabOrder = 7
  end
  object edtProgress: TEdit
    Left = 208
    Top = 67
    Width = 265
    Height = 21
    ReadOnly = True
    TabOrder = 8
  end
  object edtUserAgent: TEdit
    Left = 96
    Top = 94
    Width = 377
    Height = 21
    TabOrder = 9
    Text = 'Mozilla/4.0 (compatible; Clever Internet Suite)'
  end
  object edtTryCount: TEdit
    Left = 96
    Top = 121
    Width = 57
    Height = 21
    TabOrder = 10
    Text = '5'
  end
  object edtTimeout: TEdit
    Left = 240
    Top = 121
    Width = 57
    Height = 21
    TabOrder = 11
    Text = '5000'
  end
  object btnGetList: TButton
    Left = 479
    Top = 8
    Width = 90
    Height = 28
    Caption = 'Get List'
    TabOrder = 12
    OnClick = btnGetListClick
  end
  object clMultiDownLoader1: TclMultiDownLoader
    InternetAgent = 'Mozilla/4.0 (compatible; Clever Internet Suite)'
    OnIsBusyChanged = clMultiDownLoader1IsBusyChanged
    MaxStartedItems = 4
    OnStatusChanged = clMultiDownLoader1StatusChanged
    DownLoadList = <>
    Left = 472
    Top = 120
  end
  object clDownLoader1: TclDownLoader
    InternetAgent = 'Mozilla/4.0 (compatible; Clever Internet Suite)'
    Left = 360
    Top = 120
  end
end
