object frmOpenAIChat: TfrmOpenAIChat
  Left = 0
  Top = 0
  Caption = 'Delphi OpenAI GPT Chat'
  ClientHeight = 600
  ClientWidth = 900
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 17
  object pnlBottom: TPanel
    Left = 0
    Top = 470
    Width = 900
    Height = 130
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitTop = 469
    ExplicitWidth = 896
    object btnSend: TButton
      Left = 800
      Top = 0
      Width = 100
      Height = 130
      Align = alRight
      Caption = 'Send'
      TabOrder = 0
      OnClick = btnSendClick
      ExplicitLeft = 796
    end
    object memPrompt: TMemo
      Left = 0
      Top = 0
      Width = 800
      Height = 130
      Align = alClient
      ScrollBars = ssVertical
      TabOrder = 1
      WantTabs = True
      OnKeyDown = memPromptKeyDown
      ExplicitWidth = 796
    end
  end
  object memHistory: TMemo
    Left = 0
    Top = 0
    Width = 900
    Height = 470
    Align = alClient
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 1
    WantTabs = True
    ExplicitWidth = 896
    ExplicitHeight = 469
  end
end
