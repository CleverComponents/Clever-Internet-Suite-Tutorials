//---------------------------------------------------------------------------

#ifndef Unit1H
#define Unit1H
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <DB.hpp>
#include <clThreadPool.hpp>
#include <clSyncUtils.hpp>
#include <clSmtp.hpp>
#include <clMailMessage.hpp>
#include <clSocket.hpp>
//---------------------------------------------------------------------------

class TForm1 : public TForm
{
__published:	// IDE-managed Components
  TButton *btnStart;
  TLabel *Label1;
  TEdit *edtServer;
  TLabel *Label2;
  TEdit *edtUser;
  TLabel *Label3;
  TEdit *edtPassword;
  TLabel *Label4;
  TEdit *edtConnectionString;
  TButton *btnStop;
  TEdit *edtCount;
  TMemo *memLog;
	void __fastcall btnStartClick(TObject *Sender);
	void __fastcall btnStopClick(TObject *Sender);
private:	// User declarations
  TclThreadPool *m_threadPool;
  int m_threadCount;
  bool m_isStop;
  void __fastcall SetThreadCounter(int counter);
public:		// User declarations
  __fastcall TForm1(TComponent* Owner);
  virtual __fastcall ~TForm1(void);
  void __fastcall ThreadDone(void);
  void __fastcall LogMessage(const AnsiString msg);
  void __fastcall SetupSmtp(TclSmtp *smtp);
  bool __fastcall IsStop(void);
};

//---------------------------------------------------------------------------
class TSmtpWorkItem : public TclWorkItem
{
private:
  TForm1 *m_owner;
  AnsiString m_connectionString;
  TclThreadSynchronizer *m_synchronizer;
  AnsiString m_logMessage;
  TclSmtp *m_smtp;
  TclMailMessage *m_message;
  void __fastcall SyncThreadDone(void);
  void __fastcall SyncLogMessage(void);
  void __fastcall LogMessage(const AnsiString msg);
  void __fastcall SetupSmtp(TclSmtp *smtp);
  bool __fastcall IsStop(void);
  TDataSet *__fastcall CreateDataSet(void);
  void __fastcall ComposeEmail(TDataSet *ds);
  void __fastcall SendEmail(void);
protected:
  virtual void __fastcall Execute(Classes::TThread*);
public:
  __fastcall TSmtpWorkItem(TForm1 *owner, const AnsiString connectionString);
  virtual __fastcall ~TSmtpWorkItem(void);
};

//---------------------------------------------------------------------------
extern PACKAGE TForm1 *Form1;
//---------------------------------------------------------------------------
#endif
