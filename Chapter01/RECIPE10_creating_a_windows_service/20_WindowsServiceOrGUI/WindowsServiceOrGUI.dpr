program WindowsServiceOrGUI;

uses
  Vcl.SvcMgr,
  Vcl.Forms,
  ServiceU in 'ServiceU.pas' {SampleService_ServiceVersion: TService} ,
  WorkerThreadU in 'WorkerThreadU.pas',
  MainFormU in 'MainFormU.pas',
  System.SysUtils {MainForm};

{$R *.RES}

begin
  if FindCmdLineSwitch('GUI', ['/'], True) then
  begin
    Vcl.Forms.Application.Initialize;
    Vcl.Forms.Application.MainFormOnTaskbar := True;
    Vcl.Forms.Application.CreateForm(TMainForm, MainForm);
    Vcl.Forms.Application.Run;
  end
  else
  begin
    if not Vcl.SvcMgr.Application.DelayInitialize or Vcl.SvcMgr.Application.Installing
    then
      Vcl.SvcMgr.Application.Initialize;
    Vcl.SvcMgr.Application.CreateForm(TSampleService_ServiceVersion,
      SampleService_ServiceVersion);
    Vcl.SvcMgr.Application.CreateForm(TMainForm, MainForm);
    Vcl.SvcMgr.Application.Run;
  end;

end.
