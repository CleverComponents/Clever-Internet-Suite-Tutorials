//---------------------------------------------------------------------------

#ifndef SslServerH
#define SslServerH

#include <clTcpServerTls.hpp>

class TMySslCommandConnection : public TclUserConnectionTls {
};

class TMySslServer : public TclTcpServerTls {
protected:
  virtual TclUserConnection* __fastcall CreateDefaultConnection();
  virtual void __fastcall DoReadConnection(TclUserConnection* AConnection, Classes::TStream* AData);
public:
  __fastcall TMySslServer(TComponent* Owner) : TclTcpServerTls(Owner) {};
};

//---------------------------------------------------------------------------
#endif
