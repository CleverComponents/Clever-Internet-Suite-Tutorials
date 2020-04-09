object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 559
  ClientWidth = 554
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 208
    Top = 472
    Width = 75
    Height = 25
    Caption = 'Parse'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 0
    Top = -1
    Width = 553
    Height = 186
    Lines.Strings = (
      '<div class="tvRow tvFirst hasLabel tvFirst" title="*A*">'
      '<label class="tvLabel">*Car Type:*</label>'
      '<span class="tvValue">*BMW*</span>'
      '<div class="clear"></div></div>'
      '<div class="tvRow tvFirst hasLabel tvFirst" title="*B*">'
      '<label class="tvLabel">*Car Type:*</label>'
      '<span class="tvValue">*MERCEDESS*</span>'
      '<div class="clear"></div></div>'
      '<div class="tvRow tvFirst hasLabel tvFirst" title="*C*">'
      '<label class="tvLabel">*Car Type:*</label>'
      '<span class="tvValue">*FERRARI*</span>'
      '<div class="clear"></div></div>')
    TabOrder = 1
  end
  object Memo2: TMemo
    Left = 0
    Top = 208
    Width = 553
    Height = 249
    Lines.Strings = (
      'Result')
    TabOrder = 2
  end
  object clHtmlParser1: TclHtmlParser
    Left = 128
    Top = 472
  end
end
