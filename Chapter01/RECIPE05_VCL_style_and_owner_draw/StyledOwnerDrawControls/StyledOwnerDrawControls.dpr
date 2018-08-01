program StyledOwnerDrawControls;



uses
  Vcl.Forms,
  MainFormU in 'MainFormU.pas' {MainForm},
  Vcl.Themes,
  Vcl.Styles,
  LampInfoU in 'LampInfoU.pas',
  ZonesU in 'ZonesU.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;

end.
