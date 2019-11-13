object Form1: TForm1
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Ping client'
  ClientHeight = 204
  ClientWidth = 391
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 24
    Width = 22
    Height = 13
    Caption = 'Host'
  end
  object edtHost: TEdit
    Left = 64
    Top = 21
    Width = 121
    Height = 21
    TabOrder = 0
    Text = 'google.com'
  end
  object Button1: TButton
    Left = 206
    Top = 19
    Width = 75
    Height = 25
    Caption = 'Ping'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 0
    Top = 64
    Width = 391
    Height = 140
    Align = alBottom
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 2
  end
end
