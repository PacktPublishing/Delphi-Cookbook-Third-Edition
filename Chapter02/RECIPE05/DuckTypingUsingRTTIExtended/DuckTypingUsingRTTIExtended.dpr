program DuckTypingUsingRTTIExtended;

uses
  Vcl.Forms,
  MainFormU in 'MainFormU.pas' {Form1},
  DuckTypeUtilsU in 'DuckTypeUtilsU.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
