unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, clMailMessage, clEncoder, StdCtrls,
  clTcpClient, clTcpClientTls, clTcpCommandClient, clMC, clSmtp;

type
  TForm1 = class(TForm)
    Button1: TButton;
    clSmtp1: TclSmtp;
    clMailMessage1: TclMailMessage;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  // Example 1: UTF-8 with auto-detected encoding
  clMailMessage1.CharSet := 'UTF-8';
  clMailMessage1.Encoding := cmNone;
  clMailMessage1.BuildMessage('Text with German umlauts: ÄÖÜß and special characters: ©®€', '');
  clMailMessage1.Subject := 'Test email with UTF-8 characters (auto-detect)';
  clMailMessage1.From.FullAddress := 'john@example.com';
  clMailMessage1.ToList.EmailAddresses := 'peter@domain.com';

  // Save message to file
  clMailMessage1.SaveMessage('mail-utf8-autodetect.eml');

  // Send message via SMTP (configure your SMTP server first in Object Inspector)
  // clSmtp1.Server := 'smtp.example.com';
  // clSmtp1.Port := 587;
  // clSmtp1.UserName := 'john@example.com';
  // clSmtp1.Password := 'password';
  // clSmtp1.UseTLS := ctAutomatic;
  //
  // clSmtp1.Open();
  // clSmtp1.Send(clMailMessage1);
  // clSmtp1.Close();

  // Example 2: UTF-8 with 8-bit encoding
  clMailMessage1.CharSet := 'UTF-8';
  clMailMessage1.Encoding := cm8Bit;
  clMailMessage1.BuildMessage('Text with German umlauts: ÄÖÜß and special characters: ©®€', '');
  clMailMessage1.Subject := 'Test email with UTF-8 characters (8-bit encoding)';
  clMailMessage1.From.FullAddress := 'john@example.com';
  clMailMessage1.ToList.EmailAddresses := 'peter@domain.com';

  clMailMessage1.SaveMessage('mail-utf8-8bit.eml');

  // Example 3: Latin-1 (cp1252) with 8-bit encoding
  clMailMessage1.CharSet := 'cp1252';
  clMailMessage1.Encoding := cm8Bit;
  clMailMessage1.BuildMessage('Text with German umlauts: ÄÖÜß and special characters: ©®', '');
  clMailMessage1.Subject := 'Test email with Latin-1 characters';
  clMailMessage1.From.FullAddress := 'john@example.com';
  clMailMessage1.ToList.EmailAddresses := 'peter@domain.com';

  clMailMessage1.SaveMessage('mail-latin1-8bit.eml');

  ShowMessage('Messages saved successfully.' + #13#10 +
              'To send emails via SMTP, uncomment the SMTP code section' + #13#10 +
              'and configure your SMTP server credentials in Object Inspector.');
end;

end.
