unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, clUploader, clSingleDC,
  clDownLoader, clMultiUploader, clMultiDC, clMultiDownLoader, clTcpClient,
  clTcpClientTls, clHttp, clHttpProxy, clTcpCommandClient, clFtp, clFtpUtils,
  clMC, clSmtp;

type
  TForm1 = class(TForm)
    clMultiDownLoader1: TclMultiDownLoader;
    clMultiUploader1: TclMultiUploader;
    clDownLoader1: TclDownLoader;
    clUploader1: TclUploader;
    btnDownloader: TButton;
    btnHttp: TButton;
    clHttp1: TclHttp;
    clFtp1: TclFtp;
    clHttpProxy1: TclHttpProxy;
    btnFtpProxy: TButton;
    clSmtp1: TclSmtp;
    btnSmtp: TButton;
    procedure btnDownloaderClick(Sender: TObject);
    procedure btnHttpClick(Sender: TObject);
    procedure btnFtpProxyClick(Sender: TObject);
    procedure btnSmtpClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnDownloaderClick(Sender: TObject);
begin
  //TclDownloader
  clDownloader1.HttpProxySettings.UserName := 'user';
  clDownloader1.HttpProxySettings.Password := 'psw';
  clDownloader1.HttpProxySettings.Server := 'proxy-domain.com';
  clDownloader1.HttpProxySettings.Port := 8080;

  clDownloader1.URL := 'https://www.clevercomponents.com/checknews/clnews.html';
  clDownloader1.LocalFile := 'clnews.html';

  clDownLoader1.Start();

  //TclUploader
  clUploader1.HttpProxySettings.UserName := 'user';
  clUploader1.HttpProxySettings.Password := 'psw';
  clUploader1.HttpProxySettings.Server := 'proxy-domain.com';
  clUploader1.HttpProxySettings.Port := 8080;

  clUploader1.LocalFile := 'c:\uploads\file.ext';
  clUploader1.URL := 'https://example.com/uploads/file.ext';

  clUploader1.Start();

  //TclMultiDownloader
  clMultiDownloader1.HttpProxySettings.UserName := 'user';
  clMultiDownloader1.HttpProxySettings.Password := 'psw';
  clMultiDownloader1.HttpProxySettings.Server := 'proxy-domain.com';
  clMultiDownloader1.HttpProxySettings.Port := 8080;

  //TclMultiUploader
  clMultiUploader1.HttpProxySettings.UserName := 'user';
  clMultiUploader1.HttpProxySettings.Password := 'psw';
  clMultiUploader1.HttpProxySettings.Server := 'proxy-domain.com';
  clMultiUploader1.HttpProxySettings.Port := 8080;
end;

procedure TForm1.btnHttpClick(Sender: TObject);
var
  response: string;
begin
  clHttp1.ProxySettings.UserName := 'user';
  clHttp1.ProxySettings.Password := 'psw';
  clHttp1.ProxySettings.Server := 'proxy-domain.com';
  clHttp1.ProxySettings.Port := 8080;

  response := clHttp1.Get('https://www.clevercomponents.com/checknews/clnews.html');
end;

procedure TForm1.btnFtpProxyClick(Sender: TObject);
begin
  clFtp1.ProxySettings.UserName := 'user';
  clFtp1.ProxySettings.Password := 'psw';
  clFtp1.ProxySettings.Server := 'proxy-domain.com';
  clFtp1.ProxySettings.Port := 8080;
  clFtp1.ProxySettings.ProxyType := ptHttpConnect;

  clFtp1.UserName := 'ftp-user';
  clFtp1.Password := 'secret';
  clFtp1.Server := 'ftp-host';
  clFtp1.Port := 21;
  clFtp1.Open();
end;

procedure TForm1.btnSmtpClick(Sender: TObject);
begin
  clHttpProxy1.UserName := 'user';
  clHttpProxy1.Password := 'psw';
  clHttpProxy1.Server := 'proxy-domain.com';
  clHttpProxy1.Port := 8080;

  clSmtp1.Proxy := clHttpProxy1;

  clSmtp1.UserName := 'mail-user';
  clSmtp1.Password := 'secret';
  clSmtp1.Server := 'mail-host';
  clSmtp1.Port := 25;
  clSmtp1.Open();
end;

end.
