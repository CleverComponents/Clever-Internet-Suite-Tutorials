//---------------------------------------------------------------------------

#ifndef clSslServerH
#define clSslServerH
//---------------------------------------------------------------------------

#include <clTcpServer.hpp>

class TclSslUserConnection : public TclUserConnection {
};

class TclSslServer : public TclTcpServer {
protected:
  virtual void __fastcall DoReadConnection(TclUserConnection* AConnection, Classes::TStream* AData);
  virtual TclUserConnection* __fastcall CreateDefaultConnection(void);
public:
	__fastcall TclSslServer(TComponent* Owner) : TclTcpServer(Owner) {};
};
#endif
