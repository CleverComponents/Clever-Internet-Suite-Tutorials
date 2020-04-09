object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 558
  ClientWidth = 661
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object btnAuthorize: TButton
    Left = 8
    Top = 440
    Width = 75
    Height = 25
    Caption = 'Authorize'
    TabOrder = 0
    OnClick = btnAuthorizeClick
  end
  object WebBrowser1: TWebBrowser
    Left = 8
    Top = 8
    Width = 645
    Height = 417
    TabOrder = 1
    OnDocumentComplete = WebBrowser1DocumentComplete
    ControlData = {
      4C000000AA420000192B00000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
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
    OnLaunchBrowser = clOAuth1LaunchBrowser
    OnShowEnterCodeForm = clOAuth1ShowEnterCodeForm
    Left = 152
    Top = 248
  end
  object clHttpRequest1: TclHttpRequest
    Header.Accept = '*/*'
    Left = 240
    Top = 248
  end
end
