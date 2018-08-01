program SendingAndroidIntents;

uses
  System.StartUpCopy,
  FMX.MobilePreview,
  FMX.Forms,
  MainFormU in 'MainFormU.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
