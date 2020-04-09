//---------------------------------------------------------------------------
#pragma hdrstop

#include "SslClient.h"

#pragma link "clTcpClient"

int __fastcall TMySSLClient::GetDefaultPort(void) {
  return 9002;
}

void __fastcall TMySSLClient::SendData(TStream *data) {
  Connection->WriteData(data);
}

void __fastcall TMySSLClient::ReceiveData(TStream *data) {
  TStream *stream = new TMemoryStream();
  __try {
    //read size of incoming data
    while(stream->Size < 8) {
      Connection->ReadData(stream);
    }
    stream->Position = 0;

    DWORD len = 0;
    stream->Read(&len, 8);

    //copy the first block of data
    if(stream->Size > 8) {
      data->CopyFrom(stream, stream->Size - 8);
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
