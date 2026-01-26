object frmMessage: TfrmMessage
  Left = 0
  Top = 0
  Caption = 'Message'
  ClientHeight = 400
  ClientWidth = 600
  Color = clBtnFace
  Constraints.MinHeight = 438
  Constraints.MinWidth = 612
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poScreenCenter
  DesignSize = (
    600
    400)
  TextHeight = 13
  object lblSubject: TLabel
    Left = 8
    Top = 65
    Width = 40
    Height = 13
    Caption = 'Subject:'
  end
  object lblFrom: TLabel
    Left = 8
    Top = 11
    Width = 28
    Height = 13
    Caption = 'From:'
  end
  object lblTo: TLabel
    Left = 8
    Top = 38
    Width = 16
    Height = 13
    Caption = 'To:'
  end
  object memBody: TMemo
    Left = 8
    Top = 96
    Width = 584
    Height = 265
    Anchors = [akLeft, akTop, akRight, akBottom]
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 3
  end
  object btnClose: TButton
    Left = 517
    Top = 367
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Close'
    TabOrder = 4
    OnClick = btnCloseClick
  end
  object edtSubject: TEdit
    Left = 54
    Top = 62
    Width = 538
    Height = 21
    ReadOnly = True
    TabOrder = 2
  end
  object edtFrom: TEdit
    Left = 54
    Top = 8
    Width = 538
    Height = 21
    ReadOnly = True
    TabOrder = 0
  end
  object edtToList: TEdit
    Left = 54
    Top = 35
    Width = 538
    Height = 21
    ReadOnly = True
    TabOrder = 1
  end
end
