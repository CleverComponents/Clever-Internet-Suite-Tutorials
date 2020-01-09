unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, clMailMessage, clPOP3, clMC, clSMTP, msgfrm,
  clTcpClient, clTcpClientTls, clTcpCommandClient,
  ExtCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    edtPop3Server: TEdit;
    Label2: TLabel;
    edtUser: TEdit;
    Label3: TLabel;
    edtPassword: TEdit;
    clPOP31: TclPOP3;
    clMailMessage1: TclMailMessage;
    btnCheckMail: TButton;
    lbMessages: TListBox;
    Label4: TLabel;
    procedure btnCheckMailClick(Sender: TObject);
    procedure lbMessagesDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnCheckMailClick(Sender: TObject);
var
  i, count: Integer;
begin
  if clPOP31.Active then Exit;

  clPOP31.Server := edtPop3Server.Text;
  clPOP31.UserName := edtUser.Text;
  clPOP31.Password := edtPassword.Text;

  clPOP31.Open();
  try
    lbMessages.Items.Clear();

    count := clPOP31.MessageCount;
    for i := 1 to count do
    begin
      clPOP31.RetrieveHeader(i, clMailMessage1);
      if (clMailMessage1.Subject = '') then
      begin
        lbMessages.Items.Add(clMailMessage1.From.FullAddress);
      end else
      begin
        lbMessages.Items.Add(clMailMessage1.Subject);
      end;
    end;
  finally
    clPOP31.Close();
  end;

  ShowMessage(Format('Collecting completed, %d messages in the mailbox', [count]));
end;

procedure TForm1.lbMessagesDblClick(Sender: TObject);
var
  dlg: TMessageForm;
begin
  if clPOP31.Active or (lbMessages.ItemIndex < 0) then Exit;

  clPOP31.Server := edtPop3Server.Text;
  clPOP31.UserName := edtUser.Text;
  clPOP31.Password := edtPassword.Text;

  clPOP31.Open();
  dlg := TMessageForm.Create(nil);
  try
    clPOP31.Retrieve(lbMessages.ItemIndex + 1, clMailMessage1);

    dlg.edtFrom.Text := clMailMessage1.From.FullAddress;
    dlg.edtTo.Text := clMailMessage1.ToList.EmailAddresses;
    dlg.edtSubject.Text := clMailMessage1.Subject;

    dlg.memBody.Lines := clMailMessage1.MessageText;

    dlg.ShowModal();
  finally
    dlg.Free();
    clPOP31.Close();
  end;
end;

end.
