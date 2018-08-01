unit ServiceU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.SvcMgr, Vcl.Dialogs,
  WorkerThreadU;

type
  TSampleService = class(TService)
    procedure ServiceExecute(Sender: TService);
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
    procedure ServicePause(Sender: TService; var Paused: Boolean);
    procedure ServiceContinue(Sender: TService; var Continued: Boolean);
    procedure ServiceAfterInstall(Sender: TService);
  private
    FWorkerThread: TWorkerThread;
    { Private declarations }
  public
    function GetServiceController: TServiceController; override;
    { Public declarations }
  end;

{$R *.dfm}


var
  SampleService: TSampleService;

implementation

uses
  System.Win.Registry;

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  SampleService.Controller(CtrlCode);
end;

function TSampleService.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TSampleService.ServiceAfterInstall(Sender: TService);
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create(KEY_READ or KEY_WRITE);
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    if Reg.OpenKey('\SYSTEM\CurrentControlSet\Services\' + name, false) then
    begin
      Reg.WriteString('Description', 'My Fantastic Windows Service');
      Reg.CloseKey;
    end;
  finally
    Reg.Free;
  end;
end;

procedure TSampleService.ServiceContinue(Sender: TService;
  var Continued: Boolean);
begin
  FWorkerThread.Continue;
  Continued := True;
end;

procedure TSampleService.ServicePause(Sender: TService; var Paused: Boolean);
begin
  FWorkerThread.Pause;
  Paused := True;
end;

procedure TSampleService.ServiceStart(Sender: TService; var Started: Boolean);
begin
  FWorkerThread := TWorkerThread.Create(True);
  FWorkerThread.Start;
  Started := True;
end;

procedure TSampleService.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
  FWorkerThread.Terminate;
  FWorkerThread.WaitFor;
  FreeAndNil(FWorkerThread);
  Stopped := True;
end;

procedure TSampleService.ServiceExecute(Sender: TService);
begin
  while not Terminated do
  begin
    ServiceThread.ProcessRequests(false);
    TThread.Sleep(1000);
  end;
end;

end.
