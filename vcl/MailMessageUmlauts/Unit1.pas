unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, clMailMessage, clEncoder, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
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
var
  msg: TclMailMessage;
begin
  msg := TclMailMessage.Create(nil);
  try
    msg.CharSet := 'UTF-8';
    msg.Encoding := cmNone;
    msg.BuildMessage('Text with umlauts ÄÖÜß', '');
    msg.Subject := 'subject line';
    msg.From.FullAddress := 'john@example.com';
    msg.ToList.EmailAddresses := 'peter@domain.com';

    msg.SaveMessage('mail-utf8-autodetect.eml');

    msg.CharSet := 'UTF-8';
    msg.Encoding := cm8Bit;
    msg.BuildMessage('Text with umlauts ÄÖÜß', '');
    msg.Subject := 'subject line';
    msg.From.FullAddress := 'john@example.com';
    msg.ToList.EmailAddresses := 'peter@domain.com';

    msg.SaveMessage('mail-utf8-8bit.eml');

    msg.CharSet := 'cp1252';
    msg.Encoding := cm8Bit;
    msg.BuildMessage('Text with umlauts ÄÖÜß', '');
    msg.Subject := 'subject line';
    msg.From.FullAddress := 'john@example.com';
    msg.ToList.EmailAddresses := 'peter@domain.com';

    msg.SaveMessage('mail-latin1-8bit.eml');

    ShowMessage('Done');
  finally
    msg.Free();
  end;
end;

end.
