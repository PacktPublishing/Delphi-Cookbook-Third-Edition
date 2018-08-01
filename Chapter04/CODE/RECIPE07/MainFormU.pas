unit MainFormU;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics,
  FMX.Dialogs, FMX.Objects, FMX.Layouts, FMX.StdCtrls,
  FMX.Controls.Presentation,
  FMX.ScrollBox, FMX.Memo, FMX.Grid, FMX.Grid.Style, FMX.Effects,
  FMX.Filter.Effects, FMX.Ani, System.Rtti, Generics.Collections;

type
  TMainForm = class(TForm)
    lytPie: TLayout;
    btnRefreshPie: TButton;
    lblCompany: TLabel;
    sgData: TStringGrid;
    StringColumn3: TStringColumn;
    StringColumn4: TStringColumn;
    btnAddRow: TButton;
    procedure btnRefreshPieClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnAddRowClick(Sender: TObject);
  private
    FTotalValue: Extended;
    FDataDict: TDictionary<String, Extended>;
    procedure LoadData(ADataDict: TDictionary<String, Extended>);
    function BuildPieSlice(AIdentifier: String): TPie;
    procedure OnPieLeave(Sender: TObject);
    procedure OnPieEnter(Sender: TObject);
    procedure InjectEffects(AComponent: TFmxObject; ARefColor: TAlphaColor);
    procedure SetupGradient(ABrush: TBrush; ARefColor: TAlphaColor);

  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

uses ColorsUtilsU, HigherOrderFunctionsU, System.Math, Windows;

procedure TMainForm.btnAddRowClick(Sender: TObject);
begin
  sgData.RowCount := sgData.RowCount + 1;
end;

procedure TMainForm.btnRefreshPieClick(Sender: TObject);
var
  LPie: TPie;
  LCurrAngle, LGrad: Single;
  LIdx: Integer;
  LRefColor: TAlphaColor;
  LPair: TPair<String, Extended>;
begin
  // Loads the data from the string grid and put them in the
  // dictionary using the company name for the key and the
  // units sold as the value.
  LoadData(FDataDict);

  // Get the total for all the companies using an
  // higher order function
  FTotalValue := HigherOrder.Reduce<Extended>(FDataDict.Values.ToArray,
    function(A, B: Extended): Extended
    begin
      Result := A + B;
    end, 0);

  // remove all the TPie already present into the TLayout
  // The first time there aren't child, but from the second time
  // yes, so let's remove all the TPie from the TLayout
  lytPie.DeleteChildren;

  LCurrAngle := 0;
  LIdx := 0;
  lytPie.BeginUpdate;
  try
    // looping through the dictionary and create each TPie
    for LPair in FDataDict do
    begin
      // some math to know how many degree each pie slide must be
      LGrad := 360 * LPair.Value / FTotalValue;
      // Build the pie slice, che the BuildPieSlice for details
      LPie := BuildPieSlice(LPair.Key);
      LPie.StartAngle := LCurrAngle;
      LPie.EndAngle := LCurrAngle + LGrad;
      LCurrAngle := LCurrAngle + LGrad;
      LRefColor := GetColor(LIdx);
      // Setup some nice gradients color to give
      // a sort of fake 3D effect to each slice
      SetupGradient(LPie.Fill, LRefColor);
      // Let's give some dynamicity to the chart
      // with some effects
      InjectEffects(LPie, GetColor(LIdx));
      Inc(LIdx);
    end;
  finally
    lytPie.EndUpdate;
  end;
end;

function TMainForm.BuildPieSlice(AIdentifier: String): TPie;
begin
  Result := TPie.Create(lytPie);
  Result.OnMouseEnter := OnPieEnter;
  Result.OnMouseLeave := OnPieLeave;
  Result.TagString := AIdentifier;
  Result.Parent := lytPie;
  Result.Align := TAlignLayout.Contents;
end;

procedure TMainForm.OnPieEnter(Sender: TObject);
var
  LKey: String;
  LPie: TPie;
  LValue, LPercValue: Extended;
