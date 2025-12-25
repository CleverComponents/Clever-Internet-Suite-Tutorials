unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, clSocket, clSocketUtils;

type
  TForm1 = class(TForm)
    btnListen: TButton;
    btnStop: TButton;
    edtPort: TEdit;
    Label1: TLabel;
    memLog: TMemo;
    procedure btnListenClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    FConnection: TclTcpServerConnection;
    FStarted: Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnListenClick(Sender: TObject);
var
  data: TStream;
begin
  if (FStarted) then
  begin
    ShowMessage('The connection is active');
    Exit;
  end;

  try
    FConnection.NetworkStream := TclNetworkStream.Create();
    FConnection.Listen(StrToInt(edtPort.Text));

    memLog.Lines.Add('=== Start listening ===');
    FStarted := True;

    FConnection.TimeOut := -1;
    FConnection.Accept();

    data := TMemoryStream.Create();
    try
      repeat
        FConnection.ReadData(data);
        memLog.Lines.Add('Received bytes: ' + IntToStr(data.Size));
        Application.ProcessMessages();
        data.Size := 0;
      until not FConnection.Active;
    finally
      data.Free();
    end;

  except
    on E: EclSocketError do
    begin
      if ((E.ErrorCode <> 10053) and (E.ErrorCode <> 10038)) then raise;
    end;
  end;
end;

procedure TForm1.btnStopClick(Sender: TObject);
begin
  FConnection.Abort();
  FConnection.Close(True);
  FStarted := False;
  memLog.Lines.Add('=== Stop ===');
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := not FStarted;
  if (not CanClose) then ShowMessage('The connection is active');
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  StartupSocket();
  FConnection := TclTcpServerConnection.Create();
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FConnection.Free();
  CleanupSocket();
end;

end.
