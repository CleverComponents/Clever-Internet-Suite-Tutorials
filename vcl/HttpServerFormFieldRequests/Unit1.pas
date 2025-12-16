unit Unit1;

interface

uses
  Winapi.Windows, Messages, SysUtils, SyncObjs, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, clTcpServer,
  clTcpServerTls, clHttpServer, clHttpHeader, clHttpRequest;

type
  TForm1 = class(TForm)
    btnStart: TButton;
    btnStop: TButton;
    clHttpServer1: TclHttpServer;
    memLog: TMemo;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure clHttpServer1ReceiveRequest(Sender: TObject;
      AConnection: TclHttpUserConnection; const AMethod, AUri: string;
      AHeader: TclHttpRequestHeader; ABody: TStream);
    procedure btnStartClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure clHttpServer1Start(Sender: TObject);
    procedure clHttpServer1Stop(Sender: TObject);
  private
    FSynchronizer: TCriticalSection;
    procedure PutLogMessage(const ALogMessage: string);
    function GetLoginForm: string;
    function GetSuccessPage(const AUserName: string): string;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  FSynchronizer := TCriticalSection.Create();
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FSynchronizer.Free();
end;

procedure TForm1.PutLogMessage(const ALogMessage: string);
begin
  if not (csDestroying in ComponentState) then
  begin
    FSynchronizer.Enter();
    try
      memLog.Lines.Add(ALogMessage);
    finally
      FSynchronizer.Leave();
    end;
  end;
end;

function TForm1.GetLoginForm: string;
begin
  // Simple HTML login form without any styling
  Result := 
    '<html>' +
    '<body>' +
    '<h1>Login Form</h1>' +
    '<form method="POST" action="/login">' +
    'Username: <input type="text" name="username"><br>' +
    'Password: <input type="password" name="password"><br>' +
    '<input type="submit" value="Login">' +
    '</form>' +
    '</body>' +
    '</html>';
end;

function TForm1.GetSuccessPage(const AUserName: string): string;
begin
  // Simple success page
  Result := 
    '<html>' +
    '<body>' +
    '<h1>Login Successful</h1>' +
    '<p>Welcome, ' + AUserName + '!</p>' +
    '<a href="/">Back to login</a>' +
    '</body>' +
    '</html>';
end;

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
  user, password, response, uri: string;
  field: TclFormFieldRequestItem;
begin
  // Log all incoming requests
  PutLogMessage(Format('[%s] %s %s', [FormatDateTime('hh:nn:ss', Now), AMethod, AUri]));
  
  uri := LowerCase(AUri);
  
  // Handle GET request - show HTML form
  if (AMethod = 'GET') then
  begin
    if (uri = '/') or (uri = '/index.html') or (uri = '/login') then
    begin
      response := GetLoginForm();
      (Sender as TclHttpServer).SendResponse(AConnection, 200, 'OK', response);
    end else
    begin
      // Return 404 for other GET requests
      response := '<html><body><h1>404 Not Found</h1></body></html>';
      (Sender as TclHttpServer).SendResponse(AConnection, 404, 'Not Found', response);
    end;
  end else
  // Handle POST request - process login form
  if (AMethod = 'POST') and ((uri = '/login') or (uri = '/')) then
  begin
    request := TclHttpRequest.Create(nil);
    try
      // Assign the request header
      request.Header := AHeader;

      // Load and parse the request
      ABody.Position := 0;
      request.RequestStream := ABody;

      // Extract form fields
      user := '';
      password := '';
      
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

      // Log login attempt
      PutLogMessage(Format('Login attempt - Username: %s, Password: %s', [user, password]));

      // Process extracted fields and send response
      if (user <> '') then
      begin
        response := GetSuccessPage(user);
        (Sender as TclHttpServer).SendResponse(AConnection, 200, 'OK', response);
      end else
      begin
        response := '<html><body><h1>Error</h1><p>Username is required.</p></body></html>';
        (Sender as TclHttpServer).SendResponse(AConnection, 400, 'Bad Request', response);
      end;
    finally
      request.Free();
    end;
  end else
  begin
    // Return 405 for other methods
    response := '<html><body><h1>405 Method Not Allowed</h1></body></html>';
    (Sender as TclHttpServer).SendResponse(AConnection, 405, 'Method Not Allowed', response);
  end;
end;

procedure TForm1.clHttpServer1Start(Sender: TObject);
begin
  PutLogMessage('=================='#13#10'HTTP Server Started');
  PutLogMessage('Server URL: http://localhost:' + IntToStr(clHttpServer1.Port));
  PutLogMessage('GET / - Display login form');
  PutLogMessage('POST /login - Process login form');
end;

procedure TForm1.clHttpServer1Stop(Sender: TObject);
begin
  PutLogMessage('HTTP Server Stopped');
end;

end.