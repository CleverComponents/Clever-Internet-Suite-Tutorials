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

  //is used when running on Windows 10 version 1809 or later
  clAsyncClient1->UseSystemTLSFlags = false;

  //specifies TLS 1.0 protocols (also available SSL 2.0 and SSL 3.0)
  clAsyncClient1->TLSFlags = TclTlsFlags() << tfUseTLS;

  //forces the component to start SSL negotiation immediately once connected
  clAsyncClient1->UseTLS = true;

  clAsyncClient1->Open();
}
//---------------------------------------------------------------------------

void __fastcall TForm2::btnDisconnectClick(TObject *Sender)
{
  clAsyncClient1->Close();
  Caption = "SSL Client";
}
//---------------------------------------------------------------------------

void __fastcall TForm2::btnSendClick(TObject *Sender)
{
  if (edtData->Text.Length() == 0) throw new Exception("Nothing to send");

  TStream *stream = new TMemoryStream();
  __try
  {
	//write the size of data
	TclByteArray b = TclTranslator::GetBytes(edtData->Text, "UTF-8");
	int len = b.Length;
	stream->Write(&len, sizeof(len));

	//write data
	stream->Write(&b[0], len);

	stream->Position = 0;
	clAsyncClient1->WriteData(stream);
  }
  __finally
  {
    delete stream;
  }
}
//---------------------------------------------------------------------------

void __fastcall TForm2::clAsyncClient1Connect(TObject *Sender)
{
  Caption = "SSL Client - Connected";
}
//---------------------------------------------------------------------------

void __fastcall TForm2::clAsyncClient1Read(TObject *Sender)
{
  TStream *stream = new TMemoryStream();
  __try
  {
    switch (clAsyncClient1->ReadData(stream))
    {
        case Clsocket::saWrite:
        {
          clAsyncClient1->WriteData(NULL);
          break;
        }
        case Clsocket::saNone:
        {
            if (stream->Size > sizeof(int))
            {
                //read size of incoming data
                stream->Position = 0;

                int len;
                stream->Read(&len, sizeof(len));

                assert((stream->Size - stream->Position) == len); //To be simple, this situation is not handled in this sample

                TclByteArray b;
                b.Length = len;

                //copy data
	        stream->Read(&b[0], len);

                UnicodeString s = TclTranslator::GetString(b, "UTF-8");
                memResponse->Lines->Add("Received from server: " + s);
            }
            break;
        }
    }
  }
  __finally
  {
    delete stream;
  }
}
//---------------------------------------------------------------------------
void __fastcall TForm2::clAsyncClient1AsyncError(TObject *Sender, TclAsyncAction AsyncAction,
		  int AErrorCode, const UnicodeString AMessage)
{
  ShowMessage(AMessage);
}
//---------------------------------------------------------------------------

