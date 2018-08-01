program ApplicationLifeCycle;

uses
  System.StartUpCopy,
  FMX.Forms,
  MainFormU in 'MainFormU.pas' {MainForm} ,
  SecondFormU in 'SecondFormU.pas';

{$R *.res}


begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;

end.
