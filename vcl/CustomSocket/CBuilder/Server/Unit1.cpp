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
  TclTcpServerConnection *server = NULL;
  TStringStream *data = NULL;
  __try {
    server = new TclTcpServerConnection();

    server->NetworkStream = new TclNetworkStream();
    server->TimeOut = 60000;
    server->BatchSize = 8192;
    server->Listen(2110);

    Memo1->Lines->Add("Listening...");

    server->Accept();
    Memo1->Lines->Add("Connected");

    data = new TStringStream();
    server->ReadData(data);

    Memo1->Lines->Add("Received: " + data->DataString);

    data->Position = 0;
    server->WriteData(data);

    Memo1->Lines->Add("Echoed back to client");

    server->Close(false);
    Memo1->Lines->Add("Closed");
  }
  __finally {
    delete data;
    delete server;
    WSACleanup();
  }
}
//---------------------------------------------------------------------------
 