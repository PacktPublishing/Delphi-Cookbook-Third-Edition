unit MainFormU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, REST.JSON, REST.JSONReflect, StreamJSONInterceptors, Vcl.StdCtrls;

type
  TPhoto = class
  private
    [JSONReflect(ctString, rtString, TStreamInterceptor)]
    FStream: TStream;
    FLon: Single;
    FLat: Single;
    procedure SetStream(const Value: TStream);
    procedure SetLat(const Value: Single);
    procedure SetLon(const Value: Single);
  public
    constructor Create;
    destructor Destroy; override;
    property Stream: TStream read FStream write SetStream;
    property Lat: Single read FLat write SetLat;
    property Lon: Single read FLon write SetLon;
  end;

  TForm9 = class(TForm)
    Memo1: TMemo;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form9: TForm9;

implementation

uses ioutils;

{$R *.dfm}


procedure TForm9.FormCreate(Sender: TObject);
var
  Photo: TPhoto;
begin
  Photo := TPhoto.Create;
  try
    Photo.Stream := TFile.OpenRead('..\..\img.png');
    Photo.Lat := 42.10;
    Photo.Lon := 16.45;
    Memo1.Lines.Text := TJSON.ObjectToJsonString(Photo);
  finally
    Photo.Free;
  end;
end;

{ TPhoto }

constructor TPhoto.Create;
begin
  inherited;

end;

destructor TPhoto.Destroy;
begin
  FreeAndNil(FStream);
  inherited;
end;

procedure TPhoto.SetLat(const Value: Single);
begin
  FLat := Value;
end;

procedure TPhoto.SetLon(const Value: Single);
begin
  FLon := Value;
end;

procedure TPhoto.SetStream(const Value: TStream);
begin
  FStream := Value;
end;

end.
