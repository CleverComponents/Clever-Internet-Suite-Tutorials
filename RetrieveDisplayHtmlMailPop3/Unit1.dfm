object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Retrieve and Display HTML Mail via POP3'
  ClientHeight = 406
  ClientWidth = 597
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 61
    Height = 13
    Caption = 'POP3 Server'
  end
  object Label2: TLabel
    Left = 16
    Top = 48
    Width = 22
    Height = 13
    Caption = 'User'
  end
  object Label3: TLabel
    Left = 336
    Top = 48
    Width = 46
    Height = 13
    Caption = 'Password'
  end
  object Label4: TLabel
    Left = 16
    Top = 91
    Width = 30
    Height = 13
    Caption = 'Folder'
  end
  object Label5: TLabel
    Left = 16
    Top = 128
    Width = 35
    Height = 13
    Caption = 'Msg No'
  end
  object btnRetrieve: TButton
    Left = 424
    Top = 123
    Width = 153
    Height = 25
    Caption = 'Retrieve'
    TabOrder = 0
    OnClick = btnRetrieveClick
  end
  object WebBrowser1: TWebBrowser
    Left = 16
    Top = 165
    Width = 561
    Height = 225
    TabOrder = 1
    ControlData = {
      4C000000FB390000411700000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object edtServer: TEdit
    Left = 104
    Top = 13
    Width = 473
    Height = 21
    TabOrder = 2
    Text = 'pop.domain.com'
  end
  object edtUserName: TEdit
    Left = 104
    Top = 45
    Width = 153
    Height = 21
    TabOrder = 3
    Text = 'user'
  end
  object edtPassword: TEdit
    Left = 424
    Top = 45
    Width = 153
    Height = 21
    PasswordChar = '*'
    TabOrder = 4
    Text = 'secret'
  end
  object edtFolder: TEdit
    Left = 104
    Top = 88
    Width = 473
    Height = 21
    TabOrder = 5
    Text = 'c:\downloads\'
  end
  object edtMsgNo: TEdit
    Left = 104
    Top = 125
    Width = 153
    Height = 21
    TabOrder = 6
    Text = '1'
  end
  object clPop31: TclPop3
    Left = 296
    Top = 225
  end
  object clMailMessage1: TclMailMessage
    ToList = <>
    CCList = <>
    BCCList = <>
    Date = 43783.840345995370000000
    CharSet = 'iso-8859-1'
    ContentType = 'text/plain'
    OnSaveAttachment = clMailMessage1SaveAttachment
    Left = 392
    Top = 225
  end
end
