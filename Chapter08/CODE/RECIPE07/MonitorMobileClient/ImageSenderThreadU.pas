unit ImageSenderThreadU;

interface

uses
  System.Classes, Generics.Collections, System.SysUtils;

type
  TFrameInfo = class
  private
    FLon: Double;
    FLat: Double;
    FStream: TStream;
    FTimeStamp: TDateTime;
    procedure SetLat(const Value: Double);
    procedure SetLon(const Value: Double);
    procedure SetTimeStamp(const Value: TDateTime);
  public
    constructor Create;
    property Stream: TStream read FStream;
    property Lat: Double read FLat write SetLat;
    property Lon: Double read FLon write SetLon;
    property TimeStamp: TDateTime read FTimeStamp write SetTimeStamp;
  end;

  TImageSenderThread = class(TThread)
  private
    FFormatSettings: TFormatSettings;
    FFilesToDelete: TList<String>;
    FImagesQueue: TThreadedQueue<TFrameInfo>;
  protected
    procedure Execute; override;
  public
    constructor Create;
    property ImagesQueue: TThreadedQueue<TFrameInfo> read FImagesQueue;
  end;

implementation

uses
  System.IOUtils, System.Types,
  System.Net.HttpClient, System.Net.URLClient, System.NetConsts,
  System.NetEncoding, System.SyncObjs, System.Math;

const
  MONITORSERVERURL = 'http://192.168.1.242:8080';

  { TImageSenderThread }

constructor TImageSenderThread.Create;
begin
  inherited Create(False);
  FImagesQueue := TThreadedQueue<TFrameInfo>.Create(2, 10, 1);
  FFormatSettings.DecimalSeparator := '.';
end;

procedure TImageSenderThread.Execute;
var
  lHTTPClient: THTTPClient;
  lFrameInfo: TFrameInfo;
  lEncodedParams: string;

begin
  inherited;
  FFilesToDelete := TList<String>.Create;
  lHTTPClient := THTTPClient.Create;
  lHTTPClient.ConnectionTimeout := 2000;
  lHTTPClient.ResponseTimeout := 1000;
  while not Terminated do
  begin
    try
      if FImagesQueue.PopItem(lFrameInfo) <> wrTimeout then
      begin
        lEncodedParams := Format('ts=%s&lat=%s&lon=%s',
          [FormatDateTime('YYYY-MM-DD HH-NN-SS', lFrameInfo.TimeStamp),
          FormatFloat('##0.00000000', lFrameInfo.Lat, FFormatSettings),
          FormatFloat('##0.00000000', lFrameInfo.Lon, FFormatSettings)]);

        TNetEncoding.URL.EncodeQuery(lEncodedParams);
        lHTTPClient.ContentType := 'image/png';
        lHTTPClient.Post(MONITORSERVERURL + '/photo?' + lEncodedParams,
          lFrameInfo.Stream);
      end;
    except
      // ignore HTTP exceptions, simply retry with the next frameinfo
    end;
  end;
end;

{ TFrameInfo }

constructor TFrameInfo.Create;
begin
  inherited;
  FStream := TMemoryStream.Create;
end;

procedure TFrameInfo.SetLat(const Value: Double);
begin
  FLat := Value;
end;

procedure TFrameInfo.SetLon(const Value: Double);
begin
  FLon := Value;
end;

procedure TFrameInfo.SetTimeStamp(const Value: TDateTime);
begin
  FTimeStamp := Value;
end;

end.
