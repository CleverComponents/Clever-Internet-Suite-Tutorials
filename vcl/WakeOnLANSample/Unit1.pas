unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, clSocket, WinSock;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    edtMAC: TEdit;
    btnWakeUp: TButton;
    procedure btnWakeUpClick(Sender: TObject);
  private
    function GetWakeUpPacket(const AMac: string): TBytes;
    function HexToByte(const AHex: string): Byte;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function TForm1.HexToByte(const AHex: string): Byte;
begin
  Result := 0;
  if Length(AHex) <= (SizeOf(LongWord) * 2) then
  begin
    Result := Byte(StrToInt('$' + AHex));
  end;
end;

function TForm1.GetWakeUpPacket(const AMac: string): TBytes;
var
  i, j: Integer;
  macParts: TArray<string>;
  cleanMac: string;
begin
  // Validate MAC format
  cleanMac := StringReplace(AMac, ':', '-', [rfReplaceAll]);
  macParts := cleanMac.Split(['-']);

  if Length(macParts) <> 6 then
    raise Exception.Create('Invalid MAC address format. Use: 12-34-56-78-9A-BC');

  SetLength(Result, 102);

  // 6 bytes of FF
  for i := 0 to 5 do
  begin
    Result[i] := $FF;
  end;

  // 16 repetitions of MAC address
  for i := 0 to 15 do
  begin
     for j := 0 to 5 do
     begin
       Result[6 + i * 6 + j] := HexToByte(AMac[3 * j + 1] + AMac[3 * j + 2]);
     end;
  end;
end;

procedure TForm1.btnWakeUpClick(Sender: TObject);
var
  client: TclUdpClientConnection;
begin
  client := TclUdpClientConnection.Create();
  StartupSocket();
  try

    client.NetworkStream := TclNetworkStream.Create();

    client.Open('255.255.255.255', 2110);
    client.Broadcast();

    client.WriteBytes(GetWakeUpPacket(edtMAC.Text));
  finally
    client.Free();
    CleanupSocket();
  end;

  ShowMessage('Done');
end;

end.
