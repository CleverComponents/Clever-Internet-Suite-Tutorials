unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TMessageForm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtFrom: TEdit;
    edtTo: TEdit;
    edtSubject: TEdit;
    memText: TMemo;
    Button1: TButton;
    Button2: TButton;
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
