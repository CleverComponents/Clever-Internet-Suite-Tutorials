object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Send a JSON request to a REST Service and receive a response'
  ClientHeight = 511
  ClientWidth = 637
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 13
  object Label1: TLabel
    Left = 17
    Top = 304
    Width = 71
    Height = 13
    Caption = 'ISM Reference'
  end
  object Label3: TLabel
    Left = 16
    Top = 60
    Width = 69
    Height = 13
    Caption = 'Customer Title'
  end
  object Label4: TLabel
    Left = 16
    Top = 89
    Width = 96
    Height = 13
    Caption = 'Customer Firstname'
  end
  object Label5: TLabel
    Left = 16
    Top = 116
    Width = 91
    Height = 13
    Caption = 'Customer Surname'
  end
  object Label6: TLabel
    Left = 16
    Top = 143
    Width = 88
    Height = 13
    Caption = 'Customer Address'
  end
  object Label7: TLabel
    Left = 16
    Top = 202
    Width = 93
    Height = 13
    Caption = 'Customer Postcode'
  end
  object Label8: TLabel
    Left = 16
    Top = 229
    Width = 99
    Height = 13
    Caption = 'Customer Telephone'
  end
  object Label9: TLabel
    Left = 345
    Top = 35
    Width = 115
    Height = 13
    Caption = 'Faults Client Description'
  end
  object Label2: TLabel
    Left = 345
    Top = 121
    Width = 97
    Height = 13
    Caption = 'General Instructions'
  end
  object Label10: TLabel
    Left = 16
    Top = 35
    Width = 47
    Height = 13
    Caption = 'Client Ref'
  end
  object Bevel1: TBevel
    Left = 96
    Top = 272
    Width = 520
    Height = 5
    Shape = bsTopLine
  end
  object Label11: TLabel
    Left = 33
    Top = 264
    Width = 39
    Height = 13
    Caption = 'Get JOB'
  end
  object Bevel2: TBevel
    Left = 96
    Top = 15
    Width = 520
    Height = 5
    Shape = bsTopLine
  end
  object Label12: TLabel
    Left = 33
    Top = 8
    Width = 41
    Height = 13
    Caption = 'Add JOB'
  end
  object btnCreateJob: TButton
    Left = 425
    Top = 224
    Width = 121
    Height = 25
    Caption = 'Create JOB'
    TabOrder = 9
    OnClick = btnCreateJobClick
  end
  object general_instructions: TMemo
    Left = 345
    Top = 140
    Width = 271
    Height = 53
    Lines.Strings = (
      'NOTES:'
      '1.) Please delivery direct to '
      'customer')
    TabOrder = 8
  end
  object btnGetJobDetails: TButton
    Left = 425
    Top = 299
    Width = 121
    Height = 25
    Caption = 'Get JOB Details'
    TabOrder = 11
    OnClick = btnGetJobDetailsClick
  end
  object ism_reference: TEdit
    Left = 130
    Top = 301
    Width = 198
    Height = 21
    TabOrder = 10
    Text = '1'
  end
  object customer_title: TEdit
    Left = 130
    Top = 59
    Width = 63
    Height = 21
    TabOrder = 1
    Text = 'Mr'
  end
  object customer_firstname: TEdit
    Left = 130
    Top = 86
    Width = 198
    Height = 21
    TabOrder = 2
    Text = 'John'
  end
  object customer_surname: TEdit
    Left = 130
    Top = 113
    Width = 198
    Height = 21
    TabOrder = 3
    Text = 'Smith'
  end
  object customer_postcode: TEdit
    Left = 130
    Top = 199
    Width = 198
    Height = 21
    TabOrder = 5
    Text = 'ZZ1 1AA'
  end
  object customer_telephone: TEdit
    Left = 130
    Top = 226
    Width = 198
    Height = 21
    TabOrder = 6
    Text = '07711911911'
  end
  object faults_client_description: TMemo
    Left = 345
    Top = 57
    Width = 271
    Height = 50
    Lines.Strings = (
      'Issue with PROBLEM MIDDLE STITCHING IS MISSING '
      '(DIMPLE)')
    TabOrder = 7
  end
  object memResult: TMemo
    Left = 17
    Top = 348
    Width = 599
    Height = 149
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 12
  end
  object client_ref: TEdit
    Left = 130
    Top = 32
    Width = 198
    Height = 21
    TabOrder = 0
    Text = 'ABC123456'
  end
  object customer_address: TMemo
    Left = 130
    Top = 140
    Width = 199
    Height = 53
    Lines.Strings = (
      '123 The Lane,'
      'Sunnyvale')
    TabOrder = 4
  end
  object clHttp1: TclHttp
    UserAgent = 'Mozilla/4.0 (compatible; Clever Internet Suite)'
    Left = 400
    Top = 384
  end
  object clHttpRequest1: TclHttpRequest
    Header.Accept = '*/*'
    Left = 488
    Top = 384
  end
end
