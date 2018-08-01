program LinuxSignalsSafe;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils,
  System.SyncObjs,
  System.DateUtils,
  Posix.Signal;

var
  GSignal: Int64 = 0;

procedure SignalHandler(SignalNo: Integer); cdecl;
begin
  if SignalNo = SIGINT then
    TInterlocked.Exchange(GSignal, 1);
end;

var
  lAction: sigaction_t;
  lStart: TDateTime;

begin
  lAction._u.sa_handler := SignalHandler;
  if (sigaction(SIGINT, @lAction, nil) = -1) then
  begin
    WriteLn('Cannot catch SIGINT');
    Halt(1);
  end;

  while True do
  begin
    WriteLn(TimeToStr(now) + ': Hey, I''m alive...');
    Sleep(2000);
    if GSignal = 1 then
    begin
      TInterlocked.Exchange(GSignal, 0);
      Write('Handling signal...');
      lStart := now;
      while SecondsBetween(lStart, now) < 4 do
        Sleep(1);
      WriteLn('DONE');
    end;
  end;

end.
