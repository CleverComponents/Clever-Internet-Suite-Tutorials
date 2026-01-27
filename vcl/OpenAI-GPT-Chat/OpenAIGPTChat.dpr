program OpenAIGPTChat;

uses
  Vcl.Forms,
  uOpenAIChatForm in 'uOpenAIChatForm.pas' {frmOpenAIChat};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmOpenAIChat, frmOpenAIChat);
  Application.Run;
end.
