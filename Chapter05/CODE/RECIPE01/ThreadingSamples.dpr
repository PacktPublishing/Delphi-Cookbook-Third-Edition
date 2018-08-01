// JCL_DEBUG_EXPERT_INSERTJDBG OFF
program ThreadingSamples;

uses
  Vcl.Forms,
  MainFormU in 'MainFormU.pas' {MainForm},
  FileWriterThreadU in 'FileWriterThreadU.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
