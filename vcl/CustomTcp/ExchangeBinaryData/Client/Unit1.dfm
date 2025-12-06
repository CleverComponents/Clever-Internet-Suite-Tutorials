object Form1: TForm1
  Left = 247
  Top = 114
  BorderStyle = bsDialog
  Caption = 'Client'
  ClientHeight = 240
  ClientWidth = 370
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poDesktopCenter
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 70
    Width = 370
    Height = 170
    Align = alBottom
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 0
  end
  object Button2: TButton
    Left = 16
    Top = 24
    Width = 75
    Height = 25
    Caption = 'Send Stream'
    TabOrder = 1
    OnClick = Button2Click
  end
end
