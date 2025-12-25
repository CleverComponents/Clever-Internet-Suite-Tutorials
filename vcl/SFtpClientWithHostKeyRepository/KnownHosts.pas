unit KnownHosts;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, UITypes;

type
  TKnownHostsForm = class(TForm)
    lbKnownHosts: TListBox;
    btnDelete: TButton;
    btnClear: TButton;
    btnOK: TButton;
    btnCancel: TButton;
    procedure btnDeleteClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure ShowKnownHosts(AHostKeyRepository: TStrings);
  end;

implementation

{$R *.dfm}

{ TKnownHostsForm }

procedure TKnownHostsForm.btnClearClick(Sender: TObject);
begin
  if (MessageDlg('You are trying to delete all trusted SFTP hosts.'#13#10
    + 'Do you wish to proceed ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
  begin
    lbKnownHosts.Items.Clear();
  end;
end;

procedure TKnownHostsForm.btnDeleteClick(Sender: TObject);
begin
  if (lbKnownHosts.ItemIndex > -1) then
  begin
    lbKnownHosts.Items.Delete(lbKnownHosts.ItemIndex);
  end;
end;

procedure TKnownHostsForm.ShowKnownHosts(AHostKeyRepository: TStrings);
begin
  //Load a list of trusted SFTP hosts from the host-key repository.
  lbKnownHosts.Items.Assign(AHostKeyRepository);

  if ShowModal() = mrOk then
  begin
    //Update a list of trusted SFTP hosts in the host-key repository.
    AHostKeyRepository.Assign(lbKnownHosts.Items);
  end;
end;

end.
