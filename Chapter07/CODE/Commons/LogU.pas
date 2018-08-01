unit LogU;

interface

procedure Log(const Value: String);

implementation

uses
  System.SysUtils,
  System.Classes,
  System.IOUtils

  {$IFDEF MSWINDOWS}

    , Winapi.Windows

  {$ENDIF}

    ;

function AppFullPath: String;
var
  lPath: array [0 .. 4095] of Char;
begin
  GetModuleFileName(HInstance, lPath, Length(lPath));
  Result := lPath;
end;

function GetLogFileName: String;
begin
  Result := TPath.ChangeExtension(TPath.GetFileName(AppFullPath), '.log');
  Result := '/var/log/' + Result.ToLower;
end;

procedure Log(const Value: String);
var
  lWriter: TStreamWriter;
begin
  lWriter := TStreamWriter.Create(TFile.Open(GetLogFileName, TFileMode.fmAppend, TFileAccess.faWrite));
  lWriter.OwnStream;
  lWriter.WriteLine(datetimetostr(now) + ': ' + Value);
  lWriter.Flush;
  lWriter.Close;
end;

end.
