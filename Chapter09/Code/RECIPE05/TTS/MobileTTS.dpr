program MobileTTS;

uses
  System.StartUpCopy,
  FMX.Forms,
  MainMobileFormU in 'MainMobileFormU.pas' {MainForm},
  Androidapi.JNI.TTS in 'Androidapi.JNI.TTS.pas',
  TTSListenerU in 'TTSListenerU.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
