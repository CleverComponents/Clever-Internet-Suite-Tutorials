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
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 112
    Top = 68
    Width = 75
    Height = 25
    Caption = 'Parse'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 2
    Top = 99
    Width = 551
    Height = 134
    Lines.Strings = (
      '<table border=1 bgcolor="#EOEOEO">'
      '<tr align=left>'
      
        '<th Width=608 HEIGHT=35><FONT SIZE="+1">&nbsp;&nbsp;Schedules fo' +
        'r&nbsp;JOHN&nbsp;DOE</FONT>'
      
        '&nbsp;&nbsp;&nbsp;<INPUT TYPE="submit" STYLE="font-family:arial;' +
        'width=120px" NAME="punch" '
      'VALUE="View Punches" onClick="resetSession()">'
      
        '&nbsp;&nbsp;<INPUT TYPE="button" STYLE="font-family:arial" VALUE' +
        '=" Cancel " '
      'OnClick='#39'window.location.href="logout.asp"'#39'></th>'
      '</tr>'
      '<tr>'
      '<td><FONT SIZE="+1">&nbsp;&nbsp;10:00</FONT>'
      '&nbsp;&nbsp;&nbsp;</td>'
      '</tr></table>')
    ScrollBars = ssVertical
    TabOrder = 1
    WordWrap = False
  end
  object Memo2: TMemo
    Left = 2
    Top = 256
    Width = 550
    Height = 190
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object clHtmlParser1: TclHtmlParser
    Left = 136
    Top = 24
  end
end
