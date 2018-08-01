program MySurveyService;

uses
  System.Android.ServiceApplication,
  MainServiceU in 'MainServiceU.pas' {AndroidServiceDM: TAndroidService},
  LogU in 'LogU.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TAndroidServiceDM, AndroidServiceDM);
  Application.Run;
end.
