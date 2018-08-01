program HigherOrderFunctions;

uses
  Vcl.Forms,
  MainFormU in 'MainFormU.pas' {MainForm},
  HigherOrderFunctionsU in 'HigherOrderFunctionsU.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
