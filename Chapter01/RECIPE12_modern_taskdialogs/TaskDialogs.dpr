program TaskDialogs;

uses
  Forms,
  MainFormU in 'MainFormU.pas' {MainForm},
  PrimeNumbers in 'PrimeNumbers.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
