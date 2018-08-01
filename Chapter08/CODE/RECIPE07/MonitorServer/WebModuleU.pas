unit WebModuleU;

interface

uses System.SysUtils, System.Classes, Web.HTTPApp;

type
  TwmMain = class(TWebModule)
    WebFileDispatcher1: TWebFileDispatcher;
    procedure WebModule1DefaultHandlerAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure wmMainwaPhotoAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure WebModuleCreate(Sender: TObject);
  private
    FFormatSettings: TFormatSettings;
    procedure DeleteFiles;

  const
    DATEFORMAT = 'YYYY-MM-DD HH-NN-SS';
  public
    { Public declarations }
  end;

var
  WebModuleClass: TComponentClass = TwmMain;

implementation

uses Web.ReqMulti, System.DateUtils, System.IOUtils, System.Types, System.JSON;

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}

procedure TwmMain.DeleteFiles;
var
  OldFiles: TStringDynArray;
  OldFile: String;
  lFileTimeStamp: TDateTime;
  lLastFileName: string;
begin
  // delete all the files older than 20 seconds

  lFileTimeStamp := Now - OneSecond * 20;
  lLastFileName := FormatDateTime(DATEFORMAT, lFileTimeStamp) + '.png';
  OldFiles := TDirectory.GetFiles('images', '*.png',
    function(const Path: string; const SearchRec: TSearchRec): Boolean
    begin
      Result := SearchRec.Name < lLastFileName;
    end);
  for OldFile in OldFiles do
  begin
    try
      TFile.Delete(OldFile);
      TFile.Delete(OldFile + '.info');
    except

    end;
  end;
end;

procedure TwmMain.WebModule1DefaultHandlerAction(Sender: TObject;
Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  lHTMLOut: TStringBuilder;
  lFileName, lJSONInfoString: string;
  lStart, lFileTimeStamp: TDateTime;
  lTimes: Integer;
  lJSONInfo: TJSONObject;
  lLat, lLon: Double;
const
  MONITORED_MINUTES = 5;
begin
  lHTMLOut := TStringBuilder.Create;
  try
    lHTMLOut.AppendLine('<!doctype html><html><head>');
    lHTMLOut.AppendLine('<style>');
    lHTMLOut.AppendLine
      ('  body {font-family: Verdana; padding: 40px 10px 0px 50px; }');
    lHTMLOut.AppendLine('  pre  {font-size: 200%;}');
    lHTMLOut.AppendLine('</style>');
    lHTMLOut.AppendLine('<meta http-equiv = "refresh" Content = "4">');
    lHTMLOut.AppendLine('</head><body>');
    lHTMLOut.AppendLine('<h1>Delphi Cookbook Mobile Monitor</h1>');
    lStart := Now;
    lTimes := 0;
    while true do
    begin
      lTimes := lTimes + 1;
      lFileTimeStamp := lStart - OneSecond * lTimes;
      lFileName := 'images' + PathDelim + FormatDateTime(DATEFORMAT,
        lFileTimeStamp) + '.png';
      if TFile.Exists(lFileName) then
      begin
        lHTMLOut.AppendFormat('<h3>Last update %s</h3>',
          [DateTimeToStr(lFileTimeStamp)]);
        lHTMLOut.AppendFormat('<img src="%s"><br>', [lFileName]);
        if TFile.Exists(lFileName + '.info') then
        begin
          try
            lJSONInfoString := TFile.ReadAllText(lFileName + '.info');
            lJSONInfo := TJSONObject.ParseJSONValue(lJSONInfoString)
              as TJSONObject;
            if Assigned(lJSONInfo) then
            begin
              lLat := (lJSONInfo.GetValue('lat') as TJSONNumber).AsDouble;
              lLon := (lJSONInfo.GetValue('lon') as TJSONNumber).AsDouble;
              lHTMLOut.AppendFormat('<pre>Lat: %3.8f Lon: %3.8f</pre>',
                [lLat, lLon]);
            end
            else
              lHTMLOut.Append('<pre>Invalid metadata information');
          except
            on E: Exception do
            begin
              lHTMLOut.AppendFormat('<pre>Invalid metadata information: %s',
                [E.Message]);
            end;
          end;
        end
        else
        begin
          lHTMLOut.Append('<pre>No others info available</pre>');
        end;
        Break;
      end
      else if lTimes >= 60 * MONITORED_MINUTES then
      begin
        lHTMLOut.AppendFormat
          ('<h2>No image availables in the last %d minutes</h2>',
          [MONITORED_MINUTES]);
        Break;
      end;
    end;
    lHTMLOut.AppendLine('</body></html>');
    Response.Content := lHTMLOut.ToString;
  finally
    lHTMLOut.Free;
  end;
end;

procedure TwmMain.WebModuleCreate(Sender: TObject);
begin
  FFormatSettings.DecimalSeparator := '.';
end;

procedure TwmMain.wmMainwaPhotoAction(Sender: TObject; Request: TWebRequest;
Response: TWebResponse; var Handled: Boolean);
var
  lFileStream: TFileStream;
  lByteStream: TBytesStream;
  lFileName: string;
  lLat: Double;
  lLon: Double;
  lInfoObject: TJSONObject;

  procedure SaveInfoFile;
  begin
    lInfoObject := TJSONObject.Create;
    if TryStrToFloat(Request.QueryFields.Values['lat'], lLat, FFormatSettings)
    then
      lInfoObject.AddPair('lat', TJSONNumber.Create(lLat));
    if TryStrToFloat(Request.QueryFields.Values['lon'], lLon, FFormatSettings)
    then
      lInfoObject.AddPair('lon', TJSONNumber.Create(lLon));
    TFile.WriteAllText('images' + PathDelim + lFileName + '.info',
      lInfoObject.ToString);
  end;

  function QueryFieldsValidation: Boolean;
  begin
    Result := true;
    Result := Result and (not Request.QueryFields.Values['ts'].IsEmpty);
    Result := Result and (not Request.QueryFields.Values['lat'].IsEmpty);
    Result := Result and (not Request.QueryFields.Values['lon'].IsEmpty);
  end;

begin
  if not QueryFieldsValidation then
  begin
    Response.StatusCode := 400;
    Response.Content := 'Invalid query fields';
    Exit;
  end;
  if not SameText(Request.ContentType, 'image/png') then
  begin
    Response.StatusCode := 400;
    Response.Content := 'Invalid content type';
    Exit;
  end;

  TDirectory.CreateDirectory('images');
  lFileName := Request.QueryFields.Values['ts'] + '.png';
  lFileStream := TFileStream.Create('images' + PathDelim + lFileName, fmCreate);
  try
    lByteStream := TBytesStream.Create(Request.RawContent);
    try
      lFileStream.CopyFrom(lByteStream, 0);
    finally
      lByteStream.Free;
    end;
  finally
    lFileStream.Free;
  end;
  SaveInfoFile;
  Response.StatusCode := 200;
  DeleteFiles;
end;

end.
