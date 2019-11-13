unit ProxyHeader;

interface

uses
  Classes, SysUtils, clUtils, clTranslator;

type
  TProxyHeaderParser = class
  private
    FSourceAddress: string;
    FProxiedProtocol: string;
    FDestinationPort: Integer;
    FSourcePort: Integer;
    FDestinationAddress: string;
    FProxyPacketReceived: Boolean;
    FChecked: Boolean;
    FRemoveProxyHeader: Boolean;

    function Parse(AData: TStream): Boolean;
    function BytesPos(const ASubBytes, ABytes: TclByteArray; AStartFrom, ALength: Integer): Integer;
    procedure ExtractHeader(const AHeader: string);
    procedure RemoveHeader(AData: TStream; ACount: Integer);
  public
    constructor Create(ARemoveProxyHeader: Boolean);

    procedure Init;
    function Check(AData: TStream): Boolean;

    property ProxiedProtocol: string read FProxiedProtocol;
    property SourceAddress: string read FSourceAddress;
    property DestinationAddress: string read FDestinationAddress;
    property SourcePort: Integer read FSourcePort;
    property DestinationPort: Integer read FDestinationPort;

    property ProxyPacketReceived: Boolean read FProxyPacketReceived;
    property Checked: Boolean read FChecked;
  end;

implementation

{ TProxyHeaderParser }

function TProxyHeaderParser.BytesPos(const ASubBytes, ABytes: TclByteArray; AStartFrom, ALength: Integer): Integer;
var
  i, curPos, endPos: Integer;
begin
  curPos := 0;
  endPos := Length(ASubBytes);

  for i := AStartFrom to ALength - 1 do
  begin
    if (ABytes[i] = ASubBytes[curPos]) then
    begin
      Inc(curPos);
    end else
    begin
      curPos := 0;
      Continue;
    end;
    if (curpos = endPos) then
    begin
      Result := i - endPos + 1;
      Exit;
    end;
  end;
  Result := -1;
end;

procedure TProxyHeaderParser.ExtractHeader(const AHeader: string);
var
  list: TStrings;
begin
  list := TStringList.Create();
  try
    SplitText(AHeader, list, ' ');

    if (list.Count < 5) then Exit;

    FProxiedProtocol := list[0];
    FSourceAddress := list[1];
    FDestinationAddress := list[2];
    FSourcePort := StrToIntDef(list[3], 0);
    FDestinationPort := StrToIntDef(list[3], 0);
  finally
    list.Free();
  end;
end;

procedure TProxyHeaderParser.RemoveHeader(AData: TStream; ACount: Integer);
var
  buf: TclByteArray;
  len: Integer;
begin
  AData.Position := ACount;

  len := Integer(AData.Size - AData.Position);
  SetLength(buf, len);

  AData.ReadBuffer(buf, len);

  AData.Size := 0;

  AData.WriteBuffer(buf, len);
end;

function TProxyHeaderParser.Parse(AData: TStream): Boolean;
const
  ProxyLexem = 'PROXY ';
var
  buf, crlf: TclByteArray;
  eofBuf, len: Integer;
begin
  Result := False;

  Init();

  if (AData.Size < Length(ProxyLexem)) then Exit;

  AData.Position := 0;

  SetLength(buf, Length(ProxyLexem));
  AData.ReadBuffer(buf, Length(ProxyLexem));

  if (TclTranslator.GetString(buf, 'us-ascii') <> ProxyLexem) then Exit;

  len := 108 - Length(ProxyLexem);
  if (AData.Size - AData.Position < len) then
  begin
    len := AData.Size - AData.Position;
  end;
  SetLength(buf, len);

  AData.ReadBuffer(buf, len);

  crlf := TclTranslator.GetBytes(#13#10, 'us-ascii');
  eofBuf := BytesPos(crlf, buf, 0, len);

  if (eofBuf < 0) then Exit;

  ExtractHeader(TclTranslator.GetString(buf, 0, eofBuf, 'us-ascii'));

  if (FRemoveProxyHeader) then
  begin
    RemoveHeader(AData, eofBuf + Length(crlf) + Length(ProxyLexem));
  end;

  AData.Position := 0;
end;

function TProxyHeaderParser.Check(AData: TStream): Boolean;
begin
  if FChecked then
  begin
    Result := FProxyPacketReceived;
    Exit;
  end;
  FChecked := True;

  FProxyPacketReceived := Parse(AData);

  Result := FProxyPacketReceived;
end;

constructor TProxyHeaderParser.Create(ARemoveProxyHeader: Boolean);
begin
  inherited Create();

  FRemoveProxyHeader := ARemoveProxyHeader;
  Init();
end;

procedure TProxyHeaderParser.Init;
begin
  FProxiedProtocol := '';
  FSourceAddress := '';
  FDestinationAddress := '';
  FSourcePort := 0;
  FDestinationPort := 0;

  FProxyPacketReceived := False;
  FChecked := False;
end;

end.
