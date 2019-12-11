{
  Clever Internet Suite
  Copyright (C) 2013 Clever Components
  All Rights Reserved
  www.CleverComponents.com
}

unit clIcmp;

interface


uses
  Classes, clSocket, clUtils;

//http://tangentsoft.net/wskfaq/examples/rawping.html
//http://www.zytrax.com/tech/protocols/tcp.html

type
  TclIcmpPacket = class
  private
    FPacketType: Byte;
    FPacketCode: Byte;
    FChecksum: Word;
  public
    procedure Build(var ADestination: TclByteArray; var AIndex: Integer); virtual;
    procedure Parse(const ASource: TclByteArray; var AIndex: Integer); virtual;

    property PacketType: Byte read FPacketType write FPacketType;
    property PacketCode: Byte read FPacketCode write FPacketCode;
    property Checksum: Word read FChecksum write FChecksum;
  end;

  TclIcmpEchoPacket = class(TclIcmpPacket)
  private
    FIdentifier: Word;
    FSequenceNumber: Word;
    FData: string;
  public
    constructor Create;

    procedure Build(var ADestination: TclByteArray; var AIndex: Integer); override;
    procedure Parse(const ASource: TclByteArray; var AIndex: Integer); override;

    property Identifier: Word read FIdentifier write FIdentifier;
    property SequenceNumber: Word read FSequenceNumber write FSequenceNumber;
    property Data: string read FData write FData;
  end;

  TclRawIPHeader = class
  private
    FLength: Word;
    FVersion: Byte;
    FIdentification: Word;
    FDestination: string;
    FProtocol: Byte;
    FSource: string;
    FFragmentOffset: Word;
    FHeaderLength: Byte;
    FToS: Byte;
    FChecksum: Word;
    FFlags: Byte;
    FTTL: Byte;
  public
    procedure Parse(const ASource: TclByteArray; var AIndex: Integer); virtual;

    property Version: Byte read FVersion write FVersion;
    property HeaderLength: Byte read FHeaderLength write FHeaderLength;
    property ToS: Byte read FToS write FToS;
    property Length: Word read FLength write FLength;
    property Identification: Word read FIdentification write FIdentification;
    property Flags: Byte read FFlags write FFlags;
    property FragmentOffset: Word read FFragmentOffset write FFragmentOffset;
    property TTL: Byte read FTTL write FTTL;
    property Protocol: Byte read FProtocol write FProtocol;
    property Checksum: Word read FChecksum write FChecksum;
    property Source: string read FSource write FSource;
    property Destination: string read FDestination write FDestination;
  end;

  TclIcmpResponse = class
  private
    FIPHeader: TclRawIPHeader;
    FIcmpPacket: TclIcmpPacket;
    FRoundTripTime: Integer;
  protected
    function CreatePacket(const ASource: TclByteArray; const AIndex: Integer): TclIcmpPacket;
    function CreatePacketByType(APacketType: Word): TclIcmpPacket; virtual;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Parse(const ASource: TclByteArray; var AIndex: Integer); virtual;

    property IPHeader: TclRawIPHeader read FIPHeader;
    property IcmpPacket: TclIcmpPacket read FIcmpPacket;
    property RoundTripTime: Integer read FRoundTripTime write FRoundTripTime;
  end;

  TclIcmpConnection = class(TclUdpConnection)
  private
    FIdentifier: Word;
    FSequenceNumber: Word;
    FTTL: Integer;
    FStartTicks: Integer;

    procedure NextSequenceNumber;
    procedure SetTTL;
    function CalculateChecksum(const AData: TclByteArray; const AIndex, ASize: Integer): Word;
  public
    constructor Create;

    procedure Open(const AIP: string);
    procedure SendRequest(ARequest: TclIcmpPacket);
    function ReceiveResponse: TclIcmpResponse;

    procedure SendEchoRequest;

    property TTL: Integer read FTTL write FTTL;
    property Identifier: Word read FIdentifier write FIdentifier;
    property SequenceNumber: Word read FSequenceNumber write FSequenceNumber;
  end;

implementation

uses
  SysUtils, Windows, clIPAddress, WinSock, clTranslator, clWUtils, clSocketUtils;

{ TclICMPConnection }

function TclIcmpConnection.CalculateChecksum(const AData: TclByteArray; const AIndex, ASize: Integer): Word;
var
  i, size: Integer;
  checksum: LongWord;
