unit StreamJSONInterceptors;

{$WARN COMPARING_SIGNED_UNSIGNED OFF}

interface

uses
  SysUtils,
  classes,
  rtti,
  REST.JSONReflect;

type
  TStreamInterceptor = class(TJSONInterceptor)
  private
    RTTICTX: TRttiContext;
  public
    function StringConverter(Data: TObject; Field: string): string; override;
    procedure StringReverter(Data: TObject; Field: string;
      Arg: string); override;
  end;

implementation

function TStreamInterceptor.StringConverter(Data: TObject;
  Field: string): string;
var
  ms: TStream;
  RTTIType: TRttiType;
  b: byte;
  Readed: Integer;
  sb: TStringBuilder;
begin
  RTTIType := RTTICTX.GetType(Data.ClassType);
  ms := RTTIType.GetField(Field).GetValue(Data).AsObject as TStream;
  if not Assigned(ms) then
    Exit(EmptyStr);

  ms.Position := 0;
  Result := '';

  sb := TStringBuilder.Create;
  try
    Readed := ms.Read(b, 1);
    while Readed = 1 do
    begin
      sb.Append(IntToHex(b, 2));
      Readed := ms.Read(b, 1);
    end;
    Result := sb.ToString;
  finally
    sb.Free;
  end;
  ms.Position := 0;
end;

procedure TStreamInterceptor.StringReverter(Data: TObject; Field, Arg: string);
var
  ms: TMemoryStream;
  b: byte;
  i: Integer;
  l: UInt32;
  v: string;
begin
  Arg := trim(Arg);
  l := Length(Arg);
  if l = 0 then
    Exit;
  if l mod 2 <> 0 then
    raise Exception.Create('Corrupted data');
  ms := TMemoryStream.Create;
  i := 1;
  while i < l do
  begin
    v := Copy(Arg, i, 2);
    b := StrToInt('$' + v);
    ms.Write(b, 1);
    i := i + 2;
  end;
  ms.Position := 0;
  RTTICTX.GetType(Data.ClassType).GetField(Field).SetValue(Data, ms);
end;

initialization

TStreamInterceptor.ClassName;

end.
