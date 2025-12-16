object Form1: TForm1
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'HttpServer, handling form-field requests'
  ClientHeight = 389
  ClientWidth = 479
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 13
  object btnStart: TButton
    Left = 24
    Top = 24
    Width = 75
    Height = 25
    Caption = 'Start'
    TabOrder = 0
    OnClick = btnStartClick
  end
  object btnStop: TButton
    Left = 136
    Top = 24
    Width = 75
    Height = 25
    Caption = 'Stop'
    TabOrder = 1
    OnClick = btnStopClick
  end
  object memLog: TMemo
    Left = 0
    Top = 64
    Width = 479
    Height = 325
    Align = alBottom
    Lines.Strings = (
      'memLog')
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object clHttpServer1: TclHttpServer
    ServerName = 'Clever Internet Suite HTTP service'
    Port = 2110
    OnStart = clHttpServer1Start
    OnStop = clHttpServer1Stop
    UseTLS = stNone
    OnReceiveRequest = clHttpServer1ReceiveRequest
    Left = 272
    Top = 24
  end
end