begin
  checksum := 0;
  i := AIndex;
  size := ASize;
  if (size > Length(AData) - AIndex) then
  begin
    size := Length(AData) - AIndex;
  end;

  while (size > 1) do
  begin
    checksum := checksum + ByteArrayReadWord(AData, i);
    Dec(size, 2);
  end;
  if (size > 0) then
  begin
    checksum := checksum + AData[i];
  end;

  checksum := (checksum shr 16) + (checksum and $ffff);
  checksum := checksum + (checksum shr 16);
  Result := not Word(checksum);
end;

constructor TclIcmpConnection.Create;
begin
  inherited Create();

  FIdentifier := Word(GetCurrentProcessID());
  FSequenceNumber := 1;
  FTTL := 128;
  FStartTicks := 0;
end;

procedure TclIcmpConnection.Open(const AIP: string);
var
  addr, bindAddr: TclIPAddress;
begin
  addr := nil;
  bindAddr := nil;
  try
    addr := TclIPAddress.CreateIpAddress(AIP);
    CreateSocket(addr.AddressFamily, SOCK_RAW, IPPROTO_ICMP);

    if (Trim(LocalBinding) <> '') then
    begin
      bindAddr := TclIPAddress.CreateBindingIpAddress(LocalBinding, addr.AddressFamily);
      NetworkStream.Bind(bindAddr, 0);
    end;
    NetworkStream.SetPeerInfo(AIP, 0);

    SelectSocketEvent(FD_READ or FD_WRITE);
    SetActive(True);

    NetworkStream.StreamReady();
  finally
    bindAddr.Free();
    addr.Free();
  end;
end;

function TclIcmpConnection.ReceiveResponse: TclIcmpResponse;
var
  stream: TMemoryStream;
  buf: TclByteArray;
  ind: Integer;
  ticks: Integer;
begin
  stream := TMemoryStream.Create();
  try

    ReadData(stream);
    stream.Position := 0;

    ticks := Integer(GetTickCount()) - FStartTicks;

    ind := Integer(stream.Size);
    SetLength(buf, ind);
    stream.Read(buf[0], ind);
    ind := 0;

    Result := TclIcmpResponse.Create();
    try
      Result.Parse(buf, ind);
      Result.RoundTripTime := ticks;
    except
      Result.Free();
      raise;
    end;
  finally
    stream.Free();
  end;
end;

procedure TclIcmpConnection.SendEchoRequest;
var
  echo: TclIcmpEchoPacket;
begin
  echo := TclIcmpEchoPacket.Create();
  try
    echo.Identifier := Identifier;
    echo.SequenceNumber := SequenceNumber;
    echo.Data := 'abcdefghijklmnopqrstuvwabcdefghi';

    SendRequest(echo);
  finally
    NextSequenceNumber();
    echo.Free();
  end;
end;

procedure TclIcmpConnection.SendRequest(ARequest: TclIcmpPacket);
var
  stream: TMemoryStream;
  buf: TclByteArray;
  ind, checksumInd: Integer;
  checksum: Word;
begin
  SetTTL();

  stream := TMemoryStream.Create();
  try
    SetLength(buf, 1024);
    ind := 0;

    ARequest.Build(buf, ind);

    if (ARequest.Checksum = 0) then
    begin
      checksum := CalculateChecksum(buf, 0, ind);

      checksumInd := 2;
      ByteArrayWriteWord(checksum, buf, checksumInd);
    end;

    stream.Write(buf[0], ind);
    stream.Position := 0;

    FStartTicks := Integer(GetTickCount());
    WriteData(stream);
  finally
    stream.Free();
  end;
end;

procedure TclIcmpConnection.SetTTL;
var
  res: Integer;
begin
  res := winsock.setsockopt(Socket.Socket, IPPROTO_IP, IP_TTL, PclChar(@FTTL), SizeOf(FTTL));
  if (res = SOCKET_ERROR) then
  begin
    RaiseSocketError(WSAGetLastError());
  end;
end;

procedure TclIcmpConnection.NextSequenceNumber;
begin
  Inc(FSequenceNumber);
  if (FSequenceNumber = 0) then
  begin
    FSequenceNumber := 1;
  end;
end;

{ TclIcmpPacket }

procedure TclIcmpPacket.Build(var ADestination: TclByteArray; var AIndex: Integer);
begin
  ADestination[AIndex] := PacketType;
  Inc(AIndex);
  ADestination[AIndex] := PacketCode;
  Inc(AIndex);
  ByteArrayWriteWord(Checksum, ADestination, AIndex);
end;

