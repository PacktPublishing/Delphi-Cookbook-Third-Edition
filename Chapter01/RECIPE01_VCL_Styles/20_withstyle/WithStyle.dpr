program WithStyle;

uses
  Vcl.Forms,
  MainFormU in 'MainFormU.pas' {Form3},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Iceberg Classico');
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
