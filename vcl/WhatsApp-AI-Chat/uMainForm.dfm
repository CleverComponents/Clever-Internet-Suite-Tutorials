object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'WhatsApp AI Chatbot'
  ClientHeight = 500
  ClientWidth = 700
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    700
    500)
  TextHeight = 15
  object lblPort: TLabel
    Left = 16
    Top = 16
    Width = 22
    Height = 15
    Caption = 'Port'
  end
  object edtPort: TEdit
    Left = 56
    Top = 12
    Width = 80
    Height = 23
    TabOrder = 0
    Text = '5000'
  end
  object btnStart: TButton
    Left = 160
    Top = 10
    Width = 75
    Height = 25
    Caption = 'Start'
    TabOrder = 1
    OnClick = btnStartClick
  end
  object btnStop: TButton
    Left = 248
    Top = 10
    Width = 75
    Height = 25
    Caption = 'Stop'
    TabOrder = 2
    OnClick = btnStopClick
  end
  object memLog: TMemo
    Left = 16
    Top = 48
    Width = 668
    Height = 430
    Anchors = [akLeft, akTop, akRight, akBottom]
    ScrollBars = ssVertical
    TabOrder = 4
    ExplicitWidth = 664
    ExplicitHeight = 429
  end
  object btnTestReply: TButton
    Left = 609
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Test Reply'
    TabOrder = 3
    OnClick = btnTestReplyClick
  end
  object HttpServer: TclHttpServer
    ServerName = 'Clever Internet Suite HTTP service'
    UseTLS = stNone
    OnReceiveRequest = HttpServerReceiveRequest
    Left = 416
    Top = 8
  end
end
