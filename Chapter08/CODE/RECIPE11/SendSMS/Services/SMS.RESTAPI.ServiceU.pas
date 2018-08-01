unit SMS.RESTAPI.ServiceU;

interface

uses
  SmsBO;

type

  ISMSRESTAPIService = interface
    ['{CA2FCE5E-C368-4230-A2A2-D1734288E9DE}']

    function PopSMS: TSMS;
    procedure PushSMS(ASMS: TSMS);
  end;

function BuildSMSRESTApiService: ISMSRESTAPIService;

implementation

uses
  MVCFramework.Serializer.JSON, System.Net.HTTPClient, REST.Types,
  MVCFramework.Serializer.Intf, System.Classes, System.SysUtils;

const
  BASE_URL = 'http://192.168.1.242:8080/sms';

type

  TSMSRESTAPIService = class(TInterfacedObject, ISMSRESTAPIService)
  private
    procedure CheckResponse(AResp: IHTTPResponse);
    procedure InitializeRequest(AReq: IHTTPRequest);
  public
    function PopSMS: TSMS;
    procedure PushSMS(ASMS: TSMS);
  end;

function BuildSMSRESTApiService: ISMSRESTAPIService;
begin
  Result := TSMSRESTAPIService.Create;
end;

{ TSMSRESTAPIService }

procedure TSMSRESTAPIService.InitializeRequest(AReq: IHTTPRequest);
begin
  AReq.AddHeader('Content-Type', CONTENTTYPE_APPLICATION_JSON);
end;

procedure TSMSRESTAPIService.CheckResponse(AResp: IHTTPResponse);
begin
  if AResp.StatusCode >= 400 then
    raise Exception.Create(AResp.ContentAsString);
end;

function TSMSRESTAPIService.PopSMS: TSMS;
var
  lHTTP: THTTPClient;
  lReq: IHTTPRequest;
  lResp: IHTTPResponse;
  LSerializer: IMVCSerializer;
begin
  lHTTP := THTTPClient.Create;
  try
    lReq := lHTTP.GetRequest('POST', BASE_URL + '/pop');
    InitializeRequest(lReq);
    lResp := lHTTP.Execute(lReq);
    CheckResponse(lResp);
    if lResp.ContentAsString.IsEmpty then
      Exit(nil);
    LSerializer := TMVCJSONSerializer.Create;
    Result := TSMS.Create;
    LSerializer.DeserializeObject(lResp.ContentAsString(), Result);
  finally
    lHTTP.Free;
  end;
end;

procedure TSMSRESTAPIService.PushSMS(ASMS: TSMS);
var
  lHTTP: THTTPClient;
  lReq: IHTTPRequest;
  lResp: IHTTPResponse;
  LSerializer: IMVCSerializer;
  LSerializedObj: string;
  LSS: TStringStream;
begin
  lHTTP := THTTPClient.Create;
  try
    LSerializer := TMVCJSONSerializer.Create;
    LSerializedObj := LSerializer.SerializeObject(ASMS);
    LSS := TStringStream.Create(LSerializedObj);
    try
      lReq := lHTTP.GetRequest('POST', BASE_URL + '/push');
      lReq.SourceStream := LSS;
      InitializeRequest(lReq);
      lResp := lHTTP.Execute(lReq);
      CheckResponse(lResp);
    finally
      LSS.Free;
    end;
  finally
    lHTTP.Free;
  end;
end;

end.
