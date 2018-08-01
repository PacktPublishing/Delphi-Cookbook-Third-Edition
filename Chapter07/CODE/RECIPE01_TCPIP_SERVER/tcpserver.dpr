program tcpserver;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils,
  System.SyncObjs,
  ServerModuleU in 'ServerModuleU.pas' {ServerModule: TDataModule} ,
  LogU in '..\Commons\LogU.pas';

var
  lServerModule: TServerModule;

procedure Main;
begin
  lServerModule := TServerModule.Create(nil);
  lServerModule.Start;
  while true do
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
