unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, clTcpServer,
  clTcpServerTls, clHttpServer, clHttpHeader, clHttpRequest;

type
  TForm1 = class(TForm)
    btnStart: TButton;
    btnStop: TButton;
    clHttpServer1: TclHttpServer;
    procedure clHttpServer1ReceiveRequest(Sender: TObject;
      AConnection: TclHttpUserConnection; const AMethod, AUri: string;
      AHeader: TclHttpRequestHeader; ABody: TStream);
    procedure btnStartClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnStartClick(Sender: TObject);
begin
  clHttpServer1.Start();
end;

procedure TForm1.btnStopClick(Sender: TObject);
begin
  clHttpServer1.Stop();
end;

procedure TForm1.clHttpServer1ReceiveRequest(Sender: TObject;
  AConnection: TclHttpUserConnection; const AMethod, AUri: string;
  AHeader: TclHttpRequestHeader; ABody: TStream);
var
  request: TclHttpRequest;
  user, password, response: string;
  field: TclFormFieldRequestItem;
begin
  request := TclHttpRequest.Create(nil);
  try
    //assign the request header
    request.Header := AHeader;

    //load and parse the request
    ABody.Position := 0;
    request.RequestStream := ABody;

    //extract the form fields
    field := request.FormFields['username'];
    if (field <> nil) then
    begin
      user := field.FieldValue;
    end;

    field := request.FormFields['password'];
    if (field <> nil) then
    begin
      password := field.FieldValue;
    end;

    //process the extracted fields and send a response
    response := '<html><body><p>The user logged in.</p></body></html>';
    (Sender as TclHttpServer).SendResponse(AConnection, 200, 'OK', response);
  finally
    request.Free();
  end;
end;

end.
