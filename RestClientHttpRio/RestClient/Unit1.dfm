object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Rest Client Htttp Rio'
  ClientHeight = 140
  ClientWidth = 398
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 401
    Height = 145
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 16
      Width = 76
      Height = 13
      Caption = 'Temperature, C'
    end
    object Label2: TLabel
      Left = 16
      Top = 60
      Width = 75
      Height = 13
      Caption = 'Temperature, F'
    end
    object edtCelsius: TEdit
      Left = 112
      Top = 13
      Width = 121
      Height = 21
      TabOrder = 0
    end
    object edtFahrenheit: TEdit
      Left = 112
      Top = 57
      Width = 121
      Height = 21
      TabOrder = 1
    end
    object btnC2F: TButton
      Left = 256
      Top = 11
      Width = 121
      Height = 25
      Caption = 'Celsius -> Fahrenheit'
      TabOrder = 2
      OnClick = btnC2FClick
    end
    object btnF2C: TButton
      Left = 256
      Top = 55
      Width = 121
      Height = 25
      Caption = 'Fahrenheit -> Celsius  '
      TabOrder = 3
      OnClick = btnF2CClick
    end
  end
  object clHttpRio1: TclHttpRio
    UserAgent = 'CleverComponents SOAP 1.0'
    CharSet = 'utf-8'
    Left = 288
    Top = 88
  end
end
