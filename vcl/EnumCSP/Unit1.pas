unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, clCryptAPI, clSspi, clUtils;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    function GetDefaultProvider(AProvType: Integer; IsUser: Boolean): string;
    procedure GetProviderTypes(AList: TStrings);
    procedure GetProviders(AList: TStrings);
    procedure GetPackages(AList: TStrings);
    procedure GetCipherSuites(const APackageName: string; ASspi: TclSspi; AList: TStrings);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  Memo1.Lines.Clear();

  GetProviderTypes(Memo1.Lines);

  GetProviders(Memo1.Lines);

  GetPackages(Memo1.Lines);

  Memo1.SelStart := 0;
  Memo1.SelLength := 0;
end;

function TForm1.GetDefaultProvider(AProvType: Integer; IsUser: Boolean): string;
const
  flags: array[Boolean] of DWORD = (CRYPT_MACHINE_DEFAULT, CRYPT_USER_DEFAULT);
var
  len: DWORD;
  p: PChar;
begin
  Result := '';
  if CryptGetDefaultProvider(AProvType, 0, flags[IsUser], nil, @len) then
  begin
    GetMem(p, len);
    try
      if CryptGetDefaultProvider(AProvType, 0, flags[IsUser], p, @len) then
      begin
        Result := string(p);
      end;
    finally
      FreeMem(p);
    end;
  end;
end;

procedure TForm1.GetProviderTypes(AList: TStrings);
var
  i, provType, len: DWORD;
  p: PChar;
begin
  AList.Add('');
  AList.Add('=== Provider Types (name/type) ===');
  AList.Add('');

  i := 0;
  while CryptEnumProviderTypes(i, nil, 0, @provType, nil, @len) do
  begin
    GetMem(p, len);
    try
      if not CryptEnumProviderTypes(i, nil, 0, @provType, p, @len) then
      begin
        raise Exception.CreateFmt('CryptEnumProviderTypes error - %d', [GetLastError()]);
      end;
      AList.Add(string(p) + ' (' + IntToStr(provType) + ')');

      AList.Add('   = Default Providers =');
      AList.Add('   Machine: ' + GetDefaultProvider(provType, False));
      AList.Add('   User: ' + GetDefaultProvider(provType, True));
    finally
      FreeMem(p);
    end;
    Inc(i);
  end;

  AList.Add('');
end;

procedure TForm1.GetProviders(AList: TStrings);
var
  i, provType, len: DWORD;
  p: PChar;
begin
  AList.Add('');
  AList.Add('=== Providers (name/type) ===');
  AList.Add('');

  i := 0;
  while CryptEnumProviders(i, nil, 0, @provType, nil, @len) do
  begin
    GetMem(p, len);
    try
      if not CryptEnumProviders(i, nil, 0, @provType, p, @len) then
      begin
        raise Exception.CreateFmt('CryptEnumProviderTypes error - %d', [GetLastError()]);
      end;
      AList.Add(string(p) + ' (' + IntToStr(provType) + ')');
    finally
      FreeMem(p);
    end;
    Inc(i);
  end;
  
  AList.Add('');
end;

procedure TForm1.GetPackages(AList: TStrings);
var
  sspi: TclSspi;
  PackagesCount: Cardinal;
  PackageInfoArray, pkg: PSecPkgInfo;
  i: Integer;
begin
  AList.Add('');
  AList.Add('=== Security Packages (name/full name) ===');
  AList.Add('');

  sspi := TclSspi.Create();
  try
    sspi.FunctionTable.EnumerateSecurityPackages(PackagesCount, PackageInfoArray);

    for i := 0 to PackagesCount - 1 do
    begin
      pkg := PSecPkgInfo(Integer(PackageInfoArray) + SizeOf(TSecPkgInfo) * i);
      AList.Add(string(pkg.Name) + '  (' + string(pkg.Comment) + ')');

      GetCipherSuites(string(pkg.Name), sspi, AList);
    end;
  finally
    sspi.FunctionTable.FreeContextBuffer(PackageInfoArray);
    sspi.Free();
  end;

  AList.Add('');
end;

procedure TForm1.GetCipherSuites(const APackageName: string; ASspi: TclSspi; AList: TStrings);
var
  secData: TSChannel_Cred;
  hCred: TCredHandle;
  tsExpiry: TTimeStamp;
  status: SECURITY_STATUS;
  algs: TSecPkgCred_SupportedAlgs;
  i: Integer;
  pOidInfo: PCCRYPT_OID_INFO;
  algid: ALG_ID;
  s: string;
begin
  ZeroMemory(@secData, Sizeof(secData));
  secData.dwVersion := SCHANNEL_CRED_VERSION;
  secData.dwFlags :=  SCH_CRED_AUTO_CRED_VALIDATION+ SCH_CRED_NO_DEFAULT_CREDS;

  status := ASspi.FunctionTable.AcquireCredentialsHandle(nil, PChar(APackageName), SECPKG_CRED_OUTBOUND,
    nil, @secData, nil, nil, @hCred, @tsExpiry);
  if (status = SEC_E_OK) then
  begin
    status := ASspi.FunctionTable.QueryCredentialsAttributes(@hCred, SECPKG_ATTR_SUPPORTED_ALGS, @algs);
    if (status = SEC_E_OK) then
    begin
      AList.Add('   = Algorithms =');
      for i := 0 to algs.cSupportedAlgs - 1 do
      begin
        algid := ALG_ID(TclIntPtr(algs.palgSupportedAlgs) + i * SizeOf(ALG_ID));

        pOidInfo := CryptFindOIDInfo(CRYPT_OID_INFO_ALGID_KEY, Pointer(algid), 0);
        if (pOidInfo <> nil) then
        begin
          s := string(WideString(pOidInfo.pwszName));
          AList.Add('   ' + system.Copy(s, 1, system.Length(s)));
        end else
        begin
          AList.Add('   Unknown (' + IntToStr(algid) + ')');
        end;
      end;
      ASspi.FunctionTable.FreeContextBuffer(algs.palgSupportedAlgs);
    end;

    ASspi.FunctionTable.FreeCredentialHandle(@hCred);
  end;
end;

end.
