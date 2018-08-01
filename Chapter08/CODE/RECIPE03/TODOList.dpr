program TODOList;

uses
  System.StartUpCopy,
  FMX.Forms,
  MainFormU in 'MainFormU.pas' {MainForm},
  BoolToStringConverterU in 'BoolToStringConverterU.pas';

{$R *.res}


begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;

end.
