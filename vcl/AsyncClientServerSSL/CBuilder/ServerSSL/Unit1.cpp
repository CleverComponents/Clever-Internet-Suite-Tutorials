//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Unit1.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "clCertificateStore"
#pragma resource "*.dfm"
TForm1 *Form1;
//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent* Owner)
	: TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TForm1::FormCreate(TObject *Sender)
{
  FSynchronizer = new TCriticalSection();

  FServer = new TclSslServer(NULL);

  //assigns event handlers for server
  FServer->OnGetCertificate = DoGetCertificate;
  FServer->OnAcceptConnection = DoAcceptConnection;
  FServer->OnCloseConnection = DoCloseConnection;
  FServer->OnReadConnection = DoReadConnection;
  FServer->OnStart = DoStart;
  FServer->OnStop = DoStop;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::FormDestroy(TObject *Sender)
{
  delete FServer;
  delete FSynchronizer;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::btnStartClick(TObject *Sender)
{
  FServer->Port = StrToInt(edtPort->Text);

  //forces the component to start SSL negotiation immediately once connecting
  FServer->UseTLS = stImplicit;

  //is used when running on Windows 10 version 1809 or later
  FServer->UseSystemTLSFlags = false;

  //specifies TLS 1.0 protocols (also available SSL 2.0 and SSL 3.0)
  FServer->TLSFlags = TclTlsFlags() << tfUseTLS;

  //do not request client certificate for impersonation purposes
  FServer->RequireClientCertificate = false;

  FServer->Start();
}
//---------------------------------------------------------------------------

void __fastcall TForm1::btnStopClick(TObject *Sender)
{
  FIsStop = true;
  __try
  {
	FServer->Stop();
  }
  __finally
  {
    FIsStop = false;
  }
}
//---------------------------------------------------------------------------

void __fastcall TForm1::btnSendClick(TObject *Sender)
{
  if (edtData->Text.Length() == 0) throw new Exception("Nothing to send");

  FServer->BeginWork();
  TStream *stream = new TMemoryStream();
  __try
  {
	//write the size of data
	TclByteArray b = TclTranslator::GetBytes(edtData->Text, "UTF-8");
	int len = b.Length;
	stream->Write(&len, sizeof(len));

	//write data
	stream->Write(&b[0], len);

	for (int i = 0; i < FServer->ConnectionCount; i++)
	{
	  stream->Position = 0;
	  FServer->Connections[i]->WriteData(stream);
	}
  }
  __finally
  {
    delete stream;
    FServer->EndWork();
  }
}
//---------------------------------------------------------------------------

void __fastcall TForm1::DoGetCertificate(TObject *Sender, TclCertificate *&ACertificate,
  TclCertificateList *AExtraCerts, bool &Handled)
{
  //creates self-signed server certificate
  if (clCertificateStore1->Items->Count == 0)
  {
	clCertificateStore1->ValidFrom = Date();
	clCertificateStore1->ValidTo = Date() + 365;
	clCertificateStore1->Items->Add(clCertificateStore1->CreateSelfSigned("CN=CleverTester,O=CleverComponents,E=CleverTester@company.mail", 0));
  }
  ACertificate = clCertificateStore1->Items->Items[0];
  Handled = true;
}

void __fastcall TForm1::DoAcceptConnection(TObject* Sender, TclUserConnection* AConnection, bool &Handled)
{
  PutLogMessage("Connected client: " + AConnection->PeerIP);
}

void __fastcall TForm1::DoCloseConnection(TObject* Sender, TclUserConnection* AConnection)
{
  if (!FIsStop)
  {
	PutLogMessage("Close Connection. Host: " + AConnection->PeerIP);
  }
}

void __fastcall TForm1::DoReadConnection(TObject* Sender, TclUserConnection* AConnection, TStream* AData)
{
  PutLogMessage(Format("Received from %s client: %d bytes", ARRAYOFCONST((AConnection->PeerIP, AData->Size))));
}

void __fastcall TForm1::DoStart(TObject *Sender)
{
  PutLogMessage("=== Start ===");
}

void __fastcall TForm1::DoStop(TObject *Sender)
{
  PutLogMessage("=== Stop");
}

void __fastcall TForm1::PutLogMessage(const AnsiString ALogMessage)
{
  if (!ComponentState.Contains(csDestroying))
  {
    FSynchronizer->Enter();
    __try
    {
      memLog->Lines->Add(ALogMessage);
    }
    __finally
    {
      FSynchronizer->Leave();
    }
  }
}

