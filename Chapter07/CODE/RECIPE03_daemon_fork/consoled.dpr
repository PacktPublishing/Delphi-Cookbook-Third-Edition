program consoled;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.IOUtils,
  System.Classes,
  System.SysUtils,
  Posix.Stdlib,
  Posix.SysStat,
  Posix.SysTypes,
  Posix.Unistd,
  Posix.Fcntl;

const
  EXIT_FAILURE = 1;
  EXIT_SUCCESS = 0;

var
  pid: Integer;
  SID: Integer;
  I: Integer;
  idx: Integer;

procedure Log(const Value: String);
var
  SW: TStreamWriter;
begin
  SW := TStreamWriter.Create(
    TFile.Open('consoled_' + getpid.ToString, TFileMode.fmAppend, TFileAccess.faWrite));
  sw.BaseStream.Seek(0, TSeekOrigin.soEnd);
  sw.WriteLine(DateTimeToStr(now) + ': ' + Value);
  SW.Close;
end;

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
    I := 0;
    while true do
    begin
      // Do some task here ...
      Log('LOOPING...');
      // wait 500 milliseconds
      sleep(500);
      Inc(I);
      if I >= 100 then
        break;
    end;
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

end.
