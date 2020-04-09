program CleverImapServer;

uses
  Forms,
  main in 'main.pas' {MainForm},
  ProxyHeader in 'ProxyHeader.pas',
  ProxiedImapConnection in 'ProxiedImapConnection.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
