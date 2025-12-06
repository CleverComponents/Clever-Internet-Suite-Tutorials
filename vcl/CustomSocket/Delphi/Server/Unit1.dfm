object Form1: TForm1
  Left = 192
  Top = 114
  BorderStyle = bsDialog
  Caption = 'Server Socket Sample'
  ClientHeight = 275
  ClientWidth = 357
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  TextHeight = 13
  object Button1: TButton
    Left = 32
    Top = 24
    Width = 75
    Height = 25
    Caption = 'Accept'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 0
    Top = 82
    Width = 357
    Height = 193
    Align = alBottom
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 1
  end
end
