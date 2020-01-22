unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, clIcmp, clSocket;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    edtHost: TEdit;
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  client: TclIcmpConnection;
  response: TclIcmpResponse;
  i: Integer;
begin
  StartupSocket();
  client := TclIcmpConnection.Create();
  try
    client.NetworkStream := TclNetworkStream.Create();
    client.TimeOut := 1000;
    client.Open(TclHostResolver.GetIPAddress(edtHost.Text));

    Memo1.Lines.Clear();
    response := nil;

    for i := 1 to 4 do
    begin
      try
        client.SendEchoRequest();
        response := client.ReceiveResponse();
        if not (response.IcmpPacket is TclIcmpEchoPacket) then raise Exception.Create('Invalid ICMP reply');

        Memo1.Lines.Add(Format('Reply from %s: seq=%d received bytes=%d time=%dms TTL=%d',
          [edtHost.Text,
          (response.IcmpPacket as TclIcmpEchoPacket).SequenceNumber,
          Length((response.IcmpPacket as TclIcmpEchoPacket).Data),
          response.RoundTripTime,
          response.IPHeader.TTL]));

          Sleep(1000);
      except
        on E: Exception do
        begin
          Memo1.Lines.Add(edtHost.Text + ' Error: ' + E.Message);
        end;
      end;

      FreeAndNil(response);
    end;

  finally
    client.Free();
    CleanupSocket();
  end;
end;

end.
