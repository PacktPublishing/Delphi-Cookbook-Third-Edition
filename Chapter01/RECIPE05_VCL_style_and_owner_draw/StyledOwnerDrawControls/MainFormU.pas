unit MainFormU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ImgList, Vcl.Grids,
  Vcl.ExtCtrls, Vcl.Buttons, System.Generics.Collections, LampInfoU,
  System.ImageList;

type
  TMainForm = class(TForm)
    ImageList1: TImageList;
    DrawGrid1: TDrawGrid;
    pnlStyles: TPanel;
    RadioGroup1: TRadioGroup;
    pnlBottom: TPanel;
    btnSimulateProblems: TButton;
    procedure FormCreate(Sender: TObject);
    procedure DrawGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure DrawGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure RadioGroup1Click(Sender: TObject);
    procedure btnSimulateProblemsClick(Sender: TObject);
  private
    FLamps: TObjectList<TLampInfo>;
    procedure DrawImageOnCanvas(ACanvas: TCanvas; var ARect: TRect;
      ImageIndex: Integer);
    procedure DrawThemed(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
      State: TGridDrawState);
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses
  Vcl.Styles, Vcl.Themes, System.Math, Vcl.GraphUtil, ZonesU;

{$R *.dfm}

procedure TMainForm.DrawGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
  DrawThemed(Sender, ACol, ARow, Rect, State)
end;

procedure TMainForm.DrawGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  FLamps[ACol + ARow * LAMPS_FOR_EACH_ROW].ToggleState;
  DrawGrid1.Invalidate;
end;

procedure TMainForm.DrawThemed(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  LCanvas: TCanvas;
  LRect: TRect;
  LLamp: TLampInfo;
  LValue: string;
  LTextHeight: Integer;
begin
  LCanvas := (Sender as TDrawGrid).Canvas;
  LLamp := FLamps[ACol + ARow * LAMPS_FOR_EACH_ROW];
  LRect := Rect;
  if LLamp.ThereAreElectricalProblems then
    LCanvas.Brush.Color := StyleServices.GetStyleColor(scButtonHot)
  else
    LCanvas.Brush.Color := StyleServices.GetStyleColor(scWindow);
  LCanvas.FillRect(LRect);
  LRect.Inflate(-1, -1);
  if LLamp.IsOn then
  begin
    LCanvas.Brush.Color := StyleServices.GetStyleColor(scButtonPressed);
    DrawStyleEdge(LCanvas, LRect, [TElementEdge.eeSunkenInner],
      [TElementEdgeFlag.efRect]);
  end
  else
  begin
    LCanvas.Brush.Color := StyleServices.GetStyleColor(scButtonNormal);
    DrawStyleEdge(LCanvas, LRect, [TElementEdge.eeRaisedInner],
      [TElementEdgeFlag.efRect]);
  end;

  LRect.Inflate(-5, -5);
  if LLamp.ThereAreElectricalProblems then
    DrawImageOnCanvas(LCanvas, LRect, 2)
  else
  begin
    if LLamp.IsOn then
      DrawImageOnCanvas(LCanvas, LRect, 1)
    else
      DrawImageOnCanvas(LCanvas, LRect, 0);
  end;

  LRect.Left := LRect.Left + ImageList1.Width;
  LTextHeight := LCanvas.TextHeight('X');
  LCanvas.Brush.Style := bsClear;
  LValue := LLamp.ServedZone;
  LRect.Height := LTextHeight;

  LCanvas.Font.Color := StyleServices.GetStyleFontColor(sfButtonTextNormal);
  LCanvas.TextRect(LRect, LValue, [TTextFormats.tfCenter,
    TTextFormats.tfVerticalCenter]);

  if LLamp.IsOn then
  begin
    Inc(LRect.Top, LTextHeight);
    LRect.Height := LTextHeight;
    LValue := '+ ' + FormatDateTime('HH:NN:SS', LLamp.LastPowerOnTimeStamp);
    LCanvas.Font.Color := StyleServices.GetStyleFontColor(sfTextLabelHot);
    LCanvas.TextRect(LRect, LValue, [TTextFormats.tfCenter,
      TTextFormats.tfVerticalCenter]);
  end;
  if LLamp.ThereAreElectricalProblems then
  begin
    Inc(LRect.Top, LTextHeight);
    LRect.Height := LTextHeight;
    LValue := 'x ' + FormatDateTime('HH:NN:SS', LLamp.ProblemsSince);
    LCanvas.Font.Color := StyleServices.GetStyleFontColor(sfTextLabelHot);
    LCanvas.TextRect(LRect, LValue, [TTextFormats.tfCenter,
      TTextFormats.tfVerticalCenter]);
  end;
end;

procedure TMainForm.DrawImageOnCanvas(ACanvas: TCanvas; var ARect: TRect;
  ImageIndex: Integer);
begin
  ImageList1.Draw(ACanvas, ARect.Left + 4,
    ARect.Top + ((ARect.Bottom - ARect.Top) div 2) - 16, ImageIndex);
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  I: Integer;
  LStyleName: string;
begin
  RadioGroup1.Items.Clear;
  RadioGroup1.Columns := Length(TStyleManager.StyleNames);
  for LStyleName in TStyleManager.StyleNames do
    RadioGroup1.Items.Add(LStyleName);
  RadioGroup1.ItemIndex := 0;
  TStyleManager.SetStyle('Windows');

  FLamps := TObjectList<TLampInfo>.Create(True);
  for I := 1 to LAMPS_FOR_EACH_ROW * 4 do
  begin
    FLamps.Add(TLampInfo.Create(Zones[I]));
  end;

  DrawGrid1.DefaultColWidth := 128;
  DrawGrid1.DefaultRowHeight := 64;
  DrawGrid1.ColCount := LAMPS_FOR_EACH_ROW;
  DrawGrid1.RowCount := FLamps.Count div LAMPS_FOR_EACH_ROW;
end;

procedure TMainForm.RadioGroup1Click(Sender: TObject);
begin
  TStyleManager.SetStyle(RadioGroup1.Items[RadioGroup1.ItemIndex]);
end;

procedure TMainForm.btnSimulateProblemsClick(Sender: TObject);
var
  LLamp: TLampInfo;
begin
  for LLamp in FLamps do
  begin
    if LLamp.IsOn then
      LLamp.ThereAreElectricalProblems := Random(10) > 6;
  end;
  DrawGrid1.Invalidate;
end;

end.
