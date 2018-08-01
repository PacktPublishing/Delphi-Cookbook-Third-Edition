// JCL_DEBUG_EXPERT_INSERTJDBG OFF
program ThreadsTermination;

uses
  Vcl.Forms,
  MainFormU in 'MainFormU.pas' {MainForm},
  MyThreadU in 'MyThreadU.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
