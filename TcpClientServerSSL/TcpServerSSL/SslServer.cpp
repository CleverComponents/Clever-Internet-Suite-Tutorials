//---------------------------------------------------------------------------


#pragma hdrstop

#include "SslServer.h"

#pragma link "clTcpServer"


TclUserConnection* __fastcall TMySslServer::CreateDefaultConnection() {
    return new TMySslCommandConnection();
}

void __fastcall TMySslServer::DoReadConnection(TclUserConnection* AConnection, Classes::TStream* AData) {
  if(AData->Size == 0)
    return;

	TclTcpServer::DoReadConnection(AConnection, AData);

  //send the size of data to the client
  TStream *stream = new TMemoryStream();
  __try {
    DWORD len = AData->Size;
    stream->Write(&len, 8);
    stream->Position = 0;
    AConnection->WriteData(stream);
  }
  __finally {
      delete stream;
  }

  //send data to the client
  AData->Position = 0;
  AConnection->WriteData(AData);
}
//---------------------------------------------------------------------------
#pragma package(smart_init)

