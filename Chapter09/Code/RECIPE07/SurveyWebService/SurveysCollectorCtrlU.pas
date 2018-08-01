unit SurveysCollectorCtrlU;

interface

uses
  MVCFramework, MVCFramework.Commons;

type

  [MVCPath('/surveys')]
  TSurveyCollector = class(TMVCController)
  public
    [MVCPath]
    [MVCHTTPMethod([httpPOST])]
    procedure CreateSurveyResponse(ctx: TWebContext);
  end;

implementation

uses
  System.SysUtils, System.IOUtils, System.JSON,
  MVCFramework.Logger;

procedure TSurveyCollector.CreateSurveyResponse(ctx: TWebContext);
begin
  Log('Request data: ' + ctx.Request.Body);
  Log('Wait a bit...');
  Sleep(5000);
  if ctx.Request.ThereIsRequestBody then
    Render(HTTP_STATUS.OK, TJSONObject.Create(TJSONPair.Create('result', 'ok')).ToJSON)
  else
    Render(HTTP_STATUS.BadRequest,
      TJSONObject.Create(TJSONPair.Create('result', 'ko')).ToJSON);
  Log('Response sent');
end;

end.
