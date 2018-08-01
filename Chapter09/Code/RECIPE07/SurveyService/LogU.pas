// ***********************************************************
// This unit is a workaround for using SysLog in Android
// because FMX.Types (where the Log class is) doesn't work
// in services at the time of writing
// ***********************************************************
unit LogU;

interface

uses
  AndroidApi.Log, System.SysUtils;

function LogInfo(Text: String; const Params: array of const;
  const Tag: String): Integer;
function LogWarning(Text: String; const Params: array of const;
  const Tag: String): Integer;
function LogError(Text: String; const Params: array of const;
  const Tag: String): Integer;
function LogFatal(Text: String; const Params: array of const;
  const Tag: String): Integer;

implementation

function InternalLog(const Priority: android_LogPriority; Text: String;
  const Params: array of const; const Tag: String): Integer;
var
  Msg: string;
  M: TMarshaller;
begin
  Msg := Format(Text, Params);
  Result := __android_log_write(android_LogPriority.ANDROID_LOG_INFO,
    M.AsUtf8(Tag).ToPointer, M.AsUtf8(Msg).ToPointer);
end;

function LogInfo(Text: String; const Params: array of const;
  const Tag: String): Integer;
var
  Msg: string;
  M: TMarshaller;
begin
  Msg := Format(Text, Params);
  Result := __android_log_write(android_LogPriority.ANDROID_LOG_INFO,
    M.AsUtf8(Tag).ToPointer, M.AsUtf8(Msg).ToPointer);
end;

function LogWarning(Text: String; const Params: array of const;
  const Tag: String): Integer;
begin
  Result := InternalLog(android_LogPriority.ANDROID_LOG_WARN, Text, Params, Tag)
end;

function LogError(Text: String; const Params: array of const;
  const Tag: String): Integer;
begin
  Result := InternalLog(android_LogPriority.ANDROID_LOG_ERROR, Text,
    Params, Tag)
end;

function LogFatal(Text: String; const Params: array of const;
  const Tag: String): Integer;
begin
  Result := InternalLog(android_LogPriority.ANDROID_LOG_FATAL, Text,
    Params, Tag);
end;

end.
