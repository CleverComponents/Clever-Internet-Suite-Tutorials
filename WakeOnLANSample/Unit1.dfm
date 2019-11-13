object Form1: TForm1
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Wake On LAN sample'
  ClientHeight = 85
  ClientWidth = 442
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 32
    Width = 22
    Height = 13
    Caption = 'MAC'
  end
  object edtMAC: TEdit
    Left = 77
    Top = 29
    Width = 220
    Height = 21
    TabOrder = 0
    Text = '12-34-56-78-9A-BC'
  end
  object btnWakeUp: TButton
    Left = 320
    Top = 27
    Width = 75
    Height = 25
    Caption = 'Wake Up'
    TabOrder = 1
    OnClick = btnWakeUpClick
  end
end
