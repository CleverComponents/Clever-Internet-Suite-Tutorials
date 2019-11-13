unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, clTcpClient, clSspiTls, clAsyncClient, clSocket, clWUtils;

type
  TForm2 = class(TForm)
    Label1: TLabel;
    edtServer: TEdit;
    Label2: TLabel;
    edtPort: TEdit;
    btnConnect: TButton;
    btnDisconnect: TButton;
    edtData: TEdit;
    btnSend: TButton;
    memResponse: TMemo;
    clAsyncClient1: TclAsyncClient;
    procedure btnConnectClick(Sender: TObject);
    procedure btnDisconnectClick(Sender: TObject);
    procedure btnSendClick(Sender: TObject);
    procedure clAsyncClient1Connect(Sender: TObject; ANextAction: TclNetworkStreamAction);
    procedure clAsyncClient1Read(Sender: TObject);
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.btnConnectClick(Sender: TObject);
begin
  if (clAsyncClient1.Active) then raise Exception.Create('Client already connected');

  clAsyncClient1.Server := edtServer.Text;
  clAsyncClient1.Port := StrToInt(edtPort.Text);
  clAsyncClient1.TimeOut := 10000;

  //is necessary when using self-signed certificate by server
  clAsyncClient1.CertificateFlags := [cfIgnoreCommonNameInvalid, cfIgnoreUnknownAuthority];

  //specifies TLS 1.0 protocols (also available SSL 2.0 and SSL 3.0)
  clAsyncClient1.TlsFlags := [tfUseTLS];

  //forces the component to start SSL negotiation immediately once connected
  clAsyncClient1.UseTls := True;

  clAsyncClient1.Open();

  Caption := 'SSL Client - Connected';
end;

procedure TForm2.clAsyncClient1Connect(Sender: TObject; ANextAction: TclNetworkStreamAction);
begin
  if (ANextAction = saWrite) then
  begin
    clAsyncClient1.WriteData(nil);
  end;
end;

procedure TForm2.clAsyncClient1Read(Sender: TObject);
var
  stream: TMemoryStream;
  len: Int64;
  s: TclString;
begin
  stream := TMemoryStream.Create();
  try
    case (clAsyncClient1.ReadData(stream)) of
      saWrite: clAsyncClient1.WriteData(nil);
      saNone:
      begin
        if (stream.Size > SizeOf(Int64)) then
        begin
          //read size of incoming data
          stream.Position := 0;
          stream.Read(len, SizeOf(len));

          Assert((stream.Size - stream.Position) = len, 'To be simple, this situation is not handled in this sample');

          SetLength(s, len);

          //copy data
          stream.Read(PclChar(s)^, len);

          memResponse.Lines.Add('Received from server: ' + s);
        end;
      end;
    end;
  finally
    stream.Free();
  end;
end;

procedure TForm2.btnDisconnectClick(Sender: TObject);
begin
  if (clAsyncClient1.Close() = saWrite) then
  begin
    clAsyncClient1.WriteData(nil);
  end;
  Caption := 'SSL Client';
end;

procedure TForm2.btnSendClick(Sender: TObject);
var
  stream: TStream;
  len: Int64;
  s: TclString;
begin
  stream := TMemoryStream.Create();
  try
    //write the size of data
    s := edtData.Text;
    len := Length(s);
    stream.Write(len, SizeOf(len));

    //write data
    stream.Write(PclChar(s)^, len);

    stream.Position := 0;
    clAsyncClient1.WriteData(stream);
  finally
    stream.Free();
  end;
end;

end.
