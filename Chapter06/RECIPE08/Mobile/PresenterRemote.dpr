program PresenterRemote;

uses
  System.StartUpCopy,
  FMX.MobilePreview,
  FMX.Forms,
  MainMobileFormU in 'MainMobileFormU.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
