unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, clJson, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    btnBuildJSON: TButton;
    Memo1: TMemo;
    btnParseJSON: TButton;
    procedure btnBuildJSONClick(Sender: TObject);
    procedure btnParseJSONClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnBuildJSONClick(Sender: TObject);
var
  request: TclJSONObject;
  data: TclJSONObject;
  job: TclJSONObject;
begin
  request := TclJSONObject.Create();
  try
    data := TclJSONObject.Create();
    request.AddMember('data', data);

    job := TclJSONObject.Create();
    data.AddMember('job', job);

    job.AddString('reference_id', 'ID32048');
    job.AddString('status_code', '10');
    job.AddString('status_name', 'New Job');

    ShowMessage(request.GetJSONString());
  finally
    request.Free();
  end;
end;

procedure TForm1.btnParseJSONClick(Sender: TObject);
var
  request: TclJSONObject;
  data: TclJSONObject;
  job: TclJSONObject;
begin
  request := TclJSONObject.ParseObject(Memo1.Lines.Text);
  try
    data := request.ObjectByName('data');

    job := data.ObjectByName('job');

    ShowMessage(job.ValueByName('reference_id'));
  finally
    request.Free();
  end;
end;

end.
