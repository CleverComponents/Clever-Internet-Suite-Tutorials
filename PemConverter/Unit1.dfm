object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'RSA Public Key converter'
  ClientHeight = 111
  ClientWidth = 456
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
    Left = 40
    Top = 16
    Width = 336
    Height = 13
    Caption = 
      'Converts from RSA Public Key format to X509 Subject Key Info for' +
      'mat'
  end
  object Button1: TButton
    Left = 40
    Top = 48
    Width = 75
    Height = 25
    Caption = 'Convert'
    TabOrder = 0
    OnClick = Button1Click
  end
end
