object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Rest Client Htttp Rio'
  ClientHeight = 140
  ClientWidth = 339
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
      Top = 11
      Width = 76
      Height = 13
      Caption = 'Temperature, C'
    end
    object Label2: TLabel
      Left = 17
      Top = 38
      Width = 75
      Height = 13
      Caption = 'Temperature, F'
    end
    object Label3: TLabel
      Left = 17
      Top = 66
      Width = 39
      Height = 13
      Caption = 'Security'
    end
    object edtCelsius: TEdit
      Left = 112
      Top = 8
      Width = 81
      Height = 21
      TabOrder = 0
    end
    object edtFahrenheit: TEdit
      Left = 112
      Top = 35
      Width = 81
      Height = 21
      TabOrder = 1
    end
    object btnC2F: TButton
      Left = 199
      Top = 6
      Width = 121
      Height = 25
      Caption = 'Celsius -> Fahrenheit'
      TabOrder = 2
      OnClick = btnC2FClick
    end
    object btnF2C: TButton
      Left = 199
      Top = 33
      Width = 121
      Height = 25
      Caption = 'Fahrenheit -> Celsius  '
      TabOrder = 3
      OnClick = btnF2CClick
    end
    object cbSecurity: TComboBox
      Left = 112
      Top = 62
      Width = 81
      Height = 21
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 4
      Text = 'None'
      Items.Strings = (
        'None'
        'Sign'
        'SignEncrypt')
    end
  end
  object Request: TclSoapMessage
    Header.CharSet = 'utf-8'
    Header.Accept = '*/*'
    Timestamp.ID = 'ts1'
    Timestamp.Mode = tmAutoCreate
    Addressing = <>
    BodyID = 'body1'
    Signatures = <
      item
        ID = 'sig1'
        KeyClassName = 'TclXmlX509CertificateKeyInfo'
        CanonicalizationMethod = 'http://www.w3.org/2001/10/xml-exc-c14n#'
        SignatureMethod = 'http://www.w3.org/2000/09/xmldsig#rsa-sha1'
        References = <
          item
            URI = '#ts1'
            DigestMethod = 'http://www.w3.org/2000/09/xmldsig#sha1'
            Transforms = <
              item
                Algorithm = 'http://www.w3.org/2001/10/xml-exc-c14n#'
              end>
          end
          item
            URI = '#body1'
            DigestMethod = 'http://www.w3.org/2000/09/xmldsig#sha1'
            Transforms = <
              item
                Algorithm = 'http://www.w3.org/2001/10/xml-exc-c14n#'
              end>
          end>
      end>
    EncryptedKey.ID = 'key1'
    EncryptedKey.KeyClassName = 'TclXmlX509DataKeyInfo'
    EncryptedKey.EncryptionMethod = 'http://www.w3.org/2001/04/xmlenc#rsa-oaep-mgf1p'
    EncryptedKey.References = <
      item
        URI = '#sig1'
        EncryptionMethod = 'http://www.w3.org/2001/04/xmlenc#aes256-cbc'
        EncryptionType = 'http://www.w3.org/2001/04/xmlenc#Element'
      end
      item
        URI = '#body1'
        EncryptionMethod = 'http://www.w3.org/2001/04/xmlenc#aes256-cbc'
        EncryptionType = 'http://www.w3.org/2001/04/xmlenc#Content'
      end>
    Namespaces.ExtractNamespacePattern = 'xmlns\:\w*\s*=\s*\"[^\"]*\"'
    Namespaces = <>
    EncodingStyle = 'http://schemas.xmlsoap.org/soap/encoding/'
    SecurityConfig.IdName = 'Id'
    SecurityConfig.HashAlgorithms = <
      item
        Name = 'md2'
        Identifier = 32769
      end
      item
        Name = 'md5'
        Identifier = 32771
      end
      item
        Name = 'sha1'
        Identifier = 32772
      end>
    SecurityConfig.CryptAlgorithms = <
      item
        Name = 'aes256'
        Identifier = 26128
        KeySize = 32
      end
      item
        Name = 'aes192'
        Identifier = 26127
        KeySize = 24
      end
      item
        Name = 'aes128'
        Identifier = 26126
        KeySize = 16
      end>
    SecurityConfig.Namespaces.ExtractNamespacePattern = 'xmlns\:\w*\s*=\s*\"[^\"]*\"'
    SecurityConfig.Namespaces = <
      item
        Prefix = 'env'
        NameSpace = 'http://www.w3.org/2003/05/soap-envelope'
      end
      item
        Prefix = 'soapenv'
        NameSpace = 'http://schemas.xmlsoap.org/soap/envelope/'
      end
      item
        Prefix = 'ds'
        NameSpace = 'http://www.w3.org/2000/09/xmldsig#'
      end
      item
        Prefix = 'wsse'
        NameSpace = 
          'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecuri' +
          'ty-secext-1.0.xsd'
      end
      item
        Prefix = 'wsu'
        NameSpace = 
          'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecuri' +
          'ty-utility-1.0.xsd'
      end
      item
        Prefix = 'wsa'
        NameSpace = 'http://www.w3.org/2005/08/addressing'
      end
      item
        Prefix = 'xenc'
        NameSpace = 'http://www.w3.org/2001/04/xmlenc#'
      end
      item
        Prefix = 'wsse11'
        NameSpace = 
          'http://docs.oasis-open.org/wss/oasis-wss-wssecurity-secext-1.1.x' +
          'sd'
      end>
    OnGetSigningCertificate = RequestGetSigningCertificate
    OnGetEncryptionCertificate = RequestGetEncryptionCertificate
    Left = 80
    Top = 88
  end
  object Response: TclSoapMessage
    Header.CharSet = 'utf-8'
    Header.Accept = '*/*'
    Addressing = <>
    Signatures = <>
    EncryptedKey.ID = ''
    EncryptedKey.KeyClassName = 'TclXmlSKIKeyInfo'
    EncryptedKey.EncryptionMethod = 'http://www.w3.org/2001/04/xmlenc#rsa-oaep-mgf1p'
    EncryptedKey.References = <>
    Namespaces.ExtractNamespacePattern = 'xmlns\:\w*\s*=\s*\"[^\"]*\"'
    Namespaces = <>
    EncodingStyle = 'http://schemas.xmlsoap.org/soap/encoding/'
    SecurityConfig.IdName = 'Id'
    SecurityConfig.HashAlgorithms = <
      item
        Name = 'md2'
        Identifier = 32769
      end
      item
        Name = 'md5'
        Identifier = 32771
      end
      item
        Name = 'sha1'
        Identifier = 32772
      end>
    SecurityConfig.CryptAlgorithms = <
      item
        Name = 'aes256'
        Identifier = 26128
        KeySize = 32
      end
      item
        Name = 'aes192'
        Identifier = 26127
        KeySize = 24
      end
      item
        Name = 'aes128'
        Identifier = 26126
        KeySize = 16
      end>
    SecurityConfig.Namespaces.ExtractNamespacePattern = 'xmlns\:\w*\s*=\s*\"[^\"]*\"'
    SecurityConfig.Namespaces = <
      item
        Prefix = 'env'
        NameSpace = 'http://www.w3.org/2003/05/soap-envelope'
      end
      item
        Prefix = 'soapenv'
        NameSpace = 'http://schemas.xmlsoap.org/soap/envelope/'
      end
      item
        Prefix = 'ds'
        NameSpace = 'http://www.w3.org/2000/09/xmldsig#'
      end
      item
        Prefix = 'wsse'
        NameSpace = 
          'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecuri' +
          'ty-secext-1.0.xsd'
      end
      item
        Prefix = 'wsu'
        NameSpace = 
          'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecuri' +
          'ty-utility-1.0.xsd'
      end
      item
        Prefix = 'wsa'
        NameSpace = 'http://www.w3.org/2005/08/addressing'
      end
      item
        Prefix = 'xenc'
        NameSpace = 'http://www.w3.org/2001/04/xmlenc#'
      end
      item
        Prefix = 'wsse11'
        NameSpace = 
          'http://docs.oasis-open.org/wss/oasis-wss-wssecurity-secext-1.1.x' +
          'sd'
      end>
    OnGetSigningCertificateEx = ResponseGetSigningCertificateEx
    OnGetEncryptionCertificate = ResponseGetEncryptionCertificate
    Left = 144
    Top = 88
  end
  object clCertificateStore1: TclCertificateStore
    StoreName = 'MY'
    CSP = 'Microsoft Base Cryptographic Provider v1.0'
    ValidFrom = 43887.000000000000000000
    ValidTo = 44252.000000000000000000
    Left = 216
    Top = 88
  end
end
