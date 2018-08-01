program RegExTester;

uses
  Forms,
  MainRegExForm in 'MainRegExForm.pas' {RegExForm};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TRegExForm, RegExForm);
  Application.Run;
end.
