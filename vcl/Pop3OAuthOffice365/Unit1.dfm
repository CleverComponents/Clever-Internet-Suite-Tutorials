object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'POP3 Read from Office365 using OAuth 2.0'
  ClientHeight = 350
  ClientWidth = 512
  Color = clBtnFace
  Constraints.MinHeight = 388
  Constraints.MinWidth = 524
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poScreenCenter
  DesignSize = (
    512
    350)
  TextHeight = 13
  object Label2: TLabel
    Left = 24
    Top = 21
    Width = 22
    Height = 13
    Caption = 'User'
  end
  object Label3: TLabel
    Left = 24
    Top = 58
    Width = 161
    Height = 13
    Caption = 'Messages   (Double-click to Read)'
  end
  object edtUser: TEdit
    Left = 72
    Top = 18
    Width = 201
    Height = 21
    TabOrder = 0
    Text = 'username@live.com'
  end
  object lbMessages: TListBox
    Left = 24
    Top = 88
    Width = 461
    Height = 241
    Anchors = [akLeft, akTop, akRight, akBottom]
    ItemHeight = 13
    TabOrder = 2
    OnDblClick = lbMessagesDblClick
  end
  object btnGetMessageList: TButton
    Left = 352
    Top = 16
    Width = 129
    Height = 25
    Caption = 'Get Message List'
    TabOrder = 1
    OnClick = btnGetMessageListClick
  end
  object clOAuth1: TclOAuth
    UserAgent = 'CleverComponents OAUTH 2.0'
    EnterCodeFormCaption = 'Enter Authorization Code'
    SuccessHtmlResponse = 
      '<html><body><h3 style="color:green;margin:30px">OAuth Authorizat' +
      'ion Successful!</h3></body></html>'
    FailedHtmlResponse = 
      '<html><body><h3 style="color:red;margin:30px">OAuth Authorizatio' +
      'n Failed!</h3></body></html>'
    Left = 168
    Top = 200
  end
  object clPop31: TclPop3
    Left = 248
    Top = 200
  end
  object clMailMessage1: TclMailMessage
    ToList = <>
    CCList = <>
    BCCList = <>
    Date = 46048.960680520830000000
    CharSet = 'iso-8859-1'
    ContentType = 'text/plain'
    Left = 336
    Top = 200
  end
end
