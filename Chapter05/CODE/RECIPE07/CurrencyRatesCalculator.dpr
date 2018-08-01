program CurrencyRatesCalculator;

uses
  Vcl.Forms,
  MainFormU in 'MainFormU.pas' {MainForm},
  AsyncTask in '..\RECIPE06\AsyncTask.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
