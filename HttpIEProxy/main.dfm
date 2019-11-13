object Form1: TForm1
  Left = 269
  Top = 167
  Caption = 'HTTP GET demo, working with Proxy'
  ClientHeight = 405
  ClientWidth = 454
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 454
    Height = 207
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 32
      Width = 22
      Height = 13
      Caption = 'URL'
    end
    object Label2: TLabel
      Left = 16
      Top = 8
      Width = 386
      Height = 13
      Caption = 
        'Type in the URL and click the '#39'GET'#39' button to retreive the page ' +
        'specified by URL.'
    end
    object Label3: TLabel
      Left = 16
      Top = 56
      Width = 22
      Height = 13
      Caption = 'User'
    end
    object Label4: TLabel
      Left = 192
      Top = 56
      Width = 46
      Height = 13
      Caption = 'Password'
    end
    object Bevel1: TBevel
      Left = 8
      Top = 88
      Width = 441
      Height = 2
    end
    object Label5: TLabel
      Left = 16
      Top = 136
      Width = 31
      Height = 13
      Caption = 'Server'
    end
    object Label6: TLabel
      Left = 375
      Top = 136
      Width = 19
      Height = 13
      Caption = 'Port'
    end
    object Label7: TLabel
      Left = 16
      Top = 160
      Width = 22
      Height = 13
      Caption = 'User'
    end
    object Label8: TLabel
      Left = 192
      Top = 160
      Width = 46
      Height = 13
      Caption = 'Password'
    end
    object Label9: TLabel
      Left = 16
      Top = 101
      Width = 24
      Height = 13
      Caption = 'Type'
    end
    object edtUrl: TEdit
      Left = 56
      Top = 32
      Width = 305
      Height = 21
      TabOrder = 0
      Text = 'https://www.microsoft.com'
    end
    object btnGet: TButton
      Left = 368
      Top = 32
      Width = 73
      Height = 25
      Caption = 'GET'
      TabOrder = 1
      OnClick = btnGetClick
    end
    object cbShowText: TCheckBox
      Left = 56
      Top = 184
      Width = 97
      Height = 17
      Caption = 'Show text only'
      TabOrder = 10
    end
    object edtUser: TEdit
      Left = 56
      Top = 56
      Width = 113
      Height = 21
      TabOrder = 2
    end
    object edtPassword: TEdit
      Left = 248
      Top = 56
      Width = 113
      Height = 21
      TabOrder = 3
    end
    object edtProxyServer: TEdit
      Left = 56
      Top = 133
      Width = 305
      Height = 21
      TabOrder = 6
      Text = 'proxyserver'
    end
    object edtProxyPort: TEdit
      Left = 400
      Top = 133
      Width = 41
      Height = 21
      TabOrder = 7
      Text = '8080'
    end
    object edtProxyUser: TEdit
      Left = 56
      Top = 160
      Width = 113
      Height = 21
      TabOrder = 8
    end
    object edtProxyPassword: TEdit
      Left = 248
      Top = 160
      Width = 113
      Height = 21
      TabOrder = 9
    end
    object cbProxyType: TComboBox
      Left = 56
      Top = 98
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 4
      Text = 'HTTP Proxy'
      OnChange = cbProxyTypeChange
      Items.Strings = (
        'HTTP Proxy'
        'SOCKS4 Firewall'
        'SOCKS5 Firewall')
    end
    object btnGetIEProxy: TButton
      Left = 296
      Top = 97
      Width = 146
      Height = 25
      Caption = 'Get System Proxy Settings'
      TabOrder = 5
      OnClick = btnGetIEProxyClick
    end
  end
  object memResult: TMemo
    Left = 0
    Top = 207
    Width = 454
    Height = 198
    Align = alClient
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 1
    WordWrap = False
  end
  object clHttp1: TclHttp
    UserAgent = 'Mozilla/4.0 (compatible; Clever Internet Suite 6.0)'
    KeepConnection = False
    Left = 144
    Top = 248
  end
  object clHtmlParser1: TclHtmlParser
    ParseMethod = pmTextOnly
    OnParseTag = clHtmlParser1ParseTag
    Left = 184
    Top = 248
  end
end
