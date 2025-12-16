unit LocalBindingConnection;

interface

uses
  Classes, Windows, clSocket, clIPAddress, clWinSock2, WinSock, clSocketUtils;

type
  TLocalBindingConnection = class(TclTcpClientConnection)
  private
    FAbortEvent: THandle;
    FTimeOutTicks: Integer;

    procedure InitTimeOutTicks;
  protected
    procedure DoDestroy; override;
  public
    constructor Create;
    procedure Abort; override;

    procedure OpenWithBinding(const AIP: string; APort: Integer;
      const ALocalBindingIP: string; ALocalBindingPort: Integer);
  end;

implementation

{ TLocalBindingConnection }

procedure TLocalBindingConnection.Abort;
begin
  inherited Abort();
  SetEvent(FAbortEvent);
end;

constructor TLocalBindingConnection.Create;
begin
  inherited Create();
  FAbortEvent := CreateEvent(nil, False, False, nil);
end;

procedure TLocalBindingConnection.DoDestroy;
begin
  CloseHandle(FAbortEvent);
  inherited DoDestroy();
end;

procedure TLocalBindingConnection.InitTimeOutTicks;
begin
  FTimeOutTicks := Integer(GetTickCount());
end;

procedure TLocalBindingConnection.OpenWithBinding(const AIP: string; APort: Integer;
  const ALocalBindingIP: string; ALocalBindingPort: Integer);
var
  res: Integer;
  networkEvents: TWSANetworkEvents;
  isReadIntilCloseOld: Boolean;
  addr, bindAddr: TclIPAddress;
begin
  addr := nil;
  bindAddr := nil;
  try
    addr := TclIPAddress.CreateIpAddress(AIP);

    isReadIntilCloseOld := IsReadUntilClose;
    IsReadUntilClose := False;

    CreateSocket(addr.AddressFamily, SOCK_STREAM, IPPROTO_TCP);
    SelectSocketEvent(FD_CONNECT);

    bindAddr := TclIPAddress.CreateBindingIpAddress(ALocalBindingIP, addr.AddressFamily);
    NetworkStream.Bind(bindAddr, ALocalBindingPort);

    if not NetworkStream.Connect(addr, APort) then
    begin
      InitTimeOutTicks();

      repeat
        if WaitForEvent(SocketEvent, FAbortEvent, FTimeOutTicks, TimeOut, False) then
        begin
          res := WSAEnumNetworkEvents(Socket.Socket, SocketEvent, @networkEvents);
          if (res = SOCKET_ERROR) then
          begin
            RaiseSocketError(WSAGetLastError());
          end;
          if ((networkEvents.lNetworkEvents and FD_CONNECT) > 0) then
          begin
            if (networkEvents.iErrorCode[FD_CONNECT_BIT] <> 0) then
            begin
              RaiseSocketError(networkEvents.iErrorCode[FD_CONNECT_BIT]);
            end;
            Break;
          end;
        end;
      until IsAborted;
    end;

    SelectSocketEvent(FD_READ or FD_CLOSE or FD_WRITE);

    if IsAborted then
    begin
      Close(False);
    end else
    begin
      SetActive(True);
      DispatchNextAction();
      if not Active then
      begin
        RaiseSocketError(ConnectionClosed, ConnectionClosedCode);
      end;
      NetworkStream.ConnectEnd();
      NetworkStream.StreamReady();
    end;

    IsReadUntilClose := isReadIntilCloseOld;
  finally
    bindAddr.Free();
    addr.Free();
  end;
end;

end.
