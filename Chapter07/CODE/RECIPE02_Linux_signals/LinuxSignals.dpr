program LinuxSignals;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils,
  Posix.Unistd,
  Posix.Signal;

procedure SignalHandler(SignalNo: Integer); cdecl;
begin
  if SignalNo = SIGINT then
    WriteLn('Received SIGINT');
  if SignalNo = SIGUSR1 then
    WriteLn('Received SIGUSR1');
  if SignalNo = SIGKILL then
    WriteLn('Received SIGKILL');
  if SignalNo = SIGSTOP then
    WriteLn('Received SIGSTOP');
end;

var
  lAction: sigaction_t;

begin

  try

    lAction._u.sa_handler := SignalHandler;

    if sigaction(SIGINT, @lAction, nil) = SIG_ERR then
      WriteLn('Can''t catch SIGINT');
    if sigaction(SIGUSR1, @lAction, nil) = SIG_ERR then
      WriteLn('Can''t catch SIGUSR1');
    if sigaction(SIGKILL, @lAction, nil) = SIG_ERR then
      WriteLn('Can''t catch SIGKILL');
    if sigaction(SIGSTOP, @lAction, nil) = SIG_ERR then
      WriteLn('Can''t catch SIGSTOP');

    while True do
    begin
      WriteLn(TimeToStr(now) + ': Hey, I''m alive...');
      Sleep(2000);
    end;

  except
    on E: Exception do
      WriteLn(E.ClassName, ': ', E.Message);
  end;

end.
