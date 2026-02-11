object frmAccounts: TfrmAccounts
  Left = 247
  Top = 55
  BorderStyle = bsDialog
  Caption = 'Mail Accounts'
  ClientHeight = 397
  ClientWidth = 300
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 13
  object btnOK: TButton
    Left = 132
    Top = 366
    Width = 72
    Height = 22
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TButton
    Left = 214
    Top = 366
    Width = 72
    Height = 22
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 300
    Height = 355
    ActivePage = tabGeneral
    Align = alTop
    TabOrder = 0
    ExplicitWidth = 296
    object tabGeneral: TTabSheet
      Caption = 'General'
      object Label1: TLabel
        Left = 9
        Top = 38
        Width = 28
        Height = 13
        Caption = 'Name'
      end
      object Label2: TLabel
        Left = 9
        Top = 65
        Width = 29
        Height = 13
        Caption = 'E-Mail'
      end
      object edtName: TEdit
        Left = 48
        Top = 35
        Width = 233
        Height = 21
        TabOrder = 0
        Text = 'edtName'
      end
      object edtEMail: TEdit
        Left = 48
        Top = 62
        Width = 233
        Height = 21
        TabOrder = 1
        Text = 'edtEMail'
      end
    end
    object tabServers: TTabSheet
      Caption = 'Servers'
      ImageIndex = 1
      object Label3: TLabel
        Left = 12
        Top = 16
        Width = 102
        Height = 13
        Caption = 'Incoming Mail (POP3)'
      end
      object Label4: TLabel
        Left = 12
        Top = 146
        Width = 104
        Height = 13
        Caption = 'Outgoing Mail (SMTP)'
      end
      object Label5: TLabel
        Left = 22
        Top = 39
        Width = 31
        Height = 13
        Caption = 'Server'
      end
      object Label6: TLabel
        Left = 22
        Top = 65
        Width = 22
        Height = 13
        Caption = 'User'
      end
      object Label7: TLabel
        Left = 22
        Top = 93
        Width = 46
        Height = 13
        Caption = 'Password'
      end
      object Label8: TLabel
        Left = 22
        Top = 168
        Width = 31
        Height = 13
        Caption = 'Server'
      end
      object Label9: TLabel
        Left = 22
        Top = 194
        Width = 22
        Height = 13
        Caption = 'User'
      end
      object Label10: TLabel
        Left = 22
        Top = 222
        Width = 46
        Height = 13
        Caption = 'Password'
      end
      object edtPOP3Server: TEdit
        Left = 78
        Top = 36
        Width = 203
        Height = 21
        TabOrder = 0
        Text = 'edtPOP3Server'
      end
      object edtPOP3User: TEdit
        Left = 78
        Top = 62
        Width = 203
        Height = 21
        TabOrder = 1
        Text = 'edtPOP3User'
      end
      object edtPOP3Password: TEdit
        Left = 78
        Top = 90
        Width = 203
        Height = 21
        PasswordChar = '*'
        TabOrder = 2
        Text = 'edtPOP3Password'
      end
      object edtSMTPServer: TEdit
        Left = 78
        Top = 165
        Width = 203
        Height = 21
        TabOrder = 4
        Text = 'edtSMTPServer'
      end
      object edtSMTPUser: TEdit
        Left = 78
        Top = 191
        Width = 203
        Height = 21
        TabOrder = 5
        Text = 'edtSMTPUser'
      end
      object edtSMTPPassword: TEdit
        Left = 78
        Top = 219
        Width = 203
        Height = 21
        PasswordChar = '*'
        TabOrder = 6
        Text = 'edtSMTPPassword'
      end
      object cbPOP3SPA: TCheckBox
        Left = 22
        Top = 117
        Width = 259
        Height = 17
        Caption = 'Log on using Secure Password Authentication'
        TabOrder = 3
      end
      object cbSMTPSPA: TCheckBox
        Left = 22
        Top = 247
        Width = 259
        Height = 17
        Caption = 'Log on using Secure Password Authentication'
        TabOrder = 7
      end
    end
    object tabAdvanced: TTabSheet
      Caption = 'Advanced'
      ImageIndex = 2
      object Label11: TLabel
        Left = 12
        Top = 16
        Width = 102
        Height = 13
        Caption = 'Incoming Mail (POP3)'
      end
      object Label12: TLabel
        Left = 12
        Top = 144
        Width = 104
        Height = 13
        Caption = 'Outgoing Mail (SMTP)'
      end
      object Label13: TLabel
        Left = 22
        Top = 46
        Width = 19
        Height = 13
        Caption = 'Port'
      end
      object Label14: TLabel
        Left = 22
        Top = 173
        Width = 19
        Height = 13
        Caption = 'Port'
      end
      object Label15: TLabel
        Left = 12
        Top = 264
        Width = 40
        Height = 13
        Caption = 'TimeOut'
      end
      object lblPOP3Security: TLabel
        Left = 22
        Top = 71
        Width = 67
        Height = 13
        Caption = 'Security mode'
      end
      object lblSMTPSecurity: TLabel
        Left = 22
        Top = 197
        Width = 67
        Height = 13
        Caption = 'Security mode'
      end
      object edtPOP3Port: TEdit
        Left = 68
        Top = 44
        Width = 53
        Height = 21
        TabOrder = 0
        Text = 'edtPOP3Port'
      end
      object edtSMTPPort: TEdit
        Left = 68
        Top = 170
        Width = 53
        Height = 21
        TabOrder = 3
        Text = 'edtSMTPPort'
      end
      object cmbPOP3Security: TComboBox
        Left = 22
        Top = 87
        Width = 145
        Height = 21
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 1
        Text = 'None'
        Items.Strings = (
          'None'
          'SSL/TLS'
          'STARTTLS')
      end
      object cmbSMTPSecurity: TComboBox
        Left = 22
        Top = 213
        Width = 145
        Height = 21
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 4
        Text = 'None'
        Items.Strings = (
          'None'
          'SSL/TLS'
          'STARTTLS')
      end
      object cbLeaveMessage: TCheckBox
        Left = 22
        Top = 114
        Width = 207
        Height = 17
        Caption = 'Leave a copy of messages on server'
        TabOrder = 2
      end
      object edtTimeOut: TEdit
        Left = 68
        Top = 262
        Width = 121
        Height = 21
        TabOrder = 5
        Text = '0'
      end
      object updTimeOut: TUpDown
        Left = 189
        Top = 262
        Width = 16
        Height = 21
        Associate = edtTimeOut
        TabOrder = 6
      end
      object cbSendImmediately: TCheckBox
        Left = 22
        Top = 236
        Width = 185
        Height = 17
        Caption = 'Send Messages Immediately'
        TabOrder = 7
      end
    end
  end
end
