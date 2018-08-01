program DuckTypingUsingRTTI;

uses
  Vcl.Forms,
  MainFormU in 'MainFormU.pas' {Form1},
  DuckUtilsU in 'DuckUtilsU.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
