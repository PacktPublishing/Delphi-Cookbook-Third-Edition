program DataSetClassHelpers;

uses
  Vcl.Forms,
  MainFormU in 'MainFormU.pas' {ClassHelpersForm},
  DataSetHelpersU in 'DataSetHelpersU.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TClassHelpersForm, ClassHelpersForm);
  Application.Run;
end.
