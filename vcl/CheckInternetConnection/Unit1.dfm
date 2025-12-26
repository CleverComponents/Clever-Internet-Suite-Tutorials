object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Check Internet Connection'
  ClientHeight = 108
  ClientWidth = 382
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 24
    Width = 19
    Height = 13
    Caption = 'URL'
  end
  object lblStatus: TLabel
    Left = 240
    Top = 61
    Width = 12
    Height = 13
    Caption = '...'
  end
  object btnCheckConnection: TButton
    Left = 56
    Top = 56
    Width = 169
    Height = 25
    Caption = 'Check Internet Connection'
    TabOrder = 0
    OnClick = btnCheckConnectionClick
  end
  object edtUrl: TEdit
    Left = 56
    Top = 21
    Width = 281
    Height = 21
    TabOrder = 1
    Text = 'https://www.google.com'
  end
end
