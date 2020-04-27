object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Data Url Embedding'
  ClientHeight = 403
  ClientWidth = 445
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 330
    Width = 68
    Height = 13
    Caption = 'Images Folder'
  end
  object memHtml: TMemo
    Left = 8
    Top = 8
    Width = 425
    Height = 313
    Lines.Strings = (
      '<html>'
      '<head>'
      '<title>Test inline images</title>'
      '</head>'
      '<body data-gr-c-s-loaded="true">'
      '<img '
      'src="data:image/gif;base64,R0lGODlhEAAOALMAAOaz'
      'ToeHh0tLS/7LZv/0jvb29t/f3//Ub//ge8WSLf/rhf/3kdbW1'
      'mxsbP//mf///yH5BAAAAAAALAAAAAAQAA4AAARe8L1E'
      'kyky67QZ1hLnjM5UUde0ECwLJoExKcppV0aCcGCmTIHE'
      'IUEqjgaORCMxIC6e0CcguWw6aFjsVMkkIr7g77ZKPJjPZ'
      'qIyd7sJAgVGoEGv2xsBxqNgYPj/gAwXEQA7" '
      'width="16" height="14" alt="embedded folder icon">'
      '</body>'
      '</html')
    TabOrder = 0
  end
  object btnEncode: TButton
    Left = 344
    Top = 360
    Width = 89
    Height = 33
    Caption = 'Encode'
    TabOrder = 1
    OnClick = btnEncodeClick
  end
  object btnDecode: TButton
    Left = 8
    Top = 360
    Width = 89
    Height = 33
    Caption = 'Decode'
    TabOrder = 2
    OnClick = btnDecodeClick
  end
  object edtImagesFolder: TEdit
    Left = 82
    Top = 327
    Width = 351
    Height = 21
    TabOrder = 3
  end
  object clHtmlParser1: TclHtmlParser
    Left = 296
    Top = 355
  end
  object clEncoder1: TclEncoder
    Left = 128
    Top = 355
  end
end
