object Form1: TForm1
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'TLS Client'
  ClientHeight = 297
  ClientWidth = 377
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
    Width = 32
    Height = 13
    Caption = 'Server'
  end
  object Label2: TLabel
    Left = 24
    Top = 51
    Width = 20
    Height = 13
    Caption = 'Port'
  end
  object btnConnect: TButton
    Left = 280
    Top = 19
    Width = 75
    Height = 25
    Caption = 'Connect'
    TabOrder = 0
    OnClick = btnConnectClick
  end
  object edtServer: TEdit
    Left = 80
    Top = 21
    Width = 169
    Height = 21
    TabOrder = 1
    Text = 'localhost'
  end
  object edtPort: TEdit
    Left = 80
    Top = 48
    Width = 65
    Height = 21
    TabOrder = 2
    Text = '2110'
  end
  object edtData: TEdit
    Left = 24
    Top = 88
    Width = 225
    Height = 21
    TabOrder = 3
    Text = 'Sample Data'
  end
  object btnDisconnect: TButton
    Left = 280
    Top = 50
    Width = 75
    Height = 25
    Caption = 'Disconnect'
    TabOrder = 4
    OnClick = btnDisconnectClick
  end
  object btnSend: TButton
    Left = 280
    Top = 88
    Width = 75
    Height = 25
    Caption = 'Send'
    TabOrder = 5
    OnClick = btnSendClick
  end
  object memLog: TMemo
    Left = 0
    Top = 136
    Width = 377
    Height = 161
    Align = alBottom
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 6
    ExplicitTop = 135
    ExplicitWidth = 373
  end
end
