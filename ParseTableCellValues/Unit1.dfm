object Form1: TForm1
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Parse HTML table text'
  ClientHeight = 454
  ClientWidth = 560
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 2
    Top = 192
    Width = 103
    Height = 33
    Caption = 'Parse'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 2
    Top = 8
    Width = 550
    Height = 169
    Lines.Strings = (
      '<table border=1 bgcolor="#EOEOEO">'
      '<tr align=left>'
      
        '<th Width=608 HEIGHT=35><FONT SIZE="+1">  Schedules for JOHN Smi' +
        'th</FONT>'
      
        '   <INPUT TYPE="submit" STYLE="font-family:arial;width=120px" NA' +
        'ME="punch" '
      'VALUE="View Punches" onClick="resetSession()">'
      
        '  <INPUT TYPE="button" STYLE="font-family:arial" VALUE=" Cancel ' +
        '" '
      'OnClick='#39'window.location.href="logout.asp"'#39'></th>'
      '</tr>'
      '<tr>'
      '<td><FONT SIZE="+1"> 10:00</FONT>'
      '  </td>'
      '</tr></table>')
    ScrollBars = ssVertical
    TabOrder = 0
    WordWrap = False
  end
  object Memo2: TMemo
    Left = 2
    Top = 240
    Width = 550
    Height = 206
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object clHtmlParser1: TclHtmlParser
    Left = 440
    Top = 296
  end
end
