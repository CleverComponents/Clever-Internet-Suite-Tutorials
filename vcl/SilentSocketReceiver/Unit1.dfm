object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Silent Socket Receiver'
  ClientHeight = 291
  ClientWidth = 394
  Color = clBtnFace
  Constraints.MinHeight = 330
  Constraints.MinWidth = 410
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    394
    291)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 27
    Top = 24
    Width = 20
    Height = 13
    Caption = 'Port'
  end
  object btnListen: TButton
    Left = 187
    Top = 19
    Width = 75
    Height = 25
    Caption = 'Listen'
    TabOrder = 1
    OnClick = btnListenClick
  end
  object btnStop: TButton
    Left = 288
    Top = 19
    Width = 75
    Height = 25
    Caption = 'Stop'
    TabOrder = 2
    OnClick = btnStopClick
  end
  object edtPort: TEdit
    Left = 72
    Top = 21
    Width = 89
    Height = 21
    TabOrder = 0
    Text = '2110'
  end
  object memLog: TMemo
    Left = 8
    Top = 64
    Width = 376
    Height = 219
    Anchors = [akLeft, akTop, akRight, akBottom]
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 3
    ExplicitWidth = 377
    ExplicitHeight = 217
  end
end
