unit CustomClient;

interface

uses
  Classes, SysUtils, clTcpClient, clTcpCommandClient, clUtils;

type
  TMyClient = class(TclTcpCommandClient)
  protected
    function GetDefaultPort: Integer; override;
    function GetResponseCode(const AResponse: string): Integer; override;
    procedure OpenSession; override;
    procedure CloseSession; override;
  public
    procedure Login;
    procedure ExchangeLines(ALines: TStrings);
    procedure ExchangeData(ASource, ADestination: TStream);
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

procedure TMyClient.ExchangeData(ASource, ADestination: TStream);
var
  size, oldsize: Int64;
  temp: TStream;
begin
  SendCommandSync('DATA ' + IntToStr(ASource.Size - ASource.Position), [OkResponse]);
  Connection.WriteData(ASource);

  temp := TMemoryStream.Create();
  try
    Connection.ReadData(temp);

    if (temp.Size < SizeOf(size)) then
    begin
      Exit;
    end;

    temp.Position := 0;
    temp.Read(size, SizeOf(size));

    oldsize := ADestination.Size;
    ADestination.CopyFrom(temp, temp.Size - temp.Position);
    size := size - ADestination.Size + oldsize;

    while (size > 0) do
    begin
      oldsize := ADestination.Size;
      Connection.ReadData(ADestination);
      size := size - ADestination.Size + oldsize;
    end;
  finally
    temp.Free();
  end;
end;

procedure TMyClient.ExchangeLines(ALines: TStrings);
begin
  SendCommandSync('LINES', [OkResponse]);
  SendMultipleLines(ALines, '.');
  WaitMultipleLines(0);
end;

function TMyClient.GetResponseCode(const AResponse: string): Integer;
var
  resp: string;
begin
  resp := Trim(AResponse);
  if (resp = '.') then
  begin
    Result := SOCKET_DOT_RESPONSE;
  end else
  begin
    Result := StrToIntDef(resp, SOCKET_WAIT_RESPONSE);
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
