object Form1: TForm1
  Left = 192
  Top = 114
  BorderStyle = bsDialog
  Caption = 'Client Socket'
  ClientHeight = 220
  ClientWidth = 292
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 96
    Top = 24
    Width = 75
    Height = 25
    Caption = 'Start'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 0
    Top = 67
    Width = 292
    Height = 153
    Align = alBottom
    Lines.Strings = (
      'Log')
    ReadOnly = True
    TabOrder = 1
  end
end
