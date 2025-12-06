//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Unit1.h"
#include "WinSock.h"
#include "clSocket.hpp"

//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TForm1 *Form1;
//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent* Owner)
        : TForm(Owner)
{
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Button1Click(TObject *Sender)
{
  Memo1->Lines->Clear();

  TWSAData wsaData;
  WSAStartup(0x202, &wsaData);

  TclTcpClientConnection *client = NULL;
  TStringStream *data = NULL;
  __try {
    client = new TclTcpClientConnection();

    client->NetworkStream = new TclNetworkStream();
    client->TimeOut = 60000;
    client->Open("127.0.0.1", 2110);
    Memo1->Lines->Add("Client connected");

    data = new TStringStream(UnicodeString("Data from client"));
    client->WriteData(data);

    Memo1->Lines->Add("Sent: " + data->DataString);

    data->Size = 0;
    client->IsReadUntilClose = true;
    client->ReadData(data);

    Memo1->Lines->Add("Received: " + data->DataString);

    client->Close(true);
    Memo1->Lines->Add("Client disconnected");
  }
  __finally {
    delete data;
    delete client;
    WSACleanup();
  }
}
//---------------------------------------------------------------------------
 