program TDataSetToJSONAndBack;

uses
  Vcl.Forms,
  MainFormU in 'MainFormU.pas' {MainForm},
  MainDMU in 'MainDMU.pas' {dm: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(Tdm, dm);
  Application.Run;
end.
