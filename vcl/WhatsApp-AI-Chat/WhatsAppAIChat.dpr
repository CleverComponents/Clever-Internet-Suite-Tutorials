program WhatsAppAIChat;

uses
  Vcl.Forms,
  uMainForm in 'uMainForm.pas' {MainForm},
  uOpenAIClient in 'uOpenAIClient.pas',
  uWhatsAppClient in 'uWhatsAppClient.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
