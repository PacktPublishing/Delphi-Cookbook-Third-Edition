program ObjectsToJSONAndBack;

uses
  Vcl.Forms,
  MainFormU in 'MainFormU.pas' {MainForm},
  PersonU in 'PersonU.pas',
  JSON.Serialization in 'JSON.Serialization.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
