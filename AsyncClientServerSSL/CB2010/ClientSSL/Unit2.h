//---------------------------------------------------------------------------

#ifndef Unit2H
#define Unit2H
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "clAsyncClient.hpp"
//---------------------------------------------------------------------------
class TForm2 : public TForm
{
__published:	// IDE-managed Components
  TLabel *Label1;
  TLabel *Label2;
  TEdit *edtServer;
  TEdit *edtPort;
  TButton *btnConnect;
  TButton *btnDisconnect;
  TEdit *edtData;
  TButton *btnSend;
  TMemo *memResponse;
  TclAsyncClient *clAsyncClient1;
  void __fastcall btnConnectClick(TObject *Sender);
  void __fastcall btnDisconnectClick(TObject *Sender);
  void __fastcall btnSendClick(TObject *Sender);
  void __fastcall clAsyncClient1Connect(TObject *Sender, TclNetworkStreamAction ANextAction);
  void __fastcall clAsyncClient1Read(TObject *Sender);

private:	// User declarations
public:		// User declarations
  __fastcall TForm2(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TForm2 *Form2;
//---------------------------------------------------------------------------
#endif
