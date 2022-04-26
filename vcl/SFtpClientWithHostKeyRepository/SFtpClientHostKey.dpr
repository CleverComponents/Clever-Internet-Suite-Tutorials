program SFtpClientHostKey;

uses
  Vcl.Forms,
  Main in 'Main.pas' {MainForm},
  KnownHosts in 'KnownHosts.pas' {KnownHostsForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
