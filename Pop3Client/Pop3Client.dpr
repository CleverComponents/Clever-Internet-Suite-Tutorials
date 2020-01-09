program Pop3Client;

uses
  Forms,
  main in 'main.pas' {Form1},
  msgfrm in 'msgfrm.pas' {MessageForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
