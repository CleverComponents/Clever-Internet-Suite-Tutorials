unit clSslServer;

interface

uses
  Classes, clTcpServer, clTcpServerTls, clUtils;

type
  TclSslServer = class(TclTcpServerTls)
  protected
    function CreateDefaultConnection: TclUserConnection; override;
    procedure DoReadConnection(AConnection: TclUserConnection; AData: TStream); override;
  end;

implementation

{ TclSslServer }

function TclSslServer.CreateDefaultConnection: TclUserConnection;
begin
  Result := TclUserConnectionTls.Create();
end;

procedure TclSslServer.DoReadConnection(AConnection: TclUserConnection; AData: TStream);
begin
  if (AData.Size = 0) then Exit;

  inherited DoReadConnection(AConnection, AData);

  //send data to the client
  AData.Position := 0;
  AConnection.WriteData(AData);
end;

end.
