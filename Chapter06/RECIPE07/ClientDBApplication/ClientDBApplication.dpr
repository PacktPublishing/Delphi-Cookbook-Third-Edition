program ClientDBApplication;

uses
  Vcl.Forms,
  MainFormClientU in 'MainFormClientU.pas' {MainFormClient};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainFormClient, MainFormClient);
  Application.Run;
end.
