//---------------------------------------------------------------------------

#ifndef SslClientH
#define SslClientH

#include <clTcpClientTls.hpp>

class TMySSLClient : public TclTcpClientTls {
public:
  virtual __fastcall TMySSLClient(Classes::TComponent* AOwner) : TclTcpClientTls(AOwner){};
  virtual int __fastcall GetDefaultPort(void);
  void __fastcall SendData(TStream *data);
  void __fastcall ReceiveData(TStream *data);
};

//---------------------------------------------------------------------------
#endif
