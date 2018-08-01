program ToastDemoWithJava2OP;

uses
  System.StartUpCopy,
  FMX.MobilePreview,
  FMX.Forms,
  MainFormU in 'MainFormU.pas' {MainForm},
  AndroidSDK.Toast.Utils in 'AndroidSDK.Toast.Utils.pas',
  AndroidSDK.Java2OP.Toast in 'AndroidSDK.Java2OP.Toast.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
