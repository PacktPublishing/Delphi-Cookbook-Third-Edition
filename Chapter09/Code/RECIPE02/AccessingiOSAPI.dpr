program AccessingiOSAPI;

uses
  System.StartUpCopy,
  FMX.MobilePreview,
  FMX.Forms,
  MainFormU in 'MainFormU.pas' {MainForm},
  UIDeviceSDK in 'UIDeviceSDK.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
