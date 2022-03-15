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
  OldCreateOrder = False
  DesignSize = (
    658
    425)
  PixelsPerInch = 96
  TextHeight = 13
  object btnLoad: TButton
    Left = 32
    Top = 24
    Width = 113
    Height = 25
    Caption = 'Load Message'
    TabOrder = 0
    OnClick = btnLoadClick
  end
  object btnSave: TButton
    Left = 176
    Top = 24
    Width = 113
    Height = 25
    Caption = 'Save Message'
    TabOrder = 1
    OnClick = btnSaveClick
  end
  object memSource: TMemo
    Left = 24
    Top = 72
    Width = 600
    Height = 330
    Anchors = [akLeft, akTop, akRight, akBottom]
    Constraints.MinHeight = 330
    Constraints.MinWidth = 600
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 2
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
end
