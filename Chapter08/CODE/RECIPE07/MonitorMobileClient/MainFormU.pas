unit MainFormU;

interface

uses
  System.SysUtils, System.Sensors, System.Sensors.Components, FMX.StdCtrls,
  FMX.Controls, FMX.Controls.Presentation, FMX.Media, System.Classes, FMX.Types,
  FMX.Objects, FMX.Forms, System.UITypes, ImageSenderThreadU, FMX.Graphics;

type
  TMainForm = class(TForm)
    CameraComponent1: TCameraComponent;
    Image1: TImage;
    LocationSensor1: TLocationSensor;
    Panel1: TPanel;
    Label1: TLabel;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure LocationSensor1LocationChanged(Sender: TObject;
      const OldLocation, NewLocation: TLocationCoord2D);
    procedure CameraComponent1SampleBufferReady(Sender: TObject;
      const ATime: TMediaTime);
    procedure Button1Click(Sender: TObject);
  private
    FLastSent: TDateTime;
    FSenderThread: TImageSenderThread;
    CurrLocation: TLocationCoord2D;
    FSnapshot: TBitmap;
    procedure UpdateGUI;
    function GetResizedBitmap(const Value: TBitmap;
      const MaxSize: UInt16 = 640): TBitmap;
    { Private declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses System.DateUtils, System.IOUtils, System.SyncObjs, System.StrUtils,
  System.Math;

{$R *.fmx}

procedure TMainForm.Button1Click(Sender: TObject);
begin
  CameraComponent1.Active := not CameraComponent1.Active;
{$IF Defined(Android) or Defined(IOS) }
  LocationSensor1.Active := CameraComponent1.Active;
{$ENDIF}
  UpdateGUI;
end;

function TMainForm.GetResizedBitmap(const Value: TBitmap;
  const MaxSize: UInt16 = 640): TBitmap;
var
  lProp: Extended;
  lLongerSide: Double;
begin
  Result := TBitmap.Create;
  Result.Assign(Value);
  lLongerSide := Max(Value.Width, Value.Height);
  if lLongerSide > MaxSize then
  begin
    lProp := MaxSize / lLongerSide;
    Result.Resize(Trunc(Value.Width * lProp), Trunc(Value.Height * lProp));
  end;
end;

procedure TMainForm.CameraComponent1SampleBufferReady(Sender: TObject;
  const ATime: TMediaTime);
var
  lFrame: TFrameInfo;
  lBitmapToSend: TBitmap;
begin
  CameraComponent1.SampleBufferToBitmap(FSnapshot, True);
  Image1.Bitmap.Assign(FSnapshot);

  if SecondsBetween(now, FLastSent) >= 4 then
  begin
    lBitmapToSend := GetResizedBitmap(FSnapshot);
    try
      lFrame := TFrameInfo.Create;
      lFrame.TimeStamp := now;
      lFrame.Lat := CurrLocation.Latitude;
      lFrame.Lon := CurrLocation.Longitude;
      lBitmapToSend.SaveToStream(lFrame.Stream);
      lFrame.Stream.Position := 0;
      FSenderThread.ImagesQueue.PushItem(lFrame);
    finally
      lBitmapToSend.Free;
    end;
    FLastSent := now;
  end;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CameraComponent1.Active := False;
  LocationSensor1.Active := False;
  FSenderThread.Terminate;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FSenderThread := TImageSenderThread.Create;
  FSnapshot := TBitmap.Create;
  CameraComponent1.Quality := TVideoCaptureQuality.MediumQuality;
  FLastSent := Yesterday;
  UpdateGUI;
end;

procedure TMainForm.LocationSensor1LocationChanged(Sender: TObject;
  const OldLocation, NewLocation: TLocationCoord2D);
begin
  CurrLocation := NewLocation;
end;

procedure TMainForm.UpdateGUI;
begin
  Button1.StyleLookup := IfThen(CameraComponent1.Active, 'stoptoolbutton',
    'playtoolbutton');
end;

end.
