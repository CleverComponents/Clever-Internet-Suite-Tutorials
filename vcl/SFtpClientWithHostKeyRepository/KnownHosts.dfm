object KnownHostsForm: TKnownHostsForm
  Left = 0
  Top = 0
  Caption = 'Edit Known Hosts'
  ClientHeight = 259
  ClientWidth = 482
  Color = clBtnFace
  Constraints.MinHeight = 298
  Constraints.MinWidth = 498
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  DesignSize = (
    482
    259)
  PixelsPerInch = 96
  TextHeight = 13
  object lbKnownHosts: TListBox
    Left = 0
    Top = 0
    Width = 337
    Height = 259
    Align = alLeft
    Anchors = [akLeft, akTop, akRight, akBottom]
    ItemHeight = 13
    TabOrder = 0
  end
  object btnDelete: TButton
    Left = 353
    Top = 8
    Width = 113
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Delete'
    TabOrder = 1
    OnClick = btnDeleteClick
  end
  object btnClear: TButton
    Left = 353
    Top = 39
    Width = 113
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Clear All'
    TabOrder = 2
    OnClick = btnClearClick
  end
  object btnOK: TButton
    Left = 353
    Top = 195
    Width = 113
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 3
  end
  object btnCancel: TButton
    Left = 353
    Top = 226
    Width = 113
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 4
  end
end
