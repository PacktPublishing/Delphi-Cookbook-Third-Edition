unit SMS.ServiceU;

interface

type
  ISMSService = interface
    ['{C44D7371-6E5B-427D-A017-2163DFC6DA34}']
    procedure SendSMS(const Number: string; Text: string);
    procedure SendNextSMS;
  end;

function GetSMSService: ISMSService;

implementation

uses
  Androidapi.Helpers, Androidapi.JNI.JavaTypes, Androidapi.JNI.Telephony,
  SMS.RESTAPI.ServiceU, System.Rtti, SmsBO, System.Threading, System.SysUtils,
  System.UITypes;

type
  TSMSService = class(TInterfacedObject, ISMSService)
  public
    procedure SendSMS(const Number: string; Text: string);
    procedure SendNextSMS;
  end;

  { TSMSService }

procedure TSMSService.SendNextSMS;
var
  LRESTApi: ISMSRESTAPIService;
begin

  TTask.Run(
    procedure
    var
      ASMS: TSMS;
    begin
      LRESTApi := BuildSMSRESTApiService;
      ASMS := LRESTApi.PopSMS;
      if not Assigned(ASMS) then
        exit;
      try
        SendSMS(ASMS.DESTINATION, ASMS.Text);
      finally
        ASMS.Free;
      end;

    end);
end;

procedure TSMSService.SendSMS(const Number: string; Text: string);
var
  LSmsManager: JSmsManager;
  LSmsTo, LSmsFrom, LText: JString;
begin
  LSmsManager := TJSmsManager.JavaClass.getDefault;
  // destination number
  LSmsTo := StringToJString(Number);
  LSmsFrom := nil;
  // sms text
  LText := StringToJString(Text);
  LSmsManager.sendTextMessage(LSmsTo, LSmsFrom, LText, nil, nil);
end;

function GetSMSService: ISMSService;
begin
  Result := TSMSService.Create;
end;

end.
