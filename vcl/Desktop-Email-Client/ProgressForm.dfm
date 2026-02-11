object frmProgress: TfrmProgress
  Left = 261
  Top = 62
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Progress'
  ClientHeight = 76
  ClientWidth = 310
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object lblMessage: TLabel
    Left = 10
    Top = 8
    Width = 53
    Height = 13
    Caption = 'lblMessage'
  end
  object ProgressBar: TProgressBar
    Left = 8
    Top = 26
    Width = 293
    Height = 17
    Max = 1
    Step = 1
    TabOrder = 0
  end
  object btnStop: TButton
    Left = 120
    Top = 48
    Width = 72
    Height = 22
    Caption = 'Stop'
    TabOrder = 1
    OnClick = btnStopClick
  end
end