begin
  LPie := Sender as TPie;
  LPie.BringToFront;
  LKey := LPie.TagString;
  LValue := FDataDict.Items[LKey];
  LPercValue := LValue / FTotalValue * 100;
  lblCompany.Text := Format('%s (%.2f - %2.1f%%)', [LKey, LValue, LPercValue]);
end;

procedure TMainForm.OnPieLeave(Sender: TObject);
begin
  lblCompany.Text := '';
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  Randomize;
  FDataDict := TDictionary<String, Extended>.Create;
  sgData.RowCount := 5;
  sgData.BeginUpdate;
  try
    sgData.Cells[0, 0] := 'Google';
    sgData.Cells[1, 0] := RandomRange(2, 20).ToString;
    sgData.Cells[0, 1] := 'Apple';
    sgData.Cells[1, 1] := RandomRange(2, 20).ToString;
    sgData.Cells[0, 2] := 'YAHOO!';
    sgData.Cells[1, 2] := RandomRange(2, 20).ToString;
    sgData.Cells[0, 3] := 'Twitter';
    sgData.Cells[1, 3] := RandomRange(2, 20).ToString;
    sgData.Cells[0, 4] := 'Facebook';
    sgData.Cells[1, 4] := RandomRange(2, 20).ToString;
  finally
    sgData.EndUpdate;
  end;
  lblCompany.Text := '';
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  FDataDict.Free;
end;

procedure TMainForm.SetupGradient(ABrush: TBrush; ARefColor: TAlphaColor);
begin
  ABrush.Kind := TBrushKind.Gradient;
  ABrush.Gradient.Color := ARefColor;
  ABrush.Gradient.Color1 := GetDarkerColorByPercent(ARefColor, 50);
end;

procedure TMainForm.InjectEffects(AComponent: TFmxObject;
ARefColor: TAlphaColor);
var
  LEffect: TInnerGlowEffect;
  LColorAnimation: TColorAnimation;
  LBoldAnimation: TFloatAnimation;
begin
  // Glow effect when MouseOver
  LEffect := TInnerGlowEffect.Create(AComponent);
  LEffect.Enabled := False;
  LEffect.Trigger := 'IsMouseOver=True';
  LEffect.Parent := AComponent;
  LEffect.GlowColor := TAlphaColorRec.White;
  LEffect.Opacity := 0.5;
  LEffect.Softness := 0.5;

  // Stroke.Color animation when MouseOver
  LColorAnimation := TColorAnimation.Create(AComponent);
  LColorAnimation.PropertyName := 'Stroke.Color';
  LColorAnimation.Enabled := False;
  LColorAnimation.Trigger := 'IsMouseOver=True';
  LColorAnimation.TriggerInverse := 'IsMouseOver=False';
  LColorAnimation.Parent := AComponent;
  LColorAnimation.StartValue := TAlphaColorRec.Black;
  LColorAnimation.StopValue := GetLighterColorByPercent(ARefColor, 20);

  // Stroke.Thickness animation when MouseOver
  LBoldAnimation := TFloatAnimation.Create(AComponent);
  LBoldAnimation.PropertyName := 'Stroke.Thickness';
  LBoldAnimation.Enabled := False;
  LBoldAnimation.Trigger := 'IsMouseOver=True';
  LBoldAnimation.TriggerInverse := 'IsMouseOver=False';
  LBoldAnimation.Parent := AComponent;
  LBoldAnimation.StartValue := 1;
  LBoldAnimation.StopValue := 2;
end;

procedure TMainForm.LoadData(ADataDict: TDictionary<String, Extended>);
var
  I: Integer;
  LItem: String;
  LValue: Extended;
begin
  // loads data from the GUI into the dictionary
  ADataDict.Clear;
  for I := 0 to sgData.RowCount - 1 do
  begin
    LItem := sgData.Cells[0, I];
    LValue := StrToFloatDef(sgData.Cells[1, I], 0);
    ADataDict.AddOrSetValue(LItem, LValue);
  end;
end;

end.
