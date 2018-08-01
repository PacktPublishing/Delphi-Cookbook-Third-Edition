program SendSMS;

uses
  System.StartUpCopy,
  FMX.Forms,
  MainFormU in 'MainFormU.pas' {SMSSendingForm} ,
  SMS.ServiceU in 'Services\SMS.ServiceU.pas',
  SMS.RESTAPI.ServiceU in 'Services\SMS.RESTAPI.ServiceU.pas',
  SmsBO in '..\CustomersManagerServer\BusinessObjects\SmsBO.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TSMSSendingForm, SMSSendingForm);
  Application.Run;

end.
