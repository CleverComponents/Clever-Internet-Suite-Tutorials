unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, clTcpClient, clFtp, Vcl.StdCtrls, clFtpUtils;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    clFtp1: TclFtp;
    Label1: TLabel;
    edtHost: TEdit;
    Label2: TLabel;
    edtPort: TEdit;
    Label3: TLabel;
    edtUser: TEdit;
    Label4: TLabel;
    edtPassword: TEdit;
    Label5: TLabel;
    edtRoot: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure clFtp1DirectoryListing(Sender: TObject; AFileInfo: TclFtpFileInfo;
      const Source: string);
  private
    FLevel: string;
    procedure GetRecursiveList(const ADirName, ALevel: string);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.clFtp1DirectoryListing(Sender: TObject; AFileInfo: TclFtpFileInfo; const Source: string);
begin
  Memo1.Lines.Add(FLevel + AFileInfo.FileName);
  if (AFileInfo.IsDirectory) then
  begin
    GetRecursiveList(AFileInfo.FileName, #9);
  end;
end;

procedure TForm1.GetRecursiveList(const ADirName, ALevel: string);
var
  old: string;
begin
  old := FLevel;
  try
    FLevel := FLevel + ALevel;
    clFtp1.ChangeCurrentDir(ADirName);
    clFtp1.DirectoryListing();
    clFtp1.ChangeToParentDir();
  finally
    FLevel := old;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Memo1.Lines.Clear();

  clFtp1.Server := edtHost.Text;
  clFtp1.Port := StrToInt(edtPort.Text);
  clFtp1.UserName := edtUser.Text;
  clFtp1.Password := edtPassword.Text;
  clFtp1.Open();
  try
    FLevel := '';
    GetRecursiveList(edtRoot.Text, '');
  finally
    clFtp1.Close();
  end;
  ShowMessage('Done');
end;

end.
