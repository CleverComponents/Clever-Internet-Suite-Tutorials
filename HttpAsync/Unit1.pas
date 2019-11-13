unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, clCookieManager, clThreadPool, clHttp, clSyncUtils;

type
  TclDownloadStatus = (dsReady, dsProcess, dsSuccess, dsError, dsStop);
  
  TclDownloadInfo = class
  private
    FURL: string;
    FFileName: string;
    FStatus: TclDownloadStatus;
    FOnChanged: TNotifyEvent;
    FIsStop: Boolean;

    function GetDisplay: string;
    procedure SetStatus(const Value: TclDownloadStatus);
    procedure Changed;
  public
    constructor Create(const AURL, AFileName: string);

    procedure Stop;

    property URL: string read FURL;
    property FileName: string read FFileName;
    property Status: TclDownloadStatus read FStatus write SetStatus;
    property Display: string read GetDisplay;
    property IsStop: Boolean read FIsStop;

    property OnChanged: TNotifyEvent read FOnChanged write FOnChanged;
  end;

  TclDownloadWorkItem = class(TclWorkItem)
  private
    FSynchronizer: TclThreadSynchronizer;
    FInfo: TclDownloadInfo;
    FCookies: TclCookieManager;
    FStatus: TclDownloadStatus;

    procedure StatusChanged;
    procedure ChangeStatus(ANewStatus: TclDownloadStatus);
    procedure DoProgress(Sender: TObject; ABytesProceed, ATotalBytes: Int64);
  protected
    procedure Execute(AThread: TThread); override;
  public
    constructor Create(AInfo: TclDownloadInfo; ACookies: TclCookieManager);
    destructor Destroy; override;
  end;

  TForm1 = class(TForm)
    clCookieManager1: TclCookieManager;
    Label1: TLabel;
    edtURL: TEdit;
    Label2: TLabel;
    edtFile: TEdit;
    btnStart: TButton;
    lbDownloads: TListBox;
    btnStop: TButton;
    btnAdd: TButton;
    memCookies: TMemo;
    Label3: TLabel;
    procedure btnAddClick(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure clCookieManager1AddCookie(Sender: TObject; ACookie: TclCookieItem;
      var Allow: Boolean);
    procedure clCookieManager1DeleteCookie(Sender: TObject;
      ACookie: TclCookieItem; var Allow: Boolean);
    procedure clCookieManager1UpdateCookie(Sender: TObject; AOldCookie,
      ANewCookie: TclCookieItem; var Allow: Boolean);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    FThreadPool: TclThreadPool;
    FCookieSynchronizer: TclThreadSynchronizer;

    procedure DoStatusChanged(Sender: TObject);
    procedure DoCookieChanged;
    procedure AddDownload(const AURL, AFileName: string);
    function GetDownloadInfo(Index: Integer): TclDownloadInfo;
    procedure ClearDownloadInfo;
    procedure StartDownloads;
    procedure StopDownloads;
    procedure InvalidateList;
    procedure InvalidateCookieList;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

const
  StatusArray: array[TclDownloadStatus] of string = ('', 'Process', 'Success', 'Error', 'Stop');

procedure TForm1.AddDownload(const AURL, AFileName: string);
var
  info: TclDownloadInfo;
begin
  info := TclDownloadInfo.Create(AURL, AFileName);
  lbDownloads.Items.AddObject(info.Display, info);
  info.OnChanged := DoStatusChanged;
end;

procedure TForm1.btnAddClick(Sender: TObject);
begin
  AddDownload(edtURL.Text, edtFile.Text);
end;

procedure TForm1.btnStartClick(Sender: TObject);
begin
  StartDownloads();
end;

procedure TForm1.btnStopClick(Sender: TObject);
begin
  StopDownloads();
end;

procedure TForm1.clCookieManager1AddCookie(Sender: TObject;
  ACookie: TclCookieItem; var Allow: Boolean);
begin
  InvalidateCookieList();
end;

procedure TForm1.clCookieManager1DeleteCookie(Sender: TObject;
  ACookie: TclCookieItem; var Allow: Boolean);
begin
  InvalidateCookieList();
end;

procedure TForm1.clCookieManager1UpdateCookie(Sender: TObject; AOldCookie,
  ANewCookie: TclCookieItem; var Allow: Boolean);
begin
  InvalidateCookieList();
end;

procedure TForm1.ClearDownloadInfo;
var
  i: Integer;
begin
  for i := 0 to lbDownloads.Items.Count  - 1 do
  begin
    lbDownloads.Items.Objects[i].Free();
  end;
  lbDownloads.Items.Clear();
end;

procedure TForm1.DoCookieChanged;
var
  i: Integer;
  cookie: TclCookieItem;
begin
  memCookies.Lines.BeginUpdate();
  try
    memCookies.Lines.Clear();
    for i := 0 to clCookieManager1.Cookies.Count - 1 do
    begin
      cookie := clCookieManager1.Cookies[i];
      memCookies.Lines.Add(cookie.Name + '=' + cookie.Value);
    end;
  finally
    memCookies.Lines.EndUpdate();
  end;
end;

procedure TForm1.DoStatusChanged(Sender: TObject);
begin
  InvalidateList();
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  i: Integer;
begin
  for i := 0 to lbDownloads.Items.Count  - 1 do
  begin
    if GetDownloadInfo(i).Status = dsProcess then
    begin
      CanClose := False;
      Exit;
    end;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FCookieSynchronizer := TclThreadSynchronizer.Create();
  FThreadPool := TclThreadPool.Create(nil);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FThreadPool.Free();

  ClearDownloadInfo();
  FCookieSynchronizer.Free();
end;

function TForm1.GetDownloadInfo(Index: Integer): TclDownloadInfo;
begin
  Result := TclDownloadInfo(lbDownloads.Items.Objects[Index]);
end;

procedure TForm1.InvalidateCookieList;
begin
  FCookieSynchronizer.Synchronize(DoCookieChanged);
end;

procedure TForm1.InvalidateList;
var
  i: Integer;
begin
  lbDownloads.Items.BeginUpdate();
  try
    for i := 0 to lbDownloads.Items.Count - 1 do
    begin
      lbDownloads.Items[i] := GetDownloadInfo(i).Display;
    end;
  finally
    lbDownloads.Items.EndUpdate();
  end;
end;

procedure TForm1.StartDownloads;
var
  i: Integer;
begin
  for i := 0 to lbDownloads.Items.Count  - 1 do
  begin
    if GetDownloadInfo(i).Status = dsReady then
    begin
      FThreadPool.QueueWorkItem(TclDownloadWorkItem.Create(GetDownloadInfo(i), clCookieManager1));
    end;
  end;
end;

procedure TForm1.StopDownloads;
var
  i: Integer;
begin
  for i := 0 to lbDownloads.Items.Count  - 1 do
  begin
    GetDownloadInfo(i).Stop();
  end;
end;

{ TclDownloadInfo }

procedure TclDownloadInfo.Changed;
begin
  if Assigned(OnChanged) then
  begin
    OnChanged(Self);
  end;
end;

constructor TclDownloadInfo.Create(const AURL, AFileName: string);
begin
 inherited Create();

 FURL := AURL;
 FFileName := AFileName;
 FStatus := dsReady;
 FIsStop := False;
end;

function TclDownloadInfo.GetDisplay: string;
begin
  Result := StatusArray[Status];
  if (Result <> '') then
  begin
    Result := ' - ' + Result;
  end;
  Result := URL + Result;
end;

procedure TclDownloadInfo.SetStatus(const Value: TclDownloadStatus);
begin
  if (FStatus <> Value) then
  begin
    FStatus := Value;
    Changed();
  end;
end;

procedure TclDownloadInfo.Stop;
begin
  FIsStop := True;
end;

{ TclDownloadWorkItem }

procedure TclDownloadWorkItem.ChangeStatus(ANewStatus: TclDownloadStatus);
begin
  FStatus := ANewStatus;
  FSynchronizer.Synchronize(StatusChanged);
end;

constructor TclDownloadWorkItem.Create(AInfo: TclDownloadInfo; ACookies: TclCookieManager);
begin
  inherited Create();
  FSynchronizer := TclThreadSynchronizer.Create();
  FInfo := AInfo;
  FCookies := ACookies;
end;

destructor TclDownloadWorkItem.Destroy;
begin
  FSynchronizer.Free();
  inherited Destroy();
end;

procedure TclDownloadWorkItem.DoProgress(Sender: TObject; ABytesProceed, ATotalBytes: Int64);
begin
  if FInfo.IsStop then
  begin
    TclHttp(Sender).Close();
  end;
end;

procedure TclDownloadWorkItem.StatusChanged;
begin
  FInfo.Status := FStatus;
end;

procedure TclDownloadWorkItem.Execute(AThread: TThread);
var
  http: TclHttp;
  stream: TStream;
begin
  try
    ChangeStatus(dsProcess);

    http := nil;
    stream := nil;
    try
      http := TclHttp.Create(nil);
      http.CookieManager := FCookies;
      http.OnReceiveProgress := DoProgress;

      stream := TFileStream.Create(FInfo.FileName, fmCreate);
      http.Get(FInfo.URL, stream);

      ChangeStatus(dsSuccess);
    finally
      stream.Free();
      http.Free();
    end;

  except
    if (FInfo.IsStop) then
    begin
      ChangeStatus(dsStop);
    end else
    begin
      ChangeStatus(dsError);
    end;
  end;
end;

end.
