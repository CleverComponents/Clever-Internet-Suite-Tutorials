unit MessageForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, clMailMessage;

type
  TfrmMessage = class(TForm)
    lblSubject: TLabel;
    lblFrom: TLabel;
    memBody: TMemo;
    btnClose: TButton;
    lblTo: TLabel;
    edtSubject: TEdit;
    edtFrom: TEdit;
    edtToList: TEdit;
    procedure btnCloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure ShowMessage(AMessage: TclMailMessage);
  end;

var
  frmMessage: TfrmMessage;

implementation

{$R *.dfm}

procedure TfrmMessage.btnCloseClick(Sender: TObject);
begin
  Close();
end;

procedure TfrmMessage.ShowMessage(AMessage: TclMailMessage);
begin
  Caption := 'Message: ' + AMessage.Subject;
  edtSubject.Text := AMessage.Subject;
  edtFrom.Text := AMessage.From.FullAddress;
  edtToList.Text := AMessage.ToList.EmailAddresses;

  if (AMessage.Text <> nil) then
  begin
    memBody.Lines.Assign(AMessage.Text.Strings);
  end else
  begin
    memBody.Lines.Assign(AMessage.MessageText);
  end;

  Show();
end;

end.
