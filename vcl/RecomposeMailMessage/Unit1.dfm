object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Recompose the MailMessage Content'
  ClientHeight = 425
  ClientWidth = 658
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  DesignSize = (
    658
    425)
  TextHeight = 13
  object btnLoad: TButton
    Left = 327
    Top = 22
    Width = 113
    Height = 28
    Caption = 'Load Message'
    TabOrder = 3
    OnClick = btnLoadClick
  end
  object btnSave: TButton
    Left = 465
    Top = 22
    Width = 113
    Height = 28
    Caption = 'Save Message'
    TabOrder = 4
    OnClick = btnSaveClick
  end
  object memSource: TMemo
    Left = 24
    Top = 72
    Width = 600
    Height = 330
    Anchors = [akLeft, akTop, akRight, akBottom]
    Constraints.MinHeight = 329
    Constraints.MinWidth = 596
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 5
  end
  object btnCreate: TButton
    Left = 183
    Top = 22
    Width = 113
    Height = 28
    Caption = 'Create Message'
    TabOrder = 2
    OnClick = btnCreateClick
  end
  object rbUseMailMessage: TRadioButton
    Left = 24
    Top = 17
    Width = 113
    Height = 16
    Caption = 'Use Mail Message'
    TabOrder = 0
  end
  object rbUseSMime: TRadioButton
    Left = 24
    Top = 38
    Width = 113
    Height = 16
    Caption = 'Use S/MIME'
    Checked = True
    TabOrder = 1
    TabStop = True
  end
  object clMailMessage1: TclMailMessage
    ToList = <>
    CCList = <>
    BCCList = <>
    Date = 44636.001178009260000000
    CharSet = 'iso-8859-1'
    ContentType = 'text/plain'
    OnSaveAttachment = clMailMessage1SaveAttachment
    OnLoadAttachment = clMailMessage1LoadAttachment
    OnAttachmentSaved = clMailMessage1AttachmentSaved
    Left = 160
    Top = 176
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '*.eml'
    Filter = 'MIME|*.eml|All|*.*'
    Left = 272
    Top = 176
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = '*.eml'
    Filter = 'MIME|*.eml|All|*.*'
    Left = 360
    Top = 176
  end
  object clSMimeMessage1: TclSMimeMessage
    ToList = <>
    CCList = <>
    BCCList = <>
    Date = 44636.500530208330000000
    CharSet = 'iso-8859-1'
    ContentType = 'text/plain'
    OnSaveAttachment = clMailMessage1SaveAttachment
    OnLoadAttachment = clMailMessage1LoadAttachment
    OnAttachmentSaved = clMailMessage1AttachmentSaved
    Config.SignAlgorithmName = 'sha-512'
    Config.SignAlgorithm = '2.16.840.1.101.3.4.2.3'
    Config.EncryptAlgorithm = '2.16.840.1.101.3.4.1.2'
    Left = 160
    Top = 240
  end
end
