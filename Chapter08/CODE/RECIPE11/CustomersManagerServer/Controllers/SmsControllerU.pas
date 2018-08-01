unit SmsControllerU;

interface

uses
  MVCFramework, SmsModuleU, MVCFramework.Commons;

type

  [MVCPath('/sms')]
  TSmsController = class(TMVCController)
  private
    FSmsModule: TSmsModule;
  protected
    procedure OnAfterAction(Context: TWebContext;
      const AActionNAme: string); override;
    procedure OnBeforeAction(Context: TWebContext; const AActionNAme: string;
      var Handled: Boolean); override;
  public

    [MVCPath('/push')]
    [MVCHTTPMethod([httpPOST])]
    [MVCConsumes('application/json')]
    procedure PushSMS;

    [MVCPath('/pop')]
    [MVCHTTPMethod([httpPOST])]
    [MVCConsumes('application/json')]
    procedure PopSMS;
  end;

implementation

uses
  SmsBO;

{ TPeopleController }

procedure TSmsController.PushSMS;
var
  LSMS: TSMS;
begin
  LSMS := Context.Request.BodyAs<TSMS>;
  FSmsModule.Push(LSMS);
  Render(201, 'SMS pushed');
end;

procedure TSmsController.PopSMS;
var
  LSMS: TSMS;
begin
  LSMS := FSmsModule.Pop();
  if Assigned(LSMS) then
    Render(LSMS)
  else
    Render(404, 'Queue empty');
end;

procedure TSmsController.OnAfterAction(Context: TWebContext;
  const AActionNAme: string);
begin
  inherited;
  FSmsModule.Free;
end;

procedure TSmsController.OnBeforeAction(Context: TWebContext;
  const AActionNAme: string; var Handled: Boolean);
begin
  inherited;
  FSmsModule := TSmsModule.Create(nil);
end;

end.
