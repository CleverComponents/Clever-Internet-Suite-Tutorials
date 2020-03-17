object Form1: TForm1
  Left = 192
  Top = 114
  Caption = 'Form1'
  ClientHeight = 309
  ClientWidth = 405
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 8
    Width = 31
    Height = 13
    Caption = 'Server'
  end
  object Label2: TLabel
    Left = 16
    Top = 32
    Width = 22
    Height = 13
    Caption = 'User'
  end
  object Label3: TLabel
    Left = 16
    Top = 56
    Width = 46
    Height = 13
    Caption = 'Password'
  end
  object edtServer: TEdit
    Left = 72
    Top = 8
    Width = 313
    Height = 21
    TabOrder = 0
    Text = 'localhost'
  end
  object edtUser: TEdit
    Left = 72
    Top = 32
    Width = 185
    Height = 21
    TabOrder = 1
    Text = 'john'
  end
  object edtPassword: TEdit
    Left = 72
    Top = 56
    Width = 185
    Height = 21
    PasswordChar = '*'
    TabOrder = 2
    Text = '12345'
  end
  object btnReceive: TButton
    Left = 56
    Top = 88
    Width = 75
    Height = 25
    Caption = 'Receive'
    TabOrder = 3
    OnClick = btnReceiveClick
  end
  object ListBox1: TListBox
    Left = 16
    Top = 120
    Width = 361
    Height = 169
    ItemHeight = 13
    TabOrder = 4
  end
  object btnReply: TButton
    Left = 152
    Top = 88
    Width = 75
    Height = 25
    Caption = 'Reply'
    TabOrder = 5
    OnClick = btnReplyClick
  end
  object btnForward: TButton
    Left = 248
    Top = 88
    Width = 75
    Height = 25
    Caption = 'Forward'
    TabOrder = 6
    OnClick = btnForwardClick
  end
  object clPop31: TclPop3
    TLSFlags = []
    Left = 56
    Top = 136
  end
  object clSmtp1: TclSmtp
    TLSFlags = []
    MailAgent = 'Clever Internet Suite v 6.0'
    Left = 96
    Top = 136
  end
  object clMailMessage1: TclMailMessage
    ToList = <>
    CCList = <>
    BCCList = <>
    Date = 38873.974187083300000000
    CharSet = 'iso-8859-1'
    ContentType = 'text/plain'
    MimeOLE = 'Produced By Clever Internet Suite MimeOLE v 6.0'
    Left = 136
    Top = 136
  end
  object clHtmlParser1: TclHtmlParser
    ParseMethod = pmAll
    IncludeClosingTags = True
    Left = 176
    Top = 136
  end
  object clHtmlTextParser2: TclHtmlParser
    ParseMethod = pmTextOnly
    OnParseTag = clHtmlTextParser2ParseTag
    Left = 216
    Top = 136
  end
end
