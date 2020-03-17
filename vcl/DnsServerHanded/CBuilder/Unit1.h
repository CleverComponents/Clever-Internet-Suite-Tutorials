//---------------------------------------------------------------------------

#ifndef Unit1H
#define Unit1H
//---------------------------------------------------------------------------
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Forms.hpp>
#include "clDnsServer.hpp"
#include "clUdpServer.hpp"
//---------------------------------------------------------------------------
class TForm1 : public TForm
{
__published:	// IDE-managed Components
  TButton *Button1;
  TButton *Button2;
  TMemo *Memo1;
  TclDnsServer *clDnsServer1;
  TLabel *Label1;
  TEdit *edtPort;
  TLabel *Label2;
  TEdit *edtBinding;
  void __fastcall Button1Click(TObject *Sender);
  void __fastcall clDnsServer1Start(TObject *Sender);
  void __fastcall clDnsServer1Stop(TObject *Sender);
  void __fastcall clDnsServer1ReceiveQuery(TObject *Sender, TclUdpUserConnection *AConnection,
          TclDnsMessage *AQuery);
  void __fastcall clDnsServer1SendResponse(TObject *Sender, TclUdpUserConnection *AConnection,
          TclDnsMessage *AQuery, TclDnsMessage *AResponse);
  void __fastcall clDnsServer1GetHandedRecords(TObject *Sender, TclUdpUserConnection *AConnection,
          const UnicodeString AName, TclDnsRecordList *ARecords);
  void __fastcall Button2Click(TObject *Sender);


private:	// User declarations
  TCriticalSection *FSynchronizer;
  void __fastcall PutLogMessage(const UnicodeString ALogMessage);
public:		// User declarations
  __fastcall TForm1(TComponent* Owner);
  virtual __fastcall ~TForm1(void);
};
//---------------------------------------------------------------------------
extern PACKAGE TForm1 *Form1;
//---------------------------------------------------------------------------
#endif
