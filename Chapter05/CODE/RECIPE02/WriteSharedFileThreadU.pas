unit WriteSharedFileThreadU;

interface

procedure WriteSharedFileThread;

implementation

uses
  System.Classes, System.SyncObjs, System.SysUtils, System.IOUtils;

type
  TFileWriterThread = class(TThread)
  protected
    procedure Execute; override;
  end;

var
  CriticalSection: TCriticalSection;

procedure WriteSharedFileThread;
var
  I: Integer;
  Th: TFileWriterThread;
begin
  for I := 1 to 10 do
  begin
    Th := TFileWriterThread.Create(true);
    Th.FreeOnTerminate := true;
    Th.Start;
  end;
end;

{ TFileWriterThread }

procedure TFileWriterThread.Execute;
var
  I: Integer;
  SW: TStreamWriter;
begin
  inherited;
  for I := 1 to 50 do
  begin
    TThread.Sleep(200);
    CriticalSection.Enter;
    try
      SW := TStreamWriter.Create('FileWriterThread.txt', true);
      try
        SW.WriteLine(Format('THREAD %5d - ROW %2d', [TThread.CurrentThread.ThreadID, I]));
      finally
        SW.Free;
      end;
    finally
      CriticalSection.Leave;
    end;
  end;
end;

initialization

CriticalSection := TCriticalSection.Create;

finalization

CriticalSection.Free;

end.
