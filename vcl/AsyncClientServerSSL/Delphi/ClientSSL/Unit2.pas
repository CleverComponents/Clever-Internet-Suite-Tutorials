unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, clTcpClient, clSspiTls, clAsyncClient, clSocket, clWUtils,
  clUtils, clTranslator;

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
    procedure clAsyncClient1AsyncError(Sender: TObject; AsyncAction:
        TclAsyncAction; AErrorCode: Integer; const AMessage: string);
    procedure clAsyncClient1Connect(Sender: TObject);
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

  //is used when running on Windows 10 version 1809 or later
  clAsyncClient1.UseSystemTLSFlags := False;

  //specifies TLS 1.0 protocols (also available SSL 2.0 and SSL 3.0)
  clAsyncClient1.TlsFlags := [tfUseTLS];

  //forces the component to start SSL negotiation immediately once connected
  clAsyncClient1.UseTls := True;

  clAsyncClient1.Open();
end;

procedure TForm2.clAsyncClient1Connect(Sender: TObject);
begin
  Caption := 'SSL Client - Connected';
end;

procedure TForm2.clAsyncClient1Read(Sender: TObject);
var
  stream: TMemoryStream;
  len: Integer;
  b: TclByteArray;
  s: string;
begin
  stream := TMemoryStream.Create();
  try
    case (clAsyncClient1.ReadData(stream)) of
      saWrite: clAsyncClient1.WriteData(nil);
      saNone:
      begin
        if (stream.Size > SizeOf(len)) then
        begin
          //read the size of incoming data
          stream.Position := 0;
          stream.Read(len, SizeOf(len));

          Assert((stream.Size - stream.Position) = len, 'To be simple, this situation is not handled in this sample');

          b.Length = len;

          //copy data
          stream.Read(b[0], len);

          s := TclTranslator.GetString(b, 'UTF-8');
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
  clAsyncClient1.Close();
  Caption := 'SSL Client';
end;

procedure TForm2.btnSendClick(Sender: TObject);
var
  stream: TStream;
  len: Integer;
  b: TclByteArray;
begin
  if (Length(edtData.Text) = 0) then raise Exception.Create('Nothing to send');

  stream := TMemoryStream.Create();
  try
    //write the size of data
    b := TclTranslator.GetBytes(edtData.Text, 'UTF-8');
    len := Length(b);
    stream.Write(len, SizeOf(len));

    //write data
    stream.Write(b[0], len);

    stream.Position := 0;
    clAsyncClient1.WriteData(stream);
  finally
    stream.Free();
  end;
end;

procedure TForm2.clAsyncClient1AsyncError(Sender: TObject; AsyncAction:
    TclAsyncAction; AErrorCode: Integer; const AMessage: string);
begin
  ShowMessage(AMessage);
end;

end.
