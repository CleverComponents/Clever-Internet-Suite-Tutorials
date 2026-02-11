unit MessageSourceForm;

interface

uses
  Vcl.Forms, Vcl.ComCtrls, System.Classes, Vcl.Controls, Vcl.StdCtrls, System.Types;

type
  TfrmMessageSource = class(TForm)
    RichEdit: TRichEdit;
  public
    class procedure ShowMessageSource(AMessage: TStrings);
  end;

implementation

{$R *.dfm}

{ TfrmMessageSource }

class procedure TfrmMessageSource.ShowMessageSource(AMessage: TStrings);
var
  Dlg: TfrmMessageSource;
begin
  Dlg := TfrmMessageSource.Create(nil);
  try
    Dlg.RichEdit.Lines.Assign(AMessage);
    Dlg.RichEdit.CaretPos := Point(0, 0);
    Dlg.ShowModal();
  finally
    Dlg.Free();
  end;
end;

end.
