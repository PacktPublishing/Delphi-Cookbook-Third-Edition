program CustomizeStdControls;

uses
  FMX.Forms,
  MainFormU in 'MainFormU.pas' {MainForm},
  RandomUtilsU in '..\Commons\RandomUtilsU.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
