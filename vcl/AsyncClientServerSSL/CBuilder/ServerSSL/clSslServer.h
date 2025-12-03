//---------------------------------------------------------------------------

#ifndef clSslServerH
#define clSslServerH
//---------------------------------------------------------------------------

#include <clTcpServer.hpp>
#include <clTcpServerTls.hpp>

class TclSslServer : public TclTcpServerTls
{
protected:
  virtual void __fastcall DoReadConnection(TclUserConnection* AConnection, Classes::TStream* AData);
public:
	__fastcall TclSslServer(TComponent* Owner) : TclTcpServerTls(Owner) {};
};
#endif
