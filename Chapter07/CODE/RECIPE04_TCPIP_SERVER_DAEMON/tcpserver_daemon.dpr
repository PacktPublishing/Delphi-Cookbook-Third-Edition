program tcpserver_daemon;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  Posix.Signal,
  System.SysUtils,
  System.SyncObjs,
  ServerModuleU in 'ServerModuleU.pas' {ServerModule: TDataModule} ,
  LogU in '..\Commons\LogU.pas';

var
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
  sigaction(SIGINT, @lAction, nil);  // sent by the console hitting ctrl+c
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

begin
  try
    Log('Started');
    Main;
    Log('Finished');
  except
    on E: Exception do
      Log('ERROR> ' + E.ClassName + ': ' + E.Message);
  end;

end.
