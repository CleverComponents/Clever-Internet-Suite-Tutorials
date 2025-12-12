object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Parse inner HTML'
  ClientHeight = 600
  ClientWidth = 554
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 27
    Width = 48
    Height = 13
    Caption = 'Tag Name'
  end
  object Label2: TLabel
    Left = 24
    Top = 54
    Width = 73
    Height = 13
    Caption = 'Attribute Name'
  end
  object Label3: TLabel
    Left = 24
    Top = 81
    Width = 72
    Height = 13
    Caption = 'Attribute Value'
  end
  object Button1: TButton
    Left = 461
    Top = 76
    Width = 75
    Height = 25
    Caption = 'Parse'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Panel1: TPanel
    Left = 0
    Top = 120
    Width = 554
    Height = 480
    Align = alBottom
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelOuter = bvNone
    TabOrder = 1
    object Splitter1: TSplitter
      Left = 0
      Top = 217
      Width = 554
      Height = 15
      Cursor = crVSplit
      Align = alTop
    end
    object Memo2: TMemo
      Left = 0
      Top = 232
      Width = 554
      Height = 248
      Align = alClient
      Lines.Strings = (
        'Result')
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
    end
    object Memo1: TMemo
      Left = 0
      Top = 0
      Width = 554
      Height = 217
      Align = alTop
      Lines.Strings = (
        '<div class="tvRow tvFirst hasLabel tvFirst" title="*A*">'
        '    <label class="tvLabel">*Car Type:*</label>'
        '    <span class="tvValue">*BMW*</span>'
        '    <div class="clear"></div>'
        '</div>'
        '<div class="tvRow tvFirst hasLabel tvFirst" title="*B*">'
        '    <label class="tvLabel">*Car Type:*</label>'
        '    <span class="tvValue">*MERCEDESS*</span>'
        '    <div class="clear"></div>'
        '</div>'
        '<div class="tvRow tvFirst hasLabel tvFirst" title="*C*">'
        '    <label class="tvLabel">*Car Type:*</label>'
        '    <span class="tvValue">*FERRARI*</span>'
        '    <div class="clear"></div>'
        '</div>')
      ScrollBars = ssVertical
      TabOrder = 1
    end
  end
  object edtTagName: TEdit
    Left = 103
    Top = 24
    Width = 121
    Height = 21
    TabOrder = 2
    Text = 'div'
  end
  object edtAttributeName: TEdit
    Left = 103
    Top = 51
    Width = 121
    Height = 21
    TabOrder = 3
    Text = 'class'
  end
  object edtAttributeValue: TEdit
    Left = 103
    Top = 78
    Width = 330
    Height = 21
    TabOrder = 4
    Text = 'tvRow tvFirst hasLabel tvFirst'
  end
  object clHtmlParser1: TclHtmlParser
    Left = 296
    Top = 424
  end
end
