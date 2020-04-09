//---------------------------------------------------------------------------

#ifndef SslClientH
#define SslClientH

#include <clTcpClient.hpp>

class TMySSLClient : public TclTcpClient {
public:
  virtual __fastcall TMySSLClient(Classes::TComponent* AOwner) : TclTcpClient(AOwner){};
  virtual int __fastcall GetDefaultPort(void);
  void __fastcall SendData(TStream *data);
  void __fastcall ReceiveData(TStream *data);
};

//---------------------------------------------------------------------------
#endif
