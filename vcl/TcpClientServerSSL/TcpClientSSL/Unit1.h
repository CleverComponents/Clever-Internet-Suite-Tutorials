//---------------------------------------------------------------------------

#ifndef Unit1H
#define Unit1H
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "SslClient.h"
//---------------------------------------------------------------------------
class TForm1 : public TForm
{
__published:	// IDE-managed Components
  TButton *btnConnect;
  TLabel *Label1;
  TEdit *edtServer;
  TLabel *Label2;
  TEdit *edtPort;
  TEdit *edtData;
  TButton *btnDisconnect;
  TButton *btnSend;
  TMemo *memLog;
  void __fastcall btnConnectClick(TObject *Sender);
  void __fastcall btnDisconnectClick(TObject *Sender);
  void __fastcall btnSendClick(TObject *Sender);
private:	// User declarations
  TMySSLClient *m_client;
public:		// User declarations
  __fastcall TForm1(TComponent* Owner);
  virtual __fastcall ~TForm1(void);
};

//---------------------------------------------------------------------------
extern PACKAGE TForm1 *Form1;
//---------------------------------------------------------------------------
#endif
