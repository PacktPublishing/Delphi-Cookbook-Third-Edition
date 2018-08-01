program vclmainproject;

uses
  System.ShareMem,
  Vcl.Forms,
  MainForm in 'MainForm.pas' {VCLForm},
  DLLImportU in 'DLLImportU.pas',
  CommonsU in 'CommonsU.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TVCLForm, VCLForm);
  Application.Run;

end.
