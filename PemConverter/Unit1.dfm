object Form1: TForm1
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'RSA Public Key converter'
  ClientHeight = 298
  ClientWidth = 723
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
  object Label2: TLabel
    Left = 16
    Top = 8
    Width = 71
    Height = 13
    Caption = 'RSA Public Key'
  end
  object Label3: TLabel
    Left = 16
    Top = 159
    Width = 107
    Height = 13
    Caption = 'X509 Subject Key Info'
  end
  object Label1: TLabel
    Left = 367
    Top = 8
    Width = 94
    Height = 13
    Caption = 'RSA Public PEM Key'
  end
  object btnConverRsaKey: TButton
    Left = 16
    Top = 119
    Width = 97
    Height = 34
    Caption = 'Convert'
    TabOrder = 1
    OnClick = btnConverRsaKeyClick
  end
  object memRsaPublicKey: TMemo
    Left = 16
    Top = 27
    Width = 345
    Height = 86
    Lines.Strings = (
      'MEgCQQDCiZulctu'
      '+Tp2pZ7wfTyKhpSkYzqkRAwdmvNdvUVwgh8mwBAOdt9Mvhx'
      '+OVokrzfLIJqeBBkbwTzxfgVeU6CL3AgMBAAE=')
    TabOrder = 0
  end
  object memX509SubjectKeyInfo: TMemo
    Left = 16
    Top = 178
    Width = 696
    Height = 109
    ReadOnly = True
    TabOrder = 4
  end
  object btnConverRsaPemKey: TButton
    Left = 367
    Top = 119
    Width = 97
    Height = 34
    Caption = 'Convert'
    TabOrder = 3
    OnClick = btnConverRsaPemKeyClick
  end
  object memRsaPublicPemKey: TMemo
    Left = 367
    Top = 27
    Width = 345
    Height = 86
    Lines.Strings = (
      '-----BEGIN RSA PUBLIC KEY-----'
      'MEgCQQDCiZulctu'
      '+Tp2pZ7wfTyKhpSkYzqkRAwdmvNdvUVwgh8mwBAOdt9Mvhx+O'
      'VokrzfLIJqeBBkbwTzxfgVeU6CL3AgMBAAE='
      '-----END RSA PUBLIC KEY-----')
    TabOrder = 2
  end
end
