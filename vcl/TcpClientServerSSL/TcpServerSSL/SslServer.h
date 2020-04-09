//---------------------------------------------------------------------------

#ifndef SslServerH
#define SslServerH

#include <clTcpServer.hpp>

class TMySslCommandConnection : public TclUserConnection {
};

class TMySslServer : public TclTcpServer {
protected:
  virtual TclUserConnection* __fastcall CreateDefaultConnection();
  virtual void __fastcall DoReadConnection(TclUserConnection* AConnection, Classes::TStream* AData);
public:
  __fastcall TMySslServer(TComponent* Owner) : TclTcpServer(Owner) {};
};

//---------------------------------------------------------------------------
#endif
