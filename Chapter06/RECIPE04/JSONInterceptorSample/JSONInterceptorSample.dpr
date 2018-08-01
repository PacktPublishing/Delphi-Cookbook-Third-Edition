program JSONInterceptorSample;

uses
  Vcl.Forms,
  MainFormU in 'MainFormU.pas' {Form9},
  StreamJSONInterceptors in 'StreamJSONInterceptors.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm9, Form9);
  Application.Run;
end.
