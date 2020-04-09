unit ImapUtf7Encoder;

interface

//http://www.faqs.org/rfcs/rfc2060.html
//https://www.embarcadero.com/images/dm/technical-papers/delphi-and-unicode-marco-cantu.pdf

type
  TImapUtf7Encoder = class
  private
    class function DecodeBase64Imap(const AValue: string): string;
  public
    class function Decode(const AValue: string): string;
  end;

implementation

uses
  SysUtils, clEncoder, clTranslator;

{ TImapUtf7Encoder }

class function TImapUtf7Encoder.DecodeBase64Imap(const AValue: string): string;
var
  enc: TclEncoder;
  b: TBytes;
begin
  enc := TclEncoder.Create(nil);
  try
    enc.EncodeMethod := cmBase64;
    enc.CharSet := 'UTF-7';
    b := enc.DecodeToBytes(StringReplace(AValue, ',', '/', [rfReplaceAll]));
    Result := TclTranslator.GetString(b, 'UTF-16BE');
  finally
    enc.Free();
  end;
end;

class function TImapUtf7Encoder.Decode(const AValue: string): string;
var
  n, h, t, k: Integer;
begin
  Result := '';
  n := Length(AValue);
  h := 1;

  while (h <= n) do
  begin
    t := System.Pos('&', AValue, h);

    if (t <= 0) then
    begin
      t := n + 1;
    end;

    Result := Result + System.Copy(AValue, h, t - h);
    h := t + 1;
    if (h > n) then Break;

    t := System.Pos('-', AValue, h);
    if (t <= 0) then
    begin
      t := n + 1;
    end;

    k := t - h;
    if (k = 0) then
    begin
      Result := Result + '&';
    end else
    begin
      Result := Result + DecodeBase64Imap(System.Copy(AValue, h, k));
    end;
    h := t + 1;
  end;
end;

end.
