unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    btnCheckConnection: TButton;
    edtUrl: TEdit;
    Label1: TLabel;
    lblStatus: TLabel;
    procedure btnCheckConnectionClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function CheckInternetConnection(const AUrl: string): Boolean;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  clWinInet, clDownloader, clResourceState;

//checks the Internet connected state and tries to access the specified web resource
//by using of the system connection settings: proxy, socks, etc.
function CheckInternetConnection(const AUrl: string): Boolean;
var
  details: Cardinal;
  http: TclDownloader;
begin
  Result := InternetGetConnectedState(@details, 0);
  if not Result then Exit;

  http := nil;
  try
    http := TclDownloader.Create(nil);

    http.URL := AUrl;
    http.LocalFile := '';
    http.TryCount := 1;

    http.Start(False);

    Result := (http.ResourceState.LastStatus in [psSuccess, psErrors]);
  finally
    http.Free();
  end;
end;

procedure TForm1.btnCheckConnectionClick(Sender: TObject);
begin
  if CheckInternetConnection(edtUrl.Text) then
  begin
    lblStatus.Caption := 'Connected';
  end else
  begin
    lblStatus.Caption := 'Not connected';
  end;
end;

end.
