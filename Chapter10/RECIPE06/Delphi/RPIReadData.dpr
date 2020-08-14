program RPIReadData;

uses
  System.StartUpCopy,
  FMX.Forms,
  MainFMX in 'MainFMX.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
