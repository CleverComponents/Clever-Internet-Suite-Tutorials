object MessageForm: TMessageForm
  Left = 192
  Top = 114
  Caption = 'MessageForm'
  ClientHeight = 377
  ClientWidth = 541
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    541
    377)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 23
    Height = 13
    Caption = 'From'
  end
  object Label2: TLabel
    Left = 16
    Top = 40
    Width = 13
    Height = 13
    Caption = 'To'
  end
  object Label3: TLabel
    Left = 16
    Top = 64
    Width = 36
    Height = 13
    Caption = 'Subject'
  end
  object edtFrom: TEdit
    Left = 64
    Top = 16
    Width = 385
    Height = 21
    TabOrder = 0
    Text = 'john@company.mail'
  end
  object edtTo: TEdit
    Left = 64
    Top = 40
    Width = 385
    Height = 21
    TabOrder = 1
  end
  object edtSubject: TEdit
    Left = 64
    Top = 64
    Width = 385
    Height = 21
    TabOrder = 2
  end
  object memText: TMemo
    Left = 16
    Top = 144
    Width = 505
    Height = 217
    Anchors = [akLeft, akTop, akRight, akBottom]
    ScrollBars = ssBoth
    TabOrder = 3
  end
  object Button1: TButton
    Left = 64
    Top = 104
    Width = 75
    Height = 25
    Caption = 'Send'
    Default = True
    ModalResult = 1
    TabOrder = 4
  end
  object Button2: TButton
    Left = 176
    Top = 104
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 5
  end
end
