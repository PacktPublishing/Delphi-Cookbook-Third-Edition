program ValidationUsingRTTIAttributesBonus;

uses
  Vcl.Forms,
  MainFormU in 'MainFormU.pas' {MainForm},
  BOsU in 'BOsU.pas',
  AttributesU in 'AttributesU.pas',
  ValidatorU in 'ValidatorU.pas',
  ErrorsMessageFormU in 'ErrorsMessageFormU.pas' {ErrorsMessageForm},
  LoginFormU in 'LoginFormU.pas' {LoginForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TErrorsMessageForm, ErrorsMessageForm);
  Application.CreateForm(TLoginForm, LoginForm);
  Application.Run;
end.
