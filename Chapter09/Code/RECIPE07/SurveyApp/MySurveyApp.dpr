program MySurveyApp;

uses
  System.StartUpCopy,
  FMX.Forms,
  MainFormU in 'MainFormU.pas' {MainForm},
  MainServiceU in '..\SurveyService\MainServiceU.pas' {AndroidServiceDM: TAndroidService},
  BroadcastReceiverU in 'BroadcastReceiverU.pas',
  UtilsU in 'UtilsU.pas',
  LogU in '..\SurveyService\LogU.pas',
  ConstantsU in '..\SurveyService\ConstantsU.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
