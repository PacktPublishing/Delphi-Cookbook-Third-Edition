program ConfigDispatcher;

uses
  Vcl.Forms,
  MainFormServerU in 'MainFormServerU.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
