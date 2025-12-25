//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Unit1.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TForm1 *Form1;

__fastcall TSmtpWorkItem::TSmtpWorkItem(TForm1 *owner, const AnsiString connectionString)
{
  m_synchronizer = new TclThreadSynchronizer();
  m_smtp = new TclSmtp(NULL);
  m_message = new TclMailMessage(NULL);
  m_owner = owner;
  m_connectionString = connectionString;
}

__fastcall TSmtpWorkItem::~TSmtpWorkItem(void)
{
  delete m_message;
  delete m_smtp;
  delete m_synchronizer;
}

void __fastcall TSmtpWorkItem::LogMessage(const AnsiString msg)
{
  m_logMessage = msg;
  m_synchronizer->Synchronize(SyncLogMessage);
}

void __fastcall TSmtpWorkItem::SyncThreadDone(void)
{
  m_owner->ThreadDone();
}

void __fastcall TSmtpWorkItem::SyncLogMessage(void)
{
  m_owner->LogMessage(m_logMessage);
}

void __fastcall TSmtpWorkItem::SetupSmtp(TclSmtp *smtp)
{
  m_owner->SetupSmtp(smtp);
}

bool __fastcall TSmtpWorkItem::IsStop(void)
{
  return m_owner->IsStop();
}

TDataSet *__fastcall TSmtpWorkItem::CreateDataSet(void)
{
  //TODO create a dataset(query), connect it to a database using m_connectionString
  // For a complete implementation example using FireDAC and SQLite,
  // see the README.md file in this project.
  return NULL;
}

void __fastcall TSmtpWorkItem::ComposeEmail(TDataSet *ds)
{
  //TODO replace it with your field names
  m_message->BuildMessage(ds->FieldByName("text_content")->AsString, ds->FieldByName("html_content")->AsString);
  m_message->Subject = ds->FieldByName("subject")->AsString;
  m_message->From->FullAddress = ds->FieldByName("from_address")->AsString;
  m_message->ToList->Add(ds->FieldByName("tolist")->AsString);
}

void __fastcall TSmtpWorkItem::SendEmail(void)
{
  m_smtp->Send(m_message);
}

void __fastcall TSmtpWorkItem::Execute(Classes::TThread*)
{
  __try
  {
    SetupSmtp(m_smtp);

    LogMessage("Open: " + m_connectionString);
    m_smtp->Open();
    __try
    {
      TDataSet *ds = CreateDataSet();
      __try
      {
        ds->First();
        int cnt = 0;
        
        while (!ds->Eof)
        {
          if (IsStop())
            break;

          LogMessage("Send " + IntToStr(cnt) + ": " + m_connectionString);
          ComposeEmail(ds);
          try
          {
            SendEmail();
          }
          catch (EclSocketError&)
          {
            m_smtp->Close();
            m_smtp->Open();
          }

          cnt++;
          ds->Next();
        }
      }
      __finally
      {
        delete ds;
      }
    }
    __finally
    {
      m_smtp->Close();
      LogMessage("Close: " + m_connectionString);
    }
  }
  __finally
  {
    m_synchronizer->Synchronize(SyncThreadDone);
  }
}

//---------------------------------------------------------------------------

__fastcall TForm1::TForm1(TComponent* Owner) : TForm(Owner)
{
  m_threadPool = new TclThreadPool(NULL);
  SetThreadCounter(0);
}

__fastcall TForm1::~TForm1(void)
{
  delete m_threadPool;
}

void __fastcall TForm1::SetThreadCounter(int counter)
{
  if (counter < 0)
    counter = 0;

  m_threadCount = counter;
  edtCount->Text = IntToStr(m_threadCount);
  Application->ProcessMessages();
}

void __fastcall TForm1::ThreadDone(void)
{
  SetThreadCounter(m_threadCount - 1);
}

void __fastcall TForm1::LogMessage(const AnsiString msg)
{
  memLog->Lines->Add(msg);
}

void __fastcall TForm1::SetupSmtp(TclSmtp *smtp)
{
  smtp->Server = edtServer->Text;
  smtp->UserName = edtUser->Text;
  smtp->Password = edtPassword->Text;
}

bool __fastcall TForm1::IsStop(void)
{
  return m_isStop;
}

void __fastcall TForm1::btnStartClick(TObject *)
{
  m_isStop = false;
  m_threadPool->QueueWorkItem(new TSmtpWorkItem(this, edtConnectionString->Text));
  SetThreadCounter(m_threadCount + 1);
}

void __fastcall TForm1::btnStopClick(TObject *)
{
  m_isStop = true;
  while(m_threadCount > 0)
    Application->ProcessMessages();
  m_threadPool->Stop();
  SetThreadCounter(0);
}

