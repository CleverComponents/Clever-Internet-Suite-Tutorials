object Form1: TForm1
  Left = 192
  Top = 114
  BorderStyle = bsDialog
  Caption = 'Server Socket'
  ClientHeight = 182
  ClientWidth = 303
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 72
    Width = 303
    Height = 110
    Align = alBottom
    Lines.Strings = (
      'Log')
    ReadOnly = True
    TabOrder = 0
  end
  object Button1: TButton
    Left = 104
    Top = 32
    Width = 75
    Height = 25
    Caption = 'Listen'
    TabOrder = 1
    OnClick = Button1Click
  end
end
