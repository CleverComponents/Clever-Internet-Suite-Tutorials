//---------------------------------------------------------------------------


#pragma hdrstop

#include "clSslServer.h"

//---------------------------------------------------------------------------

#pragma package(smart_init)

void __fastcall TclSslServer::DoReadConnection(TclUserConnection* AConnection, Classes::TStream* AData)
{
  if (AData->Size == 0) return;

  TclTcpServer::DoReadConnection(AConnection, AData);

  //send data to the client
  AData->Position = 0;
  AConnection->WriteData(AData);
}

