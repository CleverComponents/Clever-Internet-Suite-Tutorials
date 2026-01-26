program Pop3OAuthOffice365;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {Form1},
  MessageForm in 'MessageForm.pas' {frmMessage};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TfrmMessage, frmMessage);
  Application.Run;
end.
