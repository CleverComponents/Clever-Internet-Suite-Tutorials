unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, clTcpClient, clSspiTls, clAsyncClient, clSocket, clUtils, clTranslator;

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
    edtFileName: TEdit;
    btnSendFile: TButton;
    procedure btnConnectClick(Sender: TObject);
    procedure btnDisconnectClick(Sender: TObject);
    procedure btnSendClick(Sender: TObject);
    procedure clAsyncClient1Read(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnSendFileClick(Sender: TObject);
  private
    FResponseLen: Integer;
    FResponse: TStringStream;
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

procedure TForm2.clAsyncClient1Read(Sender: TObject);
var
  stream: TMemoryStream;
  len: Integer;
begin
  stream := TMemoryStream.Create();
  try
    case (clAsyncClient1.ReadData(stream)) of
      saWrite: clAsyncClient1.WriteData(nil);
      saNone:
      begin
        if (stream.Size > 0) then
        begin
          stream.Position := 0;

          if (FResponseLen = 0) then
          begin
            //read the size of incoming data
            stream.Read(FResponseLen, SizeOf(FResponseLen));
          end;

          len := stream.Size - stream.Position;
          if (len > 0) then
          begin
            //collect incoming data
            FResponse.CopyFrom(stream, len);
          end;

          if (FResponseLen = FResponse.Size) then
          begin
            //response received completely
            memResponse.Lines.Add('Received from server: ' + FResponse.DataString);
          end;
        end;
      end;
    end;
  finally
    stream.Free();
  end;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  FResponse := TStringStream.Create('');
end;

procedure TForm2.FormDestroy(Sender: TObject);
begin
  FResponse.Free();
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
  buf: TclByteArray;
begin
  FResponseLen := 0;
  FResponse.Size := 0;

  stream := TMemoryStream.Create();
  try
    //write the size of data
    buf := TclTranslator.GetBytes(edtData.Text);
    len := Length(buf);
    stream.Write(len, SizeOf(len));

    //write data
    stream.Write(buf[0], len);

    stream.Position := 0;
    clAsyncClient1.WriteData(stream);
  finally
    stream.Free();
  end;
end;

procedure TForm2.btnSendFileClick(Sender: TObject);
var
  stream, sizeStream: TStream;
  len: Integer;
begin
  FResponseLen := 0;
  FResponse.Size := 0;

  stream := TFileStream.Create(edtFileName.Text, fmOpenRead);
  sizeStream := TMemoryStream.Create();
  try
    //obtain the size of file
    len := stream.Size;
    sizeStream.Write(len, SizeOf(len));

    //write the size of file
    sizeStream.Position := 0;
    clAsyncClient1.WriteData(sizeStream);

    //write file
    clAsyncClient1.WriteData(stream);
  finally
    sizeStream.Free();
    stream.Free();
  end;
end;

end.
