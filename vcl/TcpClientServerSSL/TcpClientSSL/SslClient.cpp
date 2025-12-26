//---------------------------------------------------------------------------
#pragma hdrstop

#include <vcl.h>
#include <System.hpp>
#include "SslClient.h"

#pragma link "clTcpClientTls"

int __fastcall TMySSLClient::GetDefaultPort(void) {
  return 2110;
}

void __fastcall TMySSLClient::SendData(TStream *data) {
  Connection->WriteData(data);
}

void __fastcall TMySSLClient::ReceiveData(TStream *data) {
  TStream *stream = new TMemoryStream();
  __try {
    //read size of incoming data
    while(stream->Size < 4) {
      Connection->ReadData(stream);
    }
    stream->Position = 0;

    DWORD len = 0;
    stream->Read(&len, 4);

    //copy the first block of data
    if(stream->Size > 4) {
      data->CopyFrom(stream, stream->Size - 4);
    }

    //receive remaining data from server
    while(data->Size < len) {
      Connection->ReadData(data);
    }
  }
  __finally {
      delete stream;
  }
}

//---------------------------------------------------------------------------

#pragma package(smart_init)
