unit AccountsForm;

interface

uses
  System.Classes, Vcl.Controls, Vcl.Forms, Vcl.ComCtrls, Vcl.StdCtrls,
  MessagePersister, clTcpClientTls;

type
  TfrmAccounts = class(TForm)
    btnOK: TButton;
    btnCancel: TButton;
    PageControl1: TPageControl;
    tabGeneral: TTabSheet;
    tabServers: TTabSheet;
    tabAdvanced: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    edtName: TEdit;
    edtEMail: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    edtPOP3Server: TEdit;
    edtPOP3User: TEdit;
    edtPOP3Password: TEdit;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    edtSMTPServer: TEdit;
    edtSMTPUser: TEdit;
    edtSMTPPassword: TEdit;
    cbPOP3SPA: TCheckBox;
    cbSMTPSPA: TCheckBox;
    Label11: TLabel;
    Label12: TLabel;
    edtPOP3Port: TEdit;
    edtSMTPPort: TEdit;
    lblPOP3Security: TLabel;
    lblSMTPSecurity: TLabel;
    cmbPOP3Security: TComboBox;
    cmbSMTPSecurity: TComboBox;
    cbLeaveMessage: TCheckBox;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    edtTimeOut: TEdit;
    updTimeOut: TUpDown;
    cbSendImmediately: TCheckBox;
  private
    procedure Load(AAccounts: TclMailAccounts);
    procedure Store(AAccounts: TclMailAccounts);
  public
    class procedure ShowAccounts(AAccounts: TclMailAccounts);
  end;

implementation

uses
  System.SysUtils;

{$R *.dfm}

{ TfrmAccounts }

class procedure TfrmAccounts.ShowAccounts(AAccounts: TclMailAccounts);
var
  Dlg: TfrmAccounts;
begin
  Dlg := TfrmAccounts.Create(nil);
  try
    Dlg.Load(AAccounts);
    if (Dlg.ShowModal() = mrOK) then
    begin
      Dlg.Store(AAccounts);
    end;
  finally
    Dlg.Free();
  end;
end;

procedure TfrmAccounts.Load(AAccounts: TclMailAccounts);
begin
  edtName.Text := AAccounts.Name;
  edtEMail.Text := AAccounts.EMail;
  edtPOP3Server.Text := AAccounts.POP3Server;
  edtPOP3User.Text := AAccounts.POP3User;
  edtPOP3Password.Text := AAccounts.POP3Password;
  edtSMTPServer.Text := AAccounts.SMTPServer;
  edtSMTPUser.Text := AAccounts.SMTPUser;
  edtSMTPPassword.Text := AAccounts.SMTPPassword;
  cbPOP3SPA.Checked := AAccounts.POP3Sasl;
  cbSMTPSPA.Checked := AAccounts.SMTPSasl;
  edtPOP3Port.Text := IntToStr(AAccounts.POP3Port);
  edtSMTPPort.Text := IntToStr(AAccounts.SMTPPort);
  
  case AAccounts.POP3SecurityMode of
    ctNone: cmbPOP3Security.ItemIndex := 0;
    ctImplicit: cmbPOP3Security.ItemIndex := 1;
    ctExplicit: cmbPOP3Security.ItemIndex := 2;
  else
    cmbPOP3Security.ItemIndex := 0;
  end;
  
  case AAccounts.SMTPSecurityMode of
    ctNone: cmbSMTPSecurity.ItemIndex := 0;
    ctImplicit: cmbSMTPSecurity.ItemIndex := 1;
    ctExplicit: cmbSMTPSecurity.ItemIndex := 2;
  else
    cmbSMTPSecurity.ItemIndex := 0;
  end;
  
  cbLeaveMessage.Checked := AAccounts.LeaveMessage;
  updTimeOut.Position := AAccounts.TimeOut;
  cbSendImmediately.Checked := AAccounts.SendImmediately;
end;

procedure TfrmAccounts.Store(AAccounts: TclMailAccounts);
begin
  AAccounts.Name := edtName.Text;
  AAccounts.EMail := edtEMail.Text;
  AAccounts.POP3Server := edtPOP3Server.Text;
  AAccounts.POP3User := edtPOP3User.Text;
  AAccounts.POP3Password := edtPOP3Password.Text;
  AAccounts.SMTPServer := edtSMTPServer.Text;
  AAccounts.SMTPUser := edtSMTPUser.Text;
  AAccounts.SMTPPassword := edtSMTPPassword.Text;
  AAccounts.POP3Sasl := cbPOP3SPA.Checked;
  AAccounts.SMTPSasl := cbSMTPSPA.Checked;
  
  AAccounts.POP3Port := StrToIntDef(edtPOP3Port.Text, 110);
  AAccounts.SMTPPort := StrToIntDef(edtSMTPPort.Text, 25);
  
  case cmbPOP3Security.ItemIndex of
    0: AAccounts.POP3SecurityMode := ctNone;
    1: AAccounts.POP3SecurityMode := ctImplicit;
    2: AAccounts.POP3SecurityMode := ctExplicit;
  else
    AAccounts.POP3SecurityMode := ctNone;
  end;
  
  case cmbSMTPSecurity.ItemIndex of
    0: AAccounts.SMTPSecurityMode := ctNone;
    1: AAccounts.SMTPSecurityMode := ctImplicit;
    2: AAccounts.SMTPSecurityMode := ctExplicit;
  else
    AAccounts.SMTPSecurityMode := ctNone;
  end;
  
  AAccounts.LeaveMessage := cbLeaveMessage.Checked;
  AAccounts.TimeOut := updTimeOut.Position;
  AAccounts.SendImmediately := cbSendImmediately.Checked;
end;

end.