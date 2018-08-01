unit MainFormU;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, Generics.Collections,
  SignalGeneratorU, Data.Bind.EngExt, FMX.Bind.DBEngExt, System.Rtti,
  System.Bindings.Outputs, FMX.Bind.Editors,
  Data.Bind.Components, FMX.Controls.Presentation, System.Math.Vectors;

type
  TMainForm = class(TForm)
    Timer1: TTimer;
    pb: TPaintBox;
    TrackBar1: TTrackBar;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure pbPaint(Sender: TObject; Canvas: TCanvas);
    procedure FormResize(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
  private
    FValuesQueue: TThreadedQueue<Extended>;
    FDisplayList: TList<Extended>;
    Th: TSignalGeneratorThread;
    FMaxValuesCount: Integer;
    procedure SetMaxValuesCount(const Value: Integer);
    procedure DrawOpenPolygon(const Canvas: TCanvas; const Points: TPolygon;
      const AOpacity: Single);
  public
    property MaxValuesCount: Integer read FMaxValuesCount
      write SetMaxValuesCount;
  end;

var
  MainForm: TMainForm;
{$R *.fmx}

implementation

uses
  System.SyncObjs;

procedure TMainForm.DrawOpenPolygon(const Canvas: TCanvas;
  const Points: TPolygon; const AOpacity: Single);
var
  I: Integer;
  LPath: TPathData;
begin
  if Length(Points) = 0 then
    Exit;
  LPath := TPathData.Create;
  try
    LPath.MoveTo(Points[0]);
    for I := 1 to High(Points) do
      LPath.LineTo(Points[I]);
    Canvas.DrawPath(LPath, AOpacity);
  finally
    LPath.Free;
  end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  I: Integer;
begin
  FMaxValuesCount := 200;
  TrackBar1.Value := MaxValuesCount;
  FValuesQueue := TThreadedQueue<Extended>.Create(1000, 1000, 1);
  FDisplayList := TList<Extended>.Create;

  for I := 0 to FMaxValuesCount - 1 do
    FDisplayList.Add(0);

  Th := TSignalGeneratorThread.Create(FValuesQueue);
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  Th.Terminate;
  Th.WaitFor;
  Th.Free;
  FValuesQueue.Free;
end;

procedure TMainForm.FormResize(Sender: TObject);
begin
  pb.Repaint;
end;

procedure TMainForm.pbPaint(Sender: TObject; Canvas: TCanvas);
var
  Values: TPolygon;
  I: Integer;
  XStep: Extended;
  YCenter: Integer;
begin
  // prepare scene
  Canvas.BeginScene;
  Canvas.Stroke.Kind := TBrushKind.Solid;
  Canvas.Stroke.Thickness := 1;

  // setup the canvas with a white background
  Canvas.Fill.Color := TAlphaColorRec.White;
  Canvas.FillRect(RectF(0, 0, Canvas.Width, Canvas.Height), 0, 0, [], 1);

  // write the blue top-left labels
  Canvas.Fill.Color := TAlphaColorRec.Blue;
  Canvas.FillText(RectF(10, 10, Canvas.Width, 40),
    'Resolution: ' + MaxValuesCount.ToString + ' points', False, 1, [],
    TTextAlign.Leading, TTextAlign.Leading);
  Canvas.FillText(RectF(10, 25, Canvas.Width, 40), 'Currently used points: ' +
    FDisplayList.Count.ToString + ' points', False, 1, [], TTextAlign.Leading,
    TTextAlign.Leading);

  // preparing points to draw
  SetLength(Values, FDisplayList.Count);
  XStep := Canvas.Width / FDisplayList.Count;
  YCenter := Canvas.Height div 2;
  for I := 0 to FDisplayList.Count - 1 do
  begin
    Values[I].X := XStep * I;
    Values[I].Y := YCenter - FDisplayList[I];
  end;

  // setup the points aspect
  Canvas.Stroke.Thickness := 2;
  Canvas.Stroke.Color := TAlphaColorRec.Red;
  // draw the points
  DrawOpenPolygon(Canvas, Values, 1);

  // actually update the canvas
  Canvas.EndScene;
end;

procedure TMainForm.SetMaxValuesCount(const Value: Integer);
begin
  FMaxValuesCount := Value;
  pb.Repaint;
end;

procedure TMainForm.Timer1Timer(Sender: TObject);
var
  Value: Extended;
  QueueSize: Integer;
begin
  // put readed values in the display list... max FMaxValuesCount values
  while FValuesQueue.PopItem(QueueSize, Value) = wrSignaled do
    FDisplayList.Add(Value);
  // remove values from the head of the list...
  while FDisplayList.Count > FMaxValuesCount do
    FDisplayList.Delete(0);
  // RefreshGraph;
  pb.Repaint;
end;

procedure TMainForm.TrackBar1Change(Sender: TObject);
begin
  MaxValuesCount := Trunc(TrackBar1.Value);
end;

end.
