unit msgfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TMessageForm = class(TForm)
    Label1: TLabel;
    edtFrom: TEdit;
    Label2: TLabel;
    edtTo: TEdit;
    Label3: TLabel;
    edtSubject: TEdit;
    memBody: TMemo;
    btnClose: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MessageForm: TMessageForm;

implementation

{$R *.dfm}

end.
