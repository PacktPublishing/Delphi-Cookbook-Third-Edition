program ETLWithFDBatchMove;

uses
  Vcl.Forms,
  MainFormU in 'MainFormU.pas' {MainForm};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := true;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
