program PieChart;

uses
  System.StartUpCopy,
  FMX.Forms,
  MainFormU in 'MainFormU.pas' {MainForm},
  ColorsUtilsU in 'ColorsUtilsU.pas',
  HigherOrderFunctionsU in '..\..\..\Chapter02\CODE\RECIPE01\10_HigherOrder functions\HigherOrderFunctionsU.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
