unit clSslServer;

interface

uses
  Classes, clTcpServerTls, clTcpServer, clUtils;

type
  TclSslServer = class(TclTcpServerTls)
  protected
    procedure DoReadConnection(AConnection: TclUserConnection; AData: TStream); override;
  end;

implementation

{ TclSslServer }

procedure TclSslServer.DoReadConnection(AConnection: TclUserConnection; AData: TStream);
begin
  if (AData.Size = 0) then Exit;

  inherited DoReadConnection(AConnection, AData);

  //send data to the client
  AData.Position := 0;
  AConnection.WriteData(AData);
end;

end.
