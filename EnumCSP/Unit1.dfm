object Form1: TForm1
  Left = 247
  Top = 114
  Caption = 'Get CSP Info'
  ClientHeight = 375
  ClientWidth = 547
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
    Left = 16
    Top = 328
    Width = 113
    Height = 25
    Caption = 'Get CSP Info'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 547
    Height = 305
    Align = alTop
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 1
  end
end
