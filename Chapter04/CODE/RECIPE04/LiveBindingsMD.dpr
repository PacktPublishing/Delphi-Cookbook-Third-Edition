program LiveBindingsMD;

uses
  FMX.Forms,
  MainFormU in 'MainFormU.pas' {MainForm},
  BusinessObjectsU in 'BusinessObjectsU.pas',
  RandomUtilsU in '..\Commons\RandomUtilsU.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
