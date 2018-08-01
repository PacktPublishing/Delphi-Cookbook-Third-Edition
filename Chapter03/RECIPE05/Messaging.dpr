program Messaging;

uses
  Vcl.Forms,
  MainFormU in 'MainFormU.pas' {MainForm},
  Vcl.Themes,
  Vcl.Styles,
  SecondaryFormU in 'SecondaryFormU.pas' {SecondaryForm},
  MyMessageManagerU in 'MyMessageManagerU.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
