object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'HttpServer, handling form-field requests'
  ClientHeight = 289
  ClientWidth = 306
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object btnStart: TButton
    Left = 88
    Top = 144
    Width = 75
    Height = 25
    Caption = 'Start'
    TabOrder = 0
    OnClick = btnStartClick
  end
  object btnStop: TButton
    Left = 208
    Top = 144
    Width = 75
    Height = 25
    Caption = 'Stop'
    TabOrder = 1
    OnClick = btnStopClick
  end
  object clHttpServer1: TclHttpServer
    ServerName = 'Clever Internet Suite HTTP service'
    OnReceiveRequest = clHttpServer1ReceiveRequest
    Left = 112
    Top = 64
  end
end
