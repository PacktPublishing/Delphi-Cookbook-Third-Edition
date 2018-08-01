unit HTTPLayerDMU;

interface

uses
  System.SysUtils, System.Classes, System.Net.URLClient, System.Net.HttpClient,
  System.Net.HttpClientComponent;

type
  THTTPDM = class(TDataModule)
    HttpClient: TNetHTTPClient;
    procedure HTTPClientValidateServerCertificate(const Sender: TObject;
      const ARequest: TURLRequest; const Certificate: TCertificate;
      var Accepted: Boolean);
    procedure HTTPClientReceiveData(const Sender: TObject;
      AContentLength, AReadCount: Int64; var Abort: Boolean);
  private
    FReadCount: UInt64;
    FCertificate: TCertificate;
    procedure Clear;
  public
    function Get(const URL: String): IHTTPResponse;
    function Post(const URL: String; BodyRequest: TStream; Headers: TNetHeaders)
      : IHTTPResponse;
    property ReadCount: UInt64 read FReadCount;
    property Certificate: TCertificate read FCertificate;

  type
    TResponseData = record
      Response: IHTTPResponse;
      ReadedBytes: UInt64;
      Certificate: TCertificate;
      function HeadersAsStrings: TArray<String>;
    end;
  end;

implementation

{ %CLASSGROUP 'FMX.Controls.TControl' }

{$R *.dfm}

function THTTPDM.Get(const URL: String): IHTTPResponse;
begin
  Clear;
  Result := HttpClient.Get(URL);
end;

procedure THTTPDM.HTTPClientReceiveData(const Sender: TObject;
  AContentLength, AReadCount: Int64; var Abort: Boolean);
begin
  FReadCount := AReadCount;
end;

procedure THTTPDM.HTTPClientValidateServerCertificate(const Sender: TObject;
  const ARequest: TURLRequest; const Certificate: TCertificate;
  var Accepted: Boolean);
begin
  Accepted := (Certificate.Start <= Now) and (Certificate.Expiry >= Now);
  FCertificate := Certificate;
end;

function THTTPDM.Post(const URL: String; BodyRequest: TStream;
  Headers: TNetHeaders): IHTTPResponse;
begin
  Clear;
  Result := HttpClient.Post(URL, BodyRequest, nil, Headers);
end;

procedure THTTPDM.Clear;
begin
  FReadCount := 0;
end;

{ THTTPDM.TResponseData }

function THTTPDM.TResponseData.HeadersAsStrings: TArray<String>;
var
  Pair: TNameValuePair;
begin
  Result := [];
  for Pair in Response.Headers do
  begin
    Insert(Pair.Name + ':' + Pair.Value, Result, MaxLongInt);
  end;
end;

end.
