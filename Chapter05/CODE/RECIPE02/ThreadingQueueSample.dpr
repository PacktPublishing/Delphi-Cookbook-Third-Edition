// JCL_DEBUG_EXPERT_INSERTJDBG OFF
program ThreadingQueueSample;

uses
  Vcl.Forms,
  MainFormU in 'MainFormU.pas' {MainForm},
  ProducerConsumerThreadsU in 'ProducerConsumerThreadsU.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
