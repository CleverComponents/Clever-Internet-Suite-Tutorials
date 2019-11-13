object Form1: TForm1
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'DNS Server'
  ClientHeight = 348
  ClientWidth = 454
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 32
    Top = 24
    Width = 20
    Height = 13
    Caption = 'Port'
  end
  object Label2: TLabel
    Left = 180
    Top = 24
    Width = 34
    Height = 13
    Caption = 'Binding'
  end
  object Button1: TButton
    Left = 72
    Top = 64
    Width = 75
    Height = 25
    Caption = 'Start'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 180
    Top = 64
    Width = 75
    Height = 25
    Caption = 'Stop'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Memo1: TMemo
    Left = 0
    Top = 112
    Width = 454
    Height = 236
    Align = alBottom
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object edtPort: TEdit
    Left = 72
    Top = 21
    Width = 73
    Height = 21
    TabOrder = 3
  end
  object edtBinding: TEdit
    Left = 232
    Top = 21
    Width = 161
    Height = 21
    TabOrder = 4
  end
  object clDnsServer1: TclDnsServer
    OnStart = clDnsServer1Start
    OnStop = clDnsServer1Stop
    RootNameServers.Strings = (
      'A.ROOT-SERVERS.NET'
      'B.ROOT-SERVERS.NET'
      'C.ROOT-SERVERS.NET'
      'D.ROOT-SERVERS.NET'
      'E.ROOT-SERVERS.NET'
      'F.ROOT-SERVERS.NET'
      'G.ROOT-SERVERS.NET'
      'H.ROOT-SERVERS.NET'
      'I.ROOT-SERVERS.NET'
      'J.ROOT-SERVERS.NET'
      'K.ROOT-SERVERS.NET'
      'L.ROOT-SERVERS.NET'
      'M.ROOT-SERVERS.NE')
    OnReceiveQuery = clDnsServer1ReceiveQuery
    OnSendResponse = clDnsServer1SendResponse
    OnGetHandedRecords = clDnsServer1GetHandedRecords
    Left = 360
    Top = 56
  end
end
