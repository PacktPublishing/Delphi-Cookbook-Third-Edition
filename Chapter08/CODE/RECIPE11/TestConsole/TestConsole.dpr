program TestConsole;

uses
  Vcl.Forms,
  MainFormU in 'MainFormU.pas' {TestConsoleForm},
  SMS.RESTAPI.ServiceU in '..\SendSMS\Services\SMS.RESTAPI.ServiceU.pas',
  SmsBO in '..\CustomersManagerServer\BusinessObjects\SmsBO.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TTestConsoleForm, TestConsoleForm);
  Application.Run;
end.
