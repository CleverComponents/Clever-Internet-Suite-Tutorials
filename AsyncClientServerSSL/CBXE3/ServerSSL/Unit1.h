//---------------------------------------------------------------------------

#ifndef Unit1H
#define Unit1H
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <clCertificateStore.hpp>
#include "clSslServer.h"
//---------------------------------------------------------------------------
class TForm1 : public TForm
{
__published:	// IDE-managed Components
	TLabel *Label1;
	TLabel *Label2;
	TEdit *edtPort;
	TButton *btnStart;
	TButton *btnStop;
	TMemo *memLog;
	TEdit *edtData;
	TButton *btnSend;
	TclCertificateStore *clCertificateStore1;
  void __fastcall FormCreate(TObject *Sender);
  void __fastcall FormDestroy(TObject *Sender);
  void __fastcall btnStartClick(TObject *Sender);
  void __fastcall btnStopClick(TObject *Sender);
  void __fastcall btnSendClick(TObject *Sender);
private:	// User declarations
  TCriticalSection *FSynchronizer;
  TclSslServer *FServer;
  bool FIsStop;

  void __fastcall DoGetCertificate(TObject *Sender, TclCertificate *&ACertificate,
    TclCertificateList *AExtraCerts, bool &Handled);
  void __fastcall DoAcceptConnection(TObject* Sender, TclUserConnection* AConnection, bool &Handled);
  void __fastcall DoCloseConnection(TObject* Sender, TclUserConnection* AConnection);
  void __fastcall DoReadConnection(TObject* Sender, TclUserConnection* AConnection, TStream* AData);
  void __fastcall DoStart(TObject *Sender);
  void __fastcall DoStop(TObject *Sender);
  void __fastcall PutLogMessage(const AnsiString ALogMessage);
public:		// User declarations
	__fastcall TForm1(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TForm1 *Form1;
//---------------------------------------------------------------------------
#endif
