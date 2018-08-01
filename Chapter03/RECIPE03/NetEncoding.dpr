// JCL_DEBUG_EXPERT_INSERTJDBG OFF
program NetEncoding;

uses
  Vcl.Forms,
  MainFormU in 'MainFormU.pas' {MainForm},
  PersonBO in '..\RECIPE02\Server\BusinessObjects\PersonBO.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
