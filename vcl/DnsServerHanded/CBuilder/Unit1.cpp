//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Unit1.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "clDnsServer"
#pragma link "clUdpServer"
#pragma resource "*.dfm"
TForm1 *Form1;
//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent* Owner): TForm(Owner)
{
  FSynchronizer = new TCriticalSection();
  edtPort->Text =  IntToStr(clDnsServer1->Port);
}
//---------------------------------------------------------------------------
__fastcall TForm1::~TForm1(void)
{
  delete FSynchronizer;
}
//---------------------------------------------------------------------------
void __fastcall TForm1::Button1Click(TObject *Sender)
{
  if (clDnsServer1->Active) {
    ShowMessage("The server is started");
    return;
  }

  clDnsServer1->LocalBinding = edtBinding->Text;
  clDnsServer1->Port = StrToInt(edtPort->Text);
  clDnsServer1->Start();
}
//---------------------------------------------------------------------------
void __fastcall TForm1::Button2Click(TObject *Sender)
{
  clDnsServer1->Stop();
}
//---------------------------------------------------------------------------
void __fastcall TForm1::PutLogMessage(const UnicodeString ALogMessage)
{
  if (!ComponentState.Contains(csDestroying))
  {
    FSynchronizer->Enter();
    __try
    {
      Memo1->Lines->Add(ALogMessage);
    }
    __finally
    {
      FSynchronizer->Leave();
    }
  }
}
//---------------------------------------------------------------------------
void __fastcall TForm1::clDnsServer1Start(TObject *Sender)
{
  PutLogMessage("=== Server start ===");
}
//---------------------------------------------------------------------------
void __fastcall TForm1::clDnsServer1Stop(TObject *Sender)
{
  PutLogMessage("=== Stop");
}
//---------------------------------------------------------------------------

void __fastcall TForm1::clDnsServer1ReceiveQuery(TObject *Sender, TclUdpUserConnection *AConnection,
          TclDnsMessage *AQuery)
{
  if (AQuery->Queries->Count > 0) {
    PutLogMessage("Query received: " + GetRecordTypeStr(AQuery->Queries->Items[0]->RecordType) + " "
      + AQuery->Queries->Items[0]->Name);
  }
  else {
    PutLogMessage("Query received");
  }
}
//---------------------------------------------------------------------------

void __fastcall TForm1::clDnsServer1SendResponse(TObject *Sender, TclUdpUserConnection *AConnection,
          TclDnsMessage *AQuery, TclDnsMessage *AResponse)

{
  if (AResponse->Answers->Count > 0) {
    PutLogMessage("Response sent: " + GetRecordTypeStr(AResponse->Answers->Items[0]->RecordType) + " "
      + AResponse->Answers->Items[0]->Name);
  }
  else {
    PutLogMessage("Response sent");
  }
}
//---------------------------------------------------------------------------

void __fastcall TForm1::clDnsServer1GetHandedRecords(TObject *Sender, TclUdpUserConnection *AConnection,
          const UnicodeString AName, TclDnsRecordList *ARecords)

{
  ARecords->Clear();

  TclDnsSOARecord *soaRec = new TclDnsSOARecord();
  ARecords->Add(soaRec);

  soaRec->Name = AName;
  soaRec->ExpirationLimit = 123;
  soaRec->MinimumTTL = 456;
  soaRec->RetryInterval = 789;
  soaRec->SerialNumber = 111222;
  soaRec->RefreshInterval = 987;
  soaRec->ResponsibleMailbox = "mail." + AName;
  soaRec->PrimaryNameServer = "ns." + AName;
  soaRec->TTL = 60000;

  TclDnsNSRecord *nsRec = new TclDnsNSRecord();
  ARecords->Add(nsRec);

  nsRec->Name = AName;
  nsRec->NameServer = "ns." + AName;
  nsRec->TTL = 665000;

  TclDnsARecord *aRec = new TclDnsARecord();
  ARecords->Add(aRec);

  aRec->Name = AName;
  aRec->IPAddress = "111.222.333.444";
  aRec->TTL = 60000;
}
//---------------------------------------------------------------------------

