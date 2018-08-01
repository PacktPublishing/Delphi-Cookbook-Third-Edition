program TabbedBrowserLikeInterface;

uses
  Vcl.Forms,
  MainFormU in 'MainFormU.pas' {MainForm},
  EmbeddableFormU in 'EmbeddableFormU.pas' {EmbeddableForm},
  Form1U in 'Form1U.pas' {Form1},
  Form2U in 'Form2U.pas' {Form2},
  Form3U in 'Form3U.pas' {Form3};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;

end.
