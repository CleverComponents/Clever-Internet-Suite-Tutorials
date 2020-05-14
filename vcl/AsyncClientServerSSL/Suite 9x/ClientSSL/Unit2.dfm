object Form2: TForm2
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'SSL Client'
  ClientHeight = 274
  ClientWidth = 356
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
  object Label1: TLabel
    Left = 16
    Top = 24
    Width = 32
    Height = 13
    Caption = 'Server'
  end
  object Label2: TLabel
    Left = 16
    Top = 56
    Width = 20
    Height = 13
    Caption = 'Port'
  end
  object edtServer: TEdit
    Left = 64
    Top = 21
    Width = 177
    Height = 21
    TabOrder = 0
    Text = 'localhost'
  end
  object edtPort: TEdit
    Left = 64
    Top = 53
    Width = 65
    Height = 21
    TabOrder = 1
    Text = '9002'
  end
  object btnConnect: TButton
    Left = 263
    Top = 19
    Width = 75
    Height = 25
    Caption = 'Connect'
    TabOrder = 2
    OnClick = btnConnectClick
  end
  object btnDisconnect: TButton
    Left = 264
    Top = 50
    Width = 75
    Height = 25
    Caption = 'Disconnect'
    TabOrder = 3
    OnClick = btnDisconnectClick
  end
  object edtData: TEdit
    Left = 16
    Top = 88
    Width = 225
    Height = 21
    TabOrder = 4
    Text = 'Sample data'
  end
  object btnSend: TButton
    Left = 264
    Top = 86
    Width = 75
    Height = 25
    Caption = 'Send'
    TabOrder = 5
    OnClick = btnSendClick
  end
  object memResponse: TMemo
    Left = 0
    Top = 128
    Width = 356
    Height = 146
    Align = alBottom
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 6
  end
  object clAsyncClient1: TclAsyncClient
    Port = 0
    TLSFlags = []
    OnRead = clAsyncClient1Read
    Left = 64
    Top = 144
  end
end
