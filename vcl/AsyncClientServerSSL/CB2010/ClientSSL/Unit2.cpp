//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Unit2.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "clAsyncClient"
#pragma resource "*.dfm"
TForm2 *Form2;
//---------------------------------------------------------------------------
__fastcall TForm2::TForm2(TComponent* Owner)
  : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TForm2::btnConnectClick(TObject *Sender)
{
  if (clAsyncClient1->Active) throw new Exception("Client already connected");

  clAsyncClient1->Server = edtServer->Text;
  clAsyncClient1->Port = StrToInt(edtPort->Text);
  clAsyncClient1->TimeOut = 10000;

  //is necessary when using self-signed certificate by server
  clAsyncClient1->CertificateFlags = TclCertificateVerifyFlags() << cfIgnoreCommonNameInvalid << cfIgnoreUnknownAuthority;

  //specifies TLS 1.0 protocols (also available SSL 2.0 and SSL 3.0)
  clAsyncClient1->TLSFlags = TclTlsFlags() << tfUseTLS;

  //forces the component to start SSL negotiation immediately once connected
  clAsyncClient1->UseTLS = true;

  clAsyncClient1->Open();

  Caption = "SSL Client - Connected";
}
//---------------------------------------------------------------------------

void __fastcall TForm2::btnDisconnectClick(TObject *Sender)
{
  if (clAsyncClient1->Close() == saWrite) {
    clAsyncClient1->WriteData(NULL);
  }
  Caption = "SSL Client";
}
//---------------------------------------------------------------------------

void __fastcall TForm2::btnSendClick(TObject *Sender)
{
  TStream *stream = new TMemoryStream();
  __try {
    //write the size of data
    AnsiString s = edtData->Text;
    __int64 len = s.Length();
    stream->Write(&len, sizeof(len));

    //write data
    stream->Write(reinterpret_cast<PAnsiChar *>(s.c_str()), len);

    stream->Position = 0;
    clAsyncClient1->WriteData(stream);
  }
  __finally {
    delete stream;
  }
}
//---------------------------------------------------------------------------

void __fastcall TForm2::clAsyncClient1Connect(TObject *Sender, TclNetworkStreamAction ANextAction)

{
  if (ANextAction == saWrite) {
    clAsyncClient1->WriteData(NULL);
  }
}
//---------------------------------------------------------------------------

void __fastcall TForm2::clAsyncClient1Read(TObject *Sender)
{
  TStream *stream = new TMemoryStream();
  __try {
        switch (clAsyncClient1->ReadData(stream)) {
            case saWrite: {
              clAsyncClient1->WriteData(NULL);
              break;
            }
            case saNone: {
                if (stream->Size > sizeof(__int64)) {
                    //read size of incoming data
                    stream->Position = 0;

                    __int64 len;
                    stream->Read(&len, sizeof(len));

                    assert((stream->Size - stream->Position) == len); //To be simple, this situation is not handled in this sample

                    AnsiString s;
                    s.SetLength(len);

                    //copy data
                    stream->Read(reinterpret_cast<PAnsiChar *>(s.c_str()), len);

                    memResponse->Lines->Add("Received from server: " + s);
                }
                break;
            }
        }
  }
  __finally {
    delete stream;
  }
}
//---------------------------------------------------------------------------
