unit ProxiedImapConnection;

interface

uses
  Classes, clImap4Server, ProxyHeader;

type
  TProxiedConnection = class(TclImap4CommandConnection)
  private
    FProxy: TProxyHeaderParser;
    FConnectionInfoRead: Boolean;
  protected
    procedure DoDestroy; override;
  public
    constructor Create;

    function ReadData(AData: TStream): Boolean; override;

    property Proxy: TProxyHeaderParser read FProxy;
    property ConnectionInfoRead: Boolean read FConnectionInfoRead write FConnectionInfoRead;
  end;

implementation

{ TProxiedConnection }

constructor TProxiedConnection.Create;
begin
  inherited Create();
  FProxy := TProxyHeaderParser.Create(True);
  FConnectionInfoRead := False;
end;

procedure TProxiedConnection.DoDestroy;
begin
  inherited DoDestroy();
  FProxy.Free();
end;

function TProxiedConnection.ReadData(AData: TStream): Boolean;
begin
  Result := inherited ReadData(AData);
  FProxy.Check(AData);
end;

end.
