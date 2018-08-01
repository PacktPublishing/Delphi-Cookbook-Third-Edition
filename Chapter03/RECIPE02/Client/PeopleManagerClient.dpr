// JCL_DEBUG_EXPERT_INSERTJDBG OFF
program PeopleManagerClient;

uses
  Vcl.Forms,
  MainFormU in 'MainFormU.pas' {MainForm};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
