program MailClient;

uses
  Vcl.Forms,
  MainForm in 'MainForm.pas' {frmMain},
  AccountsForm in 'AccountsForm.pas' {frmAccounts},
  MessagePersister in 'MessagePersister.pas',
  MessageSourceForm in 'MessageSourceForm.pas' {frmMessageSource},
  ProgressForm in 'ProgressForm.pas' {frmProgress},
  ComposeMessageForm in 'ComposeMessageForm.pas' {frmComposeMessage};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
