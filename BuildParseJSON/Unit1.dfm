object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'How to Build and Parse JSON String'
  ClientHeight = 289
  ClientWidth = 518
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object btnBuildJSON: TButton
    Left = 56
    Top = 32
    Width = 169
    Height = 25
    Caption = 'Build JSON String'
    TabOrder = 0
    OnClick = btnBuildJSONClick
  end
  object Memo1: TMemo
    Left = 8
    Top = 63
    Width = 497
    Height = 210
    Lines.Strings = (
      '{"data": {'
      '  "job": {'
      '    "reference_id":  "ID32048",'
      '    "status_code": "10",'
      '    "status_name": "New Job"'
      '    }'
      '  }'
      '}')
    TabOrder = 1
  end
  object btnParseJSON: TButton
    Left = 296
    Top = 32
    Width = 169
    Height = 25
    Caption = 'Parse JSON String'
    TabOrder = 2
    OnClick = btnParseJSONClick
  end
end
