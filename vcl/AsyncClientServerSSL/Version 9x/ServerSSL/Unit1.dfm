object Form1: TForm1
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'SSL Server'
  ClientHeight = 324
  ClientWidth = 355
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
    Top = 19
    Width = 20
    Height = 13
    Caption = 'Port'
  end
  object Label2: TLabel
    Left = 8
    Top = 91
    Width = 17
    Height = 13
    Caption = 'Log'
  end
  object edtPort: TEdit
    Left = 66
    Top = 16
    Width = 65
    Height = 21
    TabOrder = 0
    Text = '9002'
  end
  object btnStart: TButton
    Left = 160
    Top = 14
    Width = 75
    Height = 25
    Caption = 'Start'
    TabOrder = 1
    OnClick = btnStartClick
  end
  object btnStop: TButton
    Left = 257
    Top = 14
    Width = 75
    Height = 25
    Caption = 'Stop'
    TabOrder = 2
    OnClick = btnStopClick
  end
  object memLog: TMemo
    Left = 0
    Top = 110
    Width = 355
    Height = 214
    Align = alBottom
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 5
  end
  object edtData: TEdit
    Left = 32
    Top = 56
    Width = 169
    Height = 21
    TabOrder = 3
    Text = 'Data from server'
  end
  object btnSend: TButton
    Left = 216
    Top = 54
    Width = 116
    Height = 25
    Caption = 'Send to connections'
    TabOrder = 4
    OnClick = btnSendClick
  end
  object clCertificateStore1: TclCertificateStore
    StoreName = 'MY'
    CSP = 'Microsoft Base Cryptographic Provider v1.0'
    ValidFrom = 41429.000000000000000000
    ValidTo = 41794.000000000000000000
    Left = 136
    Top = 120
  end
end
