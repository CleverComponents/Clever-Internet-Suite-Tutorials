object Form1: TForm1
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'TLS Server'
  ClientHeight = 292
  ClientWidth = 369
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 13
  object Label1: TLabel
    Left = 32
    Top = 24
    Width = 20
    Height = 13
    Caption = 'Port'
  end
  object Label2: TLabel
    Left = 32
    Top = 56
    Width = 17
    Height = 13
    Caption = 'Log'
  end
  object edtPort: TEdit
    Left = 69
    Top = 21
    Width = 76
    Height = 21
    TabOrder = 0
    Text = '2110'
  end
  object btnStart: TButton
    Left = 168
    Top = 19
    Width = 75
    Height = 25
    Caption = 'Start'
    TabOrder = 1
    OnClick = btnStartClick
  end
  object btnStop: TButton
    Left = 266
    Top = 19
    Width = 75
    Height = 25
    Caption = 'Stop'
    TabOrder = 2
    OnClick = btnStopClick
  end
  object memLog: TMemo
    Left = 0
    Top = 77
    Width = 369
    Height = 215
    Align = alBottom
    ScrollBars = ssVertical
    TabOrder = 3
    ExplicitTop = 76
    ExplicitWidth = 365
  end
end
