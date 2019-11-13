//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Unit1.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"

TForm1 *Form1;
//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent* Owner)
  : TForm(Owner)
{
  m_client = new TMySSLClient(NULL);
}
//---------------------------------------------------------------------------

__fastcall TForm1::~TForm1(void) {
  delete m_client;
}
//---------------------------------------------------------------------------
void __fastcall TForm1::btnConnectClick(TObject *Sender)
{
    if(m_client->Active)
      throw new Exception("Client already connected");

    m_client->Server = edtServer->Text;
    m_client->Port = StrToInt(edtPort->Text);
    m_client->TimeOut = 10000;

    //is necessary when using self-signed certificate by server
    m_client->CertificateFlags = TclCertificateVerifyFlags()
      << cfIgnoreCommonNameInvalid << cfIgnoreUnknownAuthority;

    //specifies TLS 1.0 protocols (also available SSL 2.0 and SSL 3.0)
    m_client->TLSFlags = TclTlsFlags() << tfUseTLS;

    //forces the component to start SSL negotiation immediately once connecting
    m_client->UseTLS = ctImplicit;

    m_client->Open();

    this->Text = "SSL Client - Connected";
}
//---------------------------------------------------------------------------

void __fastcall TForm1::btnDisconnectClick(TObject *Sender)
{
    m_client->Close();
    this->Text = "SSL Client";
}
//---------------------------------------------------------------------------

void __fastcall TForm1::btnSendClick(TObject *Sender)
{
  TStringStream *stream = new TStringStream(edtData->Text);
  __try {
    m_client->SendData(stream);

    stream->Size = 0;
    m_client->ReceiveData(stream);
    memLog->Lines->Add("Received from server: " + stream->DataString);
  }
  __finally {
      delete stream;
  }
}
//---------------------------------------------------------------------------

