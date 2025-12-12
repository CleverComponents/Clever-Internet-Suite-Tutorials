object Form1: TForm1
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Get Browser Proxy Settings'
  ClientHeight = 324
  ClientWidth = 366
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 13
  object Button1: TButton
    Left = 8
    Top = 24
    Width = 75
    Height = 25
    Caption = 'GO'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 0
    Top = 55
    Width = 366
    Height = 269
    Align = alBottom
    ReadOnly = True
    TabOrder = 1
  end
end
