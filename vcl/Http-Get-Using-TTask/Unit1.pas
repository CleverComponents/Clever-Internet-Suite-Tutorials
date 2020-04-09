unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Threading, clTcpClient,
  clTcpClientTls, clHttp, Vcl.StdCtrls, clHtmlParser, System.SyncObjs;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    edtUrl: TEdit;
    URL: TLabel;
    clHttp1: TclHttp;
    cbShowText: TCheckBox;
    clHtmlParser1: TclHtmlParser;
    procedure Button1Click(Sender: TObject);
    procedure clHtmlParser1ParseTag(Sender: TObject; ATag: TclHtmlTag);
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    FNeedShowText: Boolean;
    FWorkInProgress: Boolean;
    FAccessor: TCriticalSection;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

constructor TForm1.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FAccessor := TCriticalSection.Create();
end;

destructor TForm1.Destroy;
begin
  FAccessor.Free();
  inherited Destroy();
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
 FAccessor.Enter();
  try
    if (FWorkInProgress) then
    begin
      ShowMessage('The work is in progress, cannot close the program.');
      CanClose := False;
    end;
  finally
    FAccessor.Leave();
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  task: ITask;
begin
  FAccessor.Enter();
  try
    if (FWorkInProgress) then Exit;
    FWorkInProgress := true;
  finally
    FAccessor.Leave();
  end;

  FNeedShowText := cbShowText.Checked;
  task := TTask.Create(procedure()
var
  html: TStrings;
begin
  html := TStringList.Create();
  try
    TThread.Synchronize(nil, procedure()
    begin
      Memo1.Lines.Clear();
    end);
    clHttp1.Get(edtUrl.Text, html);

    if FNeedShowText then
    begin
      clHtmlParser1.Parse(html);
    end else
    begin
      TThread.Synchronize(nil, procedure()
      begin
        Memo1.Lines.Assign(html);
      end);
    end;

  finally
    FAccessor.Enter();
    try
      FWorkInProgress := False;
    finally
      FAccessor.Leave();
    end;
    html.Free();
  end;
end);
  task.Start();
end;

procedure TForm1.clHtmlParser1ParseTag(Sender: TObject; ATag: TclHtmlTag);
begin
  if (Trim(ATag.Text) <> '') then
  TThread.Synchronize(nil, procedure()
  begin
    Memo1.Lines.Add(ATag.Text);
  end);
end;

end.
