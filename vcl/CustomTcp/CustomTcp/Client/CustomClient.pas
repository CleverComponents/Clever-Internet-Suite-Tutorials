unit CustomClient;

interface

uses
  Classes, SysUtils, clTcpClient, clTcpCommandClient;

type
  TMyClient = class(TclTcpCommandClient)
  protected
    function GetDefaultPort: Integer; override;
    function GetResponseCode(const AResponse: string): Integer; override;
    procedure OpenSession; override;
    procedure CloseSession; override;
  public
    procedure Login;
    procedure GetLines(ALines: TStrings);
    procedure SendLines(ALines: TStrings);
  end;

const
  OkResponse = 100;

implementation

{ TMyClient }

procedure TMyClient.CloseSession;
begin
  SendCommandSync('CLOSE', [OkResponse]);
end;

function TMyClient.GetDefaultPort: Integer;
begin
  Result := 2110; 
end;

procedure TMyClient.GetLines(ALines: TStrings);
begin
  SendCommandSync('GETLINES', [OkResponse]);
  WaitMultipleLines(0);
  ALines.AddStrings(Response);
end;

procedure TMyClient.SendLines(ALines: TStrings);
begin
  SendCommandSync('SENDLINES', [OkResponse]);
  SendMultipleLines(ALines, '.');
  WaitResponse([OkResponse]);
end;

function TMyClient.GetResponseCode(const AResponse: string): Integer;
begin
  if (Trim(AResponse) = '.') then
  begin
    Result := SOCKET_DOT_RESPONSE;
  end else
  begin
    Result := StrToIntDef(Trim(AResponse), SOCKET_WAIT_RESPONSE);
  end;
end;

procedure TMyClient.Login;
begin
  SendCommandSync('LOGIN %s', [OkResponse], [UserName]);
end;

procedure TMyClient.OpenSession;
begin
  WaitResponse([OkResponse]);
end;

end.
