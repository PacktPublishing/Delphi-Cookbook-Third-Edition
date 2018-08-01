// JCL_DEBUG_EXPERT_INSERTJDBG OFF
program DBMonitorTFuture;

uses
  Vcl.Forms,
  MainFormU in 'MainFormU.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
