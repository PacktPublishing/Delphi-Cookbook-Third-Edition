// JCL_DEBUG_EXPERT_INSERTJDBG OFF
program ThreadedMeasurer;

uses
  FMX.Forms,
  MainFormU in 'MainFormU.pas' {MainForm},
  SignalGeneratorU in 'SignalGeneratorU.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
