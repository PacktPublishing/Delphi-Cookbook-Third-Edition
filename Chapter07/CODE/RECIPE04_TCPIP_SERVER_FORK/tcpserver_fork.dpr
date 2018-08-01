program tcpserver_fork;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  Posix.Signal,
  Posix.Stdlib,
  Posix.SysStat,
  Posix.SysTypes,
  Posix.Unistd,
  Posix.Fcntl,
  System.SysUtils,
  System.SyncObjs,
  ServerModuleU in 'ServerModuleU.pas' {ServerModule: TDataModule} ,
  LogU in '..\Commons\LogU.pas';

const
  EXIT_FAILURE = 1;
  EXIT_SUCCESS = 0;

var
  pid: Integer;
  SID: Integer;
  lServerModule: TServerModule;
  lAction: sigaction_t;
  lTerminated: Int64;

procedure SigHandler(SignalNo: Integer); cdecl;
begin
  Log('SIGNAL : ' + SignalNo.ToString);
  TInterlocked.Exchange(lTerminated, 1);
end;

procedure Main;
begin
  lTerminated := 0;
  lServerModule := TServerModule.Create(nil);
  lServerModule.Start;
  lAction._u.sa_handler := SigHandler;
  sigaction(SIGINT, @lAction, nil); // sent by the console hitting ctrl+c
  sigaction(SIGTERM, @lAction, nil); // sent by "systemctl stop dtservice"
  while lTerminated = 0 do
  begin
    Sleep(1000);
    Log('Loop');
  end;
  Log('Stopping');
  lServerModule.Stop;
  Log('Stopped');
  lServerModule := nil;
end;

procedure MainFork;
var
  idx: Integer;
begin
  Log('1. START');
  try
    // Fork off the parent process
    Log('2. BEFORE FORK ');
    pid := fork();
    if (pid < 0) then
      raise Exception.Create('Error in forking the process');
    // If we got a good PID, then we can KILL the parent process.
    if (pid > 0) then
    begin
      Log('3. INTO FORK - PARENT PROCESS - EXIT SUCCESS');
      Halt(EXIT_SUCCESS);
    end;

    Log('4. AFTER FORK');

    // Change the file mode mask
    umask(0);

    // Open any logs here

    // Create a new SID for the child process
    SID := setsid();
    if (SID < 0) then
      raise Exception.Create('Error in creating an independent session');

    // Change the current working directory
    // ATTENTION -- for demo purpose comment the line below to
    // make sure that the log files are written to the same level of application file
    chdir('/');

    // Close out the standard file descriptors
    for idx := sysconf(_SC_OPEN_MAX) downto 0 do
      __close(idx);

    // Daemon - specific initialization goes here

    // the Daemon Loop
    Main;
    Log('6. END WHILE');
    ExitCode := EXIT_SUCCESS;
    Log('7. END - EXIT SUCCESS');
  except
    on E: Exception do
    begin
      Log(E.Message);
      Writeln(E.ClassName, ': ', E.Message);
      ExitCode := EXIT_SUCCESS;
    end;
  end;
end;

begin
  try
    Log('Started');
    MainFork;
    Log('Finished');
  except
    on E: Exception do
      Log('ERROR> ' + E.ClassName + ': ' + E.Message);
  end;

end.
