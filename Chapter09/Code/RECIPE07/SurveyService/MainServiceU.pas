unit MainServiceU;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Android.Service,
  AndroidApi.JNI.GraphicsContentViewText,
  AndroidApi.JNI.Os;

type
  TAndroidServiceDM = class(TAndroidService)
    function AndroidServiceStartCommand(const Sender: TObject;
      const Intent: JIntent; Flags, StartId: Integer): Integer;
  private
    procedure BroadcastResponse(Value: String);
    procedure BroadcastException(const E: Exception);
    { Private declarations }
  public
    { Public declarations }
  end;

const
  BASE_URL = 'http://192.168.1.242:8080';

var
  AndroidServiceDM: TAndroidServiceDM;

implementation

{ %CLASSGROUP 'FMX.Controls.TControl' }

{$R *.dfm}

uses
  AndroidApi.JNI.App, AndroidApi.Helpers, System.JSON, System.Messaging,
  System.Net.HTTPClient, AndroidApi.JNI.JavaTypes, LogU, ConstantsU;

function TAndroidServiceDM.AndroidServiceStartCommand(const Sender: TObject;
  const Intent: JIntent; Flags, StartId: Integer): Integer;
var
  LJSONString: string;
begin
  if Assigned(Intent) and Intent.hasExtra(StringToJString('data')) then
  begin
    LJSONString := JStringToString
      (Intent.getStringExtra(StringToJString('data')));
    TThread.CreateAnonymousThread(
      procedure
      var
        LHTTP: THTTPClient;
        LData: TStringStream;
        LResp: IHTTPResponse;
      begin
        LHTTP := THTTPClient.Create;
        LData := TStringStream.Create(LJSONString, TEncoding.UTF8);
        LData.Position := 0;
        LogInfo('Sending data to %s/surveys', [BASE_URL], 'survey');
        try
          LResp := LHTTP.Post(BASE_URL + '/surveys', LData);
          BroadcastResponse(LResp.ContentAsString);
        except
          on E: Exception do
          begin
            BroadcastException(E);
          end;
        end;
        JavaService.stopSelfResult(StartId);
        LogWarning('Stopped StartId=%d', [StartId], 'surveyservice');
      end).Start;
  end
  else
  begin
    LogWarning('Service started, but no intent delivered', [], 'surveyservice');
  end;
  // We want this service to continue running until it is explicitly
  // stopped and restarted if killed, so return sticky.
  Result := TJService.JavaClass.START_STICKY;
end;

procedure TAndroidServiceDM.BroadcastException(const E: Exception);
var
  LJIntent: JIntent;
begin
  LJIntent := TJIntent.Create;
  LJIntent.setAction(StringToJString(TSurveyConstants.SURVEY_RESPONSE_ERROR));
  LJIntent.putExtra(StringToJString('error'),
    StringToJString(E.ClassName + ': ' + E.Message));
  TAndroidHelper.Context.sendBroadcast(LJIntent);
end;

procedure TAndroidServiceDM.BroadcastResponse(Value: String);
var
  LJIntent: JIntent;
begin
  LJIntent := TJIntent.Create;
  LJIntent.setAction(StringToJString(TSurveyConstants.SURVEY_RESPONSE));
  LJIntent.putExtra(StringToJString('result'), StringToJString(Value));
  TAndroidHelper.Context.sendBroadcast(LJIntent);
end;

end.
