//---------------------------------------------------------------------------

#ifndef Unit1H
#define Unit1H
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <clCertificateStore.hpp>
#include "SslServer.h"
//---------------------------------------------------------------------------
class TForm1 : public TForm
{
__published:	// IDE-managed Components
  TLabel *Label1;
  TEdit *edtPort;
  TButton *btnStart;
  TButton *btnStop;
  TLabel *Label2;
  TMemo *memLog;
  void __fastcall btnStartClick(TObject *Sender);
  void __fastcall btnStopClick(TObject *Sender);
private:	// User declarations
  TMySslServer *m_server;
  TclCertificateStore *m_certstore;
  TCriticalSection *m_synchronizer;

  void __fastcall PutLogMessage(const String logMessage);
  void __fastcall server_GetCertificate(TObject* Sender, TclCertificate* &ACertificate,
    TclCertificateList* AExtraCerts, bool &Handled);
  void __fastcall server_ConnectionAccepted(TObject* Sender, TclUserConnection* AConnection, bool &Handled);
  void __fastcall server_ConnectionClosed(TObject* Sender, TclUserConnection* AConnection);
  void __fastcall server_ConnectionRead(TObject* Sender, TclUserConnection* AConnection, TStream* AData);
  void __fastcall server_Started(TObject* Sender);
  void __fastcall server_Stopped(TObject* Sender);
public:		// User declarations
  __fastcall TForm1(TComponent* Owner);
  virtual __fastcall ~TForm1(void);
};
//---------------------------------------------------------------------------
extern PACKAGE TForm1 *Form1;
//---------------------------------------------------------------------------
#endif
