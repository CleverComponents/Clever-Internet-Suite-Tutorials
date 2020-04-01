object MessageForm: TMessageForm
  Left = 192
  Top = 114
  Anchors = [akLeft, akTop, akRight, akBottom]
  BorderStyle = bsDialog
  Caption = 'MessageForm'
  ClientHeight = 363
  ClientWidth = 448
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    448
    363)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 23
    Height = 13
    Caption = 'From'
  end
  object Label2: TLabel
    Left = 8
    Top = 32
    Width = 13
    Height = 13
    Caption = 'To'
  end
  object Label3: TLabel
    Left = 8
    Top = 56
    Width = 36
    Height = 13
    Caption = 'Subject'
  end
  object edtFrom: TEdit
    Left = 56
    Top = 8
    Width = 385
    Height = 21
    TabOrder = 0
    Text = 'john@company.mail'
  end
  object edtTo: TEdit
    Left = 56
    Top = 32
    Width = 385
    Height = 21
    TabOrder = 1
  end
  object edtSubject: TEdit
    Left = 56
    Top = 56
    Width = 385
    Height = 21
    TabOrder = 2
  end
  object memText: TMemo
    Left = 6
    Top = 131
    Width = 434
    Height = 224
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelEdges = []
    ScrollBars = ssBoth
    TabOrder = 3
  end
  object Button1: TButton
    Left = 8
    Top = 83
    Width = 91
    Height = 42
    Caption = 'Send'
    Default = True
    ModalResult = 1
    TabOrder = 4
  end
  object Button2: TButton
    Left = 350
    Top = 83
    Width = 91
    Height = 42
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 5
  end
end
