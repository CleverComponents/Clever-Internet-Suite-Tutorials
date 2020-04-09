object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Setting Up HTTP Proxy Parameters in TCP-based Client Components'
  ClientHeight = 297
  ClientWidth = 568
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object btnDownloader: TButton
    Left = 400
    Top = 40
    Width = 137
    Height = 25
    Caption = 'Downloader'
    TabOrder = 0
    OnClick = btnDownloaderClick
  end
  object btnHttp: TButton
    Left = 400
    Top = 104
    Width = 137
    Height = 25
    Caption = 'HTTP Client'
    TabOrder = 1
    OnClick = btnHttpClick
  end
  object btnFtpProxy: TButton
    Left = 400
    Top = 168
    Width = 137
    Height = 25
    Caption = 'FTP Client'
    TabOrder = 2
    OnClick = btnFtpProxyClick
  end
  object btnSmtp: TButton
    Left = 400
    Top = 232
    Width = 137
    Height = 25
    Caption = 'SMTP Client'
    TabOrder = 3
    OnClick = btnSmtpClick
  end
  object clMultiDownLoader1: TclMultiDownLoader
    InternetAgent = 'Mozilla/4.0 (compatible; Clever Internet Suite)'
    DownLoadList = <>
    Left = 200
    Top = 32
  end
  object clMultiUploader1: TclMultiUploader
    InternetAgent = 'Mozilla/4.0 (compatible; Clever Internet Suite)'
    UploadList = <>
    PublishFileMask = '*.*'
    Left = 304
    Top = 32
  end
  object clDownLoader1: TclDownLoader
    InternetAgent = 'Mozilla/4.0 (compatible; Clever Internet Suite)'
    Left = 32
    Top = 32
  end
  object clUploader1: TclUploader
    InternetAgent = 'Mozilla/4.0 (compatible; Clever Internet Suite)'
    RequestMethod = 'PUT'
    Left = 112
    Top = 32
  end
  object clHttp1: TclHttp
    UserAgent = 'Mozilla/4.0 (compatible; Clever Internet Suite)'
    Left = 304
    Top = 104
  end
  object clFtp1: TclFtp
    Left = 304
    Top = 168
  end
  object clHttpProxy1: TclHttpProxy
    UserAgent = 'Mozilla/4.0 (compatible; Clever Internet Suite)'
    Left = 304
    Top = 224
  end
  object clSmtp1: TclSmtp
    MailAgent = 'Clever Internet Suite'
    Left = 240
    Top = 224
  end
end
