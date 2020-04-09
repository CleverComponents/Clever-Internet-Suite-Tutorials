object Form1: TForm1
  Left = 192
  Top = 114
  BorderStyle = bsSingle
  Caption = 'Form1'
  ClientHeight = 302
  ClientWidth = 449
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
    Top = 11
    Width = 59
    Height = 13
    Caption = 'Server Pop3'
  end
  object Label2: TLabel
    Left = 16
    Top = 65
    Width = 22
    Height = 13
    Caption = 'User'
  end
  object Label3: TLabel
    Left = 16
    Top = 94
    Width = 46
    Height = 13
    Caption = 'Password'
  end
  object Label4: TLabel
    Left = 16
    Top = 38
    Width = 19
    Height = 13
    Caption = 'Port'
  end
  object Label5: TLabel
    Left = 232
    Top = 11
    Width = 58
    Height = 13
    Caption = 'Server Smtp'
  end
  object Label6: TLabel
    Left = 232
    Top = 38
    Width = 19
    Height = 13
    Caption = 'Port'
  end
  object edtServer: TEdit
    Left = 88
    Top = 8
    Width = 129
    Height = 21
    TabOrder = 0
    Text = 'localhost'
  end
  object edtUser: TEdit
    Left = 88
    Top = 62
    Width = 129
    Height = 21
    TabOrder = 1
    Text = 'john'
  end
  object edtPassword: TEdit
    Left = 88
    Top = 89
    Width = 129
    Height = 21
    PasswordChar = '*'
    TabOrder = 2
    Text = '12345'
  end
  object btnReceive: TButton
    Left = 247
    Top = 89
    Width = 58
    Height = 25
    Caption = 'Receive'
    TabOrder = 3
    OnClick = btnReceiveClick
  end
  object ListBox1: TListBox
    Left = 16
    Top = 120
    Width = 417
    Height = 169
    ItemHeight = 13
    TabOrder = 4
  end
  object btnReply: TButton
    Left = 311
    Top = 89
    Width = 58
    Height = 25
    Caption = 'Reply'
    TabOrder = 5
    OnClick = btnReplyClick
  end
  object btnForward: TButton
    Left = 375
    Top = 89
    Width = 58
    Height = 25
    Caption = 'Forward'
    TabOrder = 6
    OnClick = btnForwardClick
  end
  object edtPort: TEdit
    Left = 88
    Top = 35
    Width = 89
    Height = 21
    TabOrder = 7
  end
  object edtServerSmtp: TEdit
    Left = 304
    Top = 8
    Width = 129
    Height = 21
    TabOrder = 8
    Text = 'localhost'
  end
  object edtPortSmtp: TEdit
    Left = 304
    Top = 35
    Width = 89
    Height = 21
    TabOrder = 9
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
