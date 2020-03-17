program TestDecodeImapUtf7Names;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  ImapUtf7Encoder in 'ImapUtf7Encoder.pas';

var
  s: string;
begin
  try
    s := TImapUtf7Encoder.Decode('Test &ANw-bung Stra&AN8-e');
    Assert(s = 'Test Übung Straße');

    s := TImapUtf7Encoder.Decode('[Gmail]/&BBIEMAQ2BD0EPgQ1-');
    Assert(s = '[Gmail]/Важное');

    s := TImapUtf7Encoder.Decode('[Gmail]/&BB4EQgQ,BEAEMAQyBDsENQQ9BD0ESwQ1-');
    Assert(s = '[Gmail]/Отправленные');

    s := TImapUtf7Encoder.Decode('Test-&A5EDwAOsA70DxAO3A8MDtw-');
    Assert(s = 'Test-Απάντηση');

    s := TImapUtf7Encoder.Decode('&A5EDwAOsA70DxAO3A8MDtw-');
    Assert(s = 'Απάντηση');

    s := TImapUtf7Encoder.Decode('Test &-');
    Assert(s = 'Test &');

    s := TImapUtf7Encoder.Decode('&-Test');
    Assert(s = '&Test');

    s := TImapUtf7Encoder.Decode('&-Test&-');
    Assert(s = '&Test&');

    s := TImapUtf7Encoder.Decode('&-');
    Assert(s = '&');

    s := TImapUtf7Encoder.Decode('&-&-');
    Assert(s = '&&');

    s := TImapUtf7Encoder.Decode('&-&-s');
    Assert(s = '&&s');

    s := TImapUtf7Encoder.Decode('Test-');
    Assert(s = 'Test-');

    s := TImapUtf7Encoder.Decode('Test-After');
    Assert(s = 'Test-After');

    s := TImapUtf7Encoder.Decode('Test After');
    Assert(s = 'Test After');

    s := TImapUtf7Encoder.Decode('-Test After');
    Assert(s = '-Test After');

    s := TImapUtf7Encoder.Decode('-&-Test After');
    Assert(s = '-&Test After');

    s := TImapUtf7Encoder.Decode('Test After-&-');
    Assert(s = 'Test After-&');

    s := TImapUtf7Encoder.Decode('');
    Assert(s = '');

    Writeln('Done.');
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;

  Writeln('Press Enter to exit.');
  Readln(s);
end.
