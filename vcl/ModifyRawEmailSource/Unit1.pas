unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, clTcpClient,
  clTcpClientTls, clTcpCommandClient, clMC, clSmtp, clMailHeader, clEncoder;

type
  TForm1 = class(TForm)
    clSmtp1: TclSmtp;
    btnSend: TButton;
    procedure btnSendClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnSendClick(Sender: TObject);
var
  fieldList: TclMailHeaderFieldList;
  ind: Integer;
  subject: string;
begin
  //load a message in a raw format.
  clSmtp1.MailData.LoadFromFile('mailmessage.eml');

  //set up the TclSmtp component
  clSmtp1.Server := 'mail.example.com';
  clSmtp1.UserName := 'user';
  clSmtp1.Password := 'secret';

  //specify the desired character set and MIME encoding for the Subject header field
  fieldList := TclMailHeaderFieldList.Create('utf-8', cmQuotedPrintable, DefaultCharsPerLine);
  try
    //parse the mail header
    fieldList.Parse(0, clSmtp1.MailData);

    //get an index of the Subject field
    ind := fieldList.GetFieldIndex('Subject');

    //get the Subject field value
    subject := fieldList.GetDecodedFieldValue(ind);

    //modify the subject line
    subject := subject + ' modified...';

    //remove the subject field from the clSmtp1.MailData string list
    fieldList.RemoveField(ind);

    //add an updated subject line
    fieldList.AddEncodedField('Subject', subject);

    //starting from now, the clSmtp1.MailData property contains the updated Subject field
  finally
    fieldList.Free();
  end;

  //send the message
  clSmtp1.Send();
end;

end.
