unit MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls,
  clTcpClient, clTcpClientTls, clTcpCommandClient, clMC, clSmtp, ComposeMessageForm;

type
  TfrmMain = class(TForm)
    Label4: TLabel;
    Label8: TLabel;
    edtServer: TEdit;
    Label9: TLabel;
    edtUser: TEdit;
    Label10: TLabel;
    edtPassword: TEdit;
    cbUseSPA: TCheckBox;
    Label14: TLabel;
    edtPort: TEdit;
    Label15: TLabel;
    edtTimeOut: TEdit;
    updTimeOut: TUpDown;
    cmbUseTLS: TComboBox;
    Label1: TLabel;
    btnComposeAndSend: TButton;
    updPort: TUpDown;
    Label2: TLabel;
    pnlLogo: TPanel;
    imLogoLeft: TImage;
    imLogoMiggle: TImage;
    imLogoRight: TImage;
    clSmtp1: TclSmtp;
    lblStatus: TLabel;
    procedure btnComposeAndSendClick(Sender: TObject);
  private
    { Private declarations }
    function GetTlsMode: TclClientTlsMode;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.btnComposeAndSendClick(Sender: TObject);
var
  dlg: TfrmComposeMessage;
begin
  dlg := TfrmComposeMessage.Create(nil);
  try
    lblStatus.Visible := False;

    if dlg.ComposeEmail(edtUser.Text) then
    begin
      clSmtp1.Close();

      clSmtp1.Server := edtServer.Text;
      clSmtp1.Port := StrToInt(edtPort.Text);

      clSmtp1.UserName := edtUser.Text;
      clSmtp1.Password := edtPassword.Text;
      clSmtp1.UseSasl := cbUseSPA.Checked;

      clSmtp1.UseTLS := GetTlsMode();

      clSmtp1.TimeOut := StrToInt(edtTimeOut.Text) * 1000;

      clSmtp1.Open();

      clSmtp1.Send(dlg.MessageSource);

      clSmtp1.Close();

      lblStatus.Visible := True;
    end;
  finally
    dlg.Free();
  end;
end;

function TfrmMain.GetTlsMode: TclClientTlsMode;
var
  tlsModes: array[0..2] of TclClientTlsMode;
begin
  tlsModes[0] := ctNone;
  tlsModes[1] := ctExplicit;
  tlsModes[2] := ctImplicit;

  Result := tlsModes[cmbUseTLS.ItemIndex];
end;

end.
