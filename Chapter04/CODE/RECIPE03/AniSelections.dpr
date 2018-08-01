program AniSelections;

uses
  FMX.Forms,
  MainForm in 'MainForm.pas' {DualListForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDualListForm, DualListForm);
  Application.Run;
end.
