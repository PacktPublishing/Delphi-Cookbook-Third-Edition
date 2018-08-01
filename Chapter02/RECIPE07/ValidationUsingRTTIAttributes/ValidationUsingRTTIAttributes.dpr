program ValidationUsingRTTIAttributes;

uses
  Vcl.Forms,
  MainFormU in 'MainFormU.pas' {MainForm},
  BOsU in 'BOsU.pas',
  AttributesU in 'AttributesU.pas',
  ValidatorU in 'ValidatorU.pas',
  ErrorsMessageFormU in 'ErrorsMessageFormU.pas' {ErrorsMessageForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TErrorsMessageForm, ErrorsMessageForm);
  Application.Run;
end.