procedure TclIcmpPacket.Parse(const ASource: TclByteArray; var AIndex: Integer);
begin
  PacketType := ASource[AIndex];
  Inc(AIndex);
  PacketCode := ASource[AIndex];
  Inc(AIndex);
  Checksum := ByteArrayReadWord(ASource, AIndex);
end;

{ TclIcmpEchoPacket }

procedure TclIcmpEchoPacket.Build(var ADestination: TclByteArray; var AIndex: Integer);
var
  buf: TclByteArray;
begin
  inherited Build(ADestination, AIndex);

  ByteArrayWriteWord(Identifier, ADestination, AIndex);
  ByteArrayWriteWord(SequenceNumber, ADestination, AIndex);
  buf := TclTranslator.GetBytes(Data, 'us-ascii');
  Move(buf[0], ADestination[AIndex], 32);
//  TclTranslator.GetBytes(Data, PclChar(@ADestination[AIndex]), 32, 'us-ascii');
  Inc(AIndex, 32);
end;

constructor TclIcmpEchoPacket.Create;
begin
  inherited Create();

  PacketType := 8;
  PacketCode := 0;
end;

procedure TclIcmpEchoPacket.Parse(const ASource: TclByteArray; var AIndex: Integer);
begin
  inherited Parse(ASource, AIndex);

  Identifier := ByteArrayReadWord(ASource, AIndex);
  SequenceNumber := ByteArrayReadWord(ASource, AIndex);
  //Data := TclTranslator.GetString(PclChar(@ASource[AIndex]), Length(ASource) - AIndex, 'us-ascii');
  Data := TclTranslator.GetString(ASource, AIndex, Length(ASource) - AIndex, 'us-ascii');
end;

{ TclRawIPHeader }

procedure TclRawIPHeader.Parse(const ASource: TclByteArray; var AIndex: Integer);
begin
  FVersion := (ASource[AIndex] and $F0) shr 4;
  FHeaderLength := (ASource[AIndex] and $0F) * 4;
  Inc(AIndex);

  FToS := ASource[AIndex];
  Inc(AIndex);

  FLength := ByteArrayReadWord(ASource, AIndex);

  FIdentification := ByteArrayReadWord(ASource, AIndex);

  FFlags := (ASource[AIndex] and $E000) shr 13;
  FFragmentOffset := (ByteArrayReadWord(ASource, AIndex) and $1FFF);

  FTTL := ASource[AIndex];
  Inc(AIndex);

  FProtocol := ASource[AIndex];
  Inc(AIndex);

  FChecksum := ByteArrayReadWord(ASource, AIndex);

  FSource := Format('%d.%d.%d.%d',[ASource[AIndex], ASource[AIndex + 1], ASource[AIndex + 2], ASource[AIndex + 3]]);
  Inc(AIndex, 4);

  FDestination := Format('%d.%d.%d.%d',[ASource[AIndex], ASource[AIndex + 1], ASource[AIndex + 2], ASource[AIndex + 3]]);
  Inc(AIndex, 4);

  AIndex := FHeaderLength;
end;

{ TclIcmpResponse }

constructor TclIcmpResponse.Create;
begin
  inherited Create();

  FIPHeader := TclRawIPHeader.Create();
  FIcmpPacket := nil;
  FRoundTripTime := 0;
end;

function TclIcmpResponse.CreatePacket(const ASource: TclByteArray; const AIndex: Integer): TclIcmpPacket;
var
  packet: TclIcmpPacket;
  ind: Integer;
begin
  packet := TclIcmpPacket.Create();
  try
    ind := AIndex;
    packet.Parse(ASource, ind);
    Result := CreatePacketByType(packet.PacketType);
  finally
    packet.Free();
  end;
end;

function TclIcmpResponse.CreatePacketByType(APacketType: Word): TclIcmpPacket;
begin
  if (8 = APacketType) then
  begin
    Result := TclIcmpEchoPacket.Create();
  end else
  if (0 = APacketType) then
  begin
    Result := TclIcmpEchoPacket.Create();
  end else
  begin
    Result := TclIcmpPacket.Create();;
  end;
end;

destructor TclIcmpResponse.Destroy;
begin
  FIcmpPacket.Free();
  FIPHeader.Free();

  inherited Destroy();
end;

procedure TclIcmpResponse.Parse(const ASource: TclByteArray; var AIndex: Integer);
begin
  FIPHeader.Parse(ASource, AIndex);

  FreeAndNil(FIcmpPacket);
  FIcmpPacket := CreatePacket(ASource, AIndex);
  try
    FIcmpPacket.Parse(ASource, AIndex);
  except
    FreeAndNil(FIcmpPacket);
    raise;
  end;
end;

end.
