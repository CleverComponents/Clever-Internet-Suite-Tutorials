unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, clMultiDC,
  clMultiDownLoader, clResourceState, clUtils, clSingleDC, clDownLoader, clUriUtils;

type
  TForm1 = class(TForm)
    clMultiDownLoader1: TclMultiDownLoader;
    btnStart: TButton;
    btnStop: TButton;
    Label5: TLabel;
    edtSaveToFolder: TEdit;
    memLog: TMemo;
    Label6: TLabel;
    Label7: TLabel;
    edtDownloadBy: TEdit;
    btnPrepareList: TButton;
    Label9: TLabel;
    edtSplitOn: TEdit;
    edtM3U8Url: TEdit;
    Label4: TLabel;
    edtProgress: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    edtUserAgent: TEdit;
    edtTryCount: TEdit;
    edtTimeout: TEdit;
    clDownLoader1: TclDownLoader;
    btnGetList: TButton;
    procedure btnStartClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure clMultiDownLoader1IsBusyChanged(Sender: TObject);
    procedure clMultiDownLoader1StatusChanged(Sender: TObject;
      Item: TclInternetItem; Status: TclProcessStatus);
    procedure btnPrepareListClick(Sender: TObject);
    procedure btnGetListClick(Sender: TObject);
  private
    FSuccessful: Integer;
    FFailed: Integer;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnGetListClick(Sender: TObject);
var
  i, counter: Integer;
  item: TclDownLoadItem;
  list: TStrings;
  urlParser: TclUrlParser;
  s: String;
begin
  if (clMultiDownLoader1.IsBusy) then
  begin
    ShowMessage('The downloading is in progress');
    Exit;
  end;

  clDownLoader1.URL := edtM3U8Url.Text;
  clDownLoader1.LocalFile := 'downloadlist.m3u8';
  clDownLoader1.LocalFolder :=  edtSaveToFolder.Text;
  clDownLoader1.ThreadCount := 1;
  clDownLoader1.Start(False);

  clMultiDownLoader1.DownLoadList.Clear();

  list :=  TStringList.Create();
  urlParser := TclUrlParser.Create();
  try
    list.LineBreak := #10;
    list.LoadFromFile(clDownLoader1.LocalFile);

    counter := 1;
    for i := 0 to list.Count - 1 do
    begin
      s := list[i];
      if (s <> '') and (s[1] <> '#') and (Pos('.ts', s) > 0) then
      begin
        item := clMultiDownLoader1.DownLoadList.Add();

        urlParser.Parse(edtM3U8Url.Text, s);
        item.URL := urlParser.AbsoluteUri;
        item.LocalFile := Format('%d.ts', [counter]);
        Inc(counter);
      end;
    end;
  finally
    urlParser.Free();
    list.Free();
  end;

  if (clMultiDownLoader1.DownLoadList.Count > 0) then
  begin
    edtProgress.Text := Format('%d video files found', [clMultiDownLoader1.DownLoadList.Count]);
  end else
  begin
    ShowMessage('The provided m3u8 file doesn''t contain video files, please choose another URL.');
  end;
end;

procedure TForm1.btnPrepareListClick(Sender: TObject);
var
  list: TStrings;
  batch: Integer;
  item: TclDownLoadItem;
  i, counter: Integer;
begin
  list := TStringList.Create();
  try
    batch := clMultiDownLoader1.DownLoadList.Count div StrToInt(edtSplitOn.Text);
    counter := 1;
     for i := 0 to clMultiDownLoader1.DownLoadList.Count - 1 do
     begin
        item := clMultiDownLoader1.DownLoadList[i];
        list.Add('file ''' + ExtractFileName(item.LocalFile) + '''');
        if(list.Count = batch) then
        begin
          list.SaveToFile(AddTrailingBackSlash(edtSaveToFolder.Text) + Format('list%d.txt', [counter]));
          list.Clear();
          Inc(counter);
        end;
     end;
     if(list.Count > 0) then
     begin
        list.SaveToFile(AddTrailingBackSlash(edtSaveToFolder.Text) + Format('list%d.txt', [counter]));
     end;
  finally
    list.Free();
  end;
  ShowMessage('Done');
end;

procedure TForm1.btnStartClick(Sender: TObject);
begin
  if (clMultiDownLoader1.IsBusy) then
  begin
    ShowMessage('The downloading is in progress');
    Exit;
  end;

  memLog.Lines.Clear();

  FSuccessful := 0;
  FFailed := 0;

  clMultiDownLoader1.MaxStartedItems := StrToInt(edtDownloadBy.Text);
  clMultiDownLoader1.InternetAgent := edtUserAgent.Text;
  clMultiDownLoader1.TryCount := StrToInt(edtTryCount.Text);
  clMultiDownLoader1.TimeOut := StrToInt(edtTimeout.Text);

  clMultiDownLoader1.LocalFolder := edtSaveToFolder.Text;

  clMultiDownLoader1.Start();
end;

procedure TForm1.btnStopClick(Sender: TObject);
begin
  clMultiDownLoader1.Stop();
end;

procedure TForm1.clMultiDownLoader1IsBusyChanged(Sender: TObject);
begin
  if (clMultiDownLoader1.IsBusy) then
  begin
    Caption := 'Video TS Downloader - Downloading...';
  end else
  begin
    Caption := 'Video TS Downloader';
  end;
end;

procedure TForm1.clMultiDownLoader1StatusChanged(Sender: TObject;
  Item: TclInternetItem; Status: TclProcessStatus);
begin
  case Status of
    psSuccess: Inc(FSuccessful);
    psFailed, psErrors, psTerminated:
    begin
      Inc(FFailed);
      memLog.Lines.Add(Item.URL);
    end;
  end;
  edtProgress.Text := Format('Downloading successful: %d, failed: %d', [FSuccessful, FFailed]);
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := not clMultiDownLoader1.IsBusy;
  if (not CanClose) then
  begin
    ShowMessage('The downloading is in progress');
  end;
end;

end.
