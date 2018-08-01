program RuntimeConfigurationUsingRTTI;

uses
  Vcl.Forms,
  MainFormU in 'MainFormU.pas' {MainForm},
  CalculationCustomerDefaultU in 'CalculationCustomerDefaultU.pas',
  CalculationCustomer_CityMall in 'CalculationCustomer_CityMall.pas',
  CalculationCustomer_CountryRoad in 'CalculationCustomer_CountryRoad.pas',
  CalculationCustomer_Spark in 'CalculationCustomer_Spark.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
