// JCL_DEBUG_EXPERT_INSERTJDBG OFF
program AsyncTaskSample;

uses
  Vcl.Forms,
  MainFormU in 'MainFormU.pas' {MainForm},
  AsyncTask in 'AsyncTask.pas';

{$R *.res}

begin
	ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
