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
  m_server = new TMySslServer(NULL);
  m_certstore = new TclCertificateStore(NULL);
  m_synchronizer = new TCriticalSection();

  //assigns event handlers for server
  m_server->OnGetCertificate = server_GetCertificate;
  m_server->OnAcceptConnection = server_ConnectionAccepted;
  m_server->OnCloseConnection = server_ConnectionClosed;
  m_server->OnReadConnection = server_ConnectionRead;
  m_server->OnStart = server_Started;
  m_server->OnStop = server_Stopped;
}

__fastcall TForm1::~TForm1(void) {
  delete m_synchronizer;
  delete m_certstore;
  delete m_server;
}

void __fastcall TForm1::PutLogMessage(const String logMessage) {
  if (!ComponentState.Contains(csDestroying)) {
    m_synchronizer->Enter();
    __try {
      memLog->Lines->Add(logMessage);
    }
    __finally {
      m_synchronizer->Leave();
    }
  }
}

void __fastcall TForm1::server_GetCertificate(TObject* Sender, TclCertificate* &ACertificate,
  TclCertificateList* AExtraCerts, bool &Handled) {
  //creates self-signed server certificate
  if (m_certstore->Items->Count == 0) {
    m_certstore->ValidFrom = Now();
    m_certstore->ValidTo = Now() + 365;
    ACertificate = m_certstore->CreateSelfSigned("CN=CleverTester,O=CleverComponents,E=CleverTester@company.mail", 0);
    m_certstore->Items->Add(ACertificate);
  }
  ACertificate = m_certstore->Items->Items[0];
  Handled = true;
}

void __fastcall TForm1::server_ConnectionAccepted(TObject* Sender,
  TclUserConnection* AConnection, bool &Handled) {
  PutLogMessage("Connected client: " + AConnection->PeerIP);
}

void __fastcall TForm1::server_ConnectionClosed(TObject* Sender, TclUserConnection* AConnection) {
  PutLogMessage("Disconnected client: " + AConnection->PeerIP);
}

void __fastcall TForm1::server_ConnectionRead(TObject* Sender,
  TclUserConnection* AConnection, TStream* AData) {
  PutLogMessage("Received from " + AConnection->PeerIP + " client: " + IntToStr(AData->Size) + " bytes");
}

void __fastcall TForm1::server_Started(TObject* Sender) {
  PutLogMessage("=== Start ===");
}

void __fastcall TForm1::server_Stopped(TObject* Sender) {
  PutLogMessage("=== Stop");
}

void __fastcall TForm1::btnStartClick(TObject *Sender)
{
  m_server->Port = StrToInt(edtPort->Text);

  //forces the component to start SSL negotiation immediately once connecting
  m_server->UseTLS = stImplicit;

  //specifies TLS 1.0 protocols (also available SSL 2.0 and SSL 3.0)
  m_server->TLSFlags = TclTlsFlags() << tfUseTLS;

  //do not request client certificate for impersonation purposes
  m_server->RequireClientCertificate = false;

  m_server->Start();
}

void __fastcall TForm1::btnStopClick(TObject *Sender)
{
  m_server->Stop();
}
//---------------------------------------------------------------------------
