object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'How to use OpenSSL with Memory Bios to run TLS handshake'
  ClientHeight = 420
  ClientWidth = 776
  Color = clBtnFace
  Constraints.MinHeight = 200
  Constraints.MinWidth = 400
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  DesignSize = (
    776
    420)
  PixelsPerInch = 96
  TextHeight = 13
  object btnLibInit: TButton
    Left = 48
    Top = 32
    Width = 75
    Height = 25
    Caption = 'Lib Init'
    TabOrder = 0
    OnClick = btnLibInitClick
  end
  object btnTransferData: TButton
    Left = 176
    Top = 32
    Width = 105
    Height = 25
    Caption = 'Transfer Data'
    TabOrder = 1
    OnClick = btnTransferDataClick
  end
  object memLog: TMemo
    Left = 8
    Top = 63
    Width = 760
    Height = 349
    Anchors = [akLeft, akTop, akRight, akBottom]
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 2
  end
end
