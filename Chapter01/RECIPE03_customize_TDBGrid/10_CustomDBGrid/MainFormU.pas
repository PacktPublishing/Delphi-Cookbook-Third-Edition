unit MainFormU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.DBCtrls,
  Vcl.Imaging.pngimage, Vcl.ImgList, System.ImageList;

type
  TMainForm = class(TForm)
    FDMemTable1: TFDMemTable;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    FDMemTable1FullName: TStringField;
    FDMemTable1TotalExams: TIntegerField;
    FDMemTable1PassedExams: TIntegerField;
    FDMemTable1PercPassedExams: TFloatField;
    FDMemTable1MoreThan50Percent: TBooleanField;
    DBNavigator1: TDBNavigator;
    FDMemTable1Rating: TFloatField;
    ImageList1: TImageList;
    procedure FormCreate(Sender: TObject);
    procedure FDMemTable1CalcFields(DataSet: TDataSet);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses Vcl.GraphUtil;

{$R *.dfm}

procedure TMainForm.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  LRect: TRect;
  LGrid: TDBGrid;
  LText: string;
  LPerc: Extended;
  LTextWidth: TSize;
  LRating: Extended;
  LNeedOwnerDraw: Boolean;
  LImageIndex: Int64;
begin
  LGrid := TDBGrid(Sender);
  if [gdSelected, gdFocused] * State <> [] then
    LGrid.Canvas.Brush.Color := clHighlight;

  LNeedOwnerDraw := (Column.Field.FieldKind = fkCalculated) or
    Column.FieldName.Equals('Rating');

  // if doesn't need owner draw, default draw is called
  if not LNeedOwnerDraw then
  begin
    LGrid.DefaultDrawColumnCell(Rect, DataCol, Column, State);
    exit;
  end;

  LRect := Rect;

  if Column.FieldName.Equals('PercPassedExams') then
  begin
    LText := FormatFloat('##0', Column.Field.AsFloat) + ' %';
    LGrid.Canvas.Brush.Style := bsSolid;
    LGrid.Canvas.FillRect(LRect);
    LPerc := Column.Field.AsFloat / 100 * LRect.Width;
    LGrid.Canvas.Font.Size := LGrid.Font.Size - 1;
    LGrid.Canvas.Font.Color := clWhite;
    LGrid.Canvas.Brush.Color := clYellow;
    LGrid.Canvas.RoundRect(LRect.Left, LRect.Top, Trunc(LRect.Left + LPerc),
      LRect.Bottom, 2, 2);
    LRect.Inflate(-1, -1);
    LGrid.Canvas.Pen.Style := psClear;
    LGrid.Canvas.Font.Color := clBlack;
    LGrid.Canvas.Brush.Style := bsClear;

    LTextWidth := LGrid.Canvas.TextExtent(LText);
    LGrid.Canvas.TextOut(LRect.Left + ((LRect.Width div 2) -
      (LTextWidth.cx div 2)), LRect.Top + ((LRect.Height div 2) -
      (LTextWidth.cy div 2)), LText);
  end
  else if Column.FieldName.Equals('MoreThan50Percent') then
  begin
    LGrid.Canvas.Brush.Style := bsSolid;
    LGrid.Canvas.Pen.Style := psClear;
    LGrid.Canvas.FillRect(LRect);
    if Column.Field.AsBoolean then
    begin
      LRect.Inflate(-4, -4);
      LGrid.Canvas.Pen.Color := clRed;
      LGrid.Canvas.Pen.Style := psSolid;
      DrawCheck(LGrid.Canvas, TPoint.Create(LRect.Left,
        LRect.Top + LRect.Height div 2), LRect.Height div 3);
    end;
  end
  else if Column.FieldName.Equals('Rating') then
  begin
    LRating := Column.Field.AsFloat;
    if Frac(LRating) < 0.5 then
      LRating := Trunc(LRating)
    else
      LRating := Trunc(LRating) + 0.5;
    LText := LRating.ToString;
    LGrid.Canvas.Brush.Color := clWhite;
    LGrid.Canvas.Brush.Style := bsSolid;
    LGrid.Canvas.Pen.Style := psClear;
    LGrid.Canvas.FillRect(LRect);
    Inc(LRect.Left);
    LImageIndex := Trunc(LRating) * 2;
    if Frac(LRating) >= 0.5 then
      Inc(LImageIndex);
    ImageList1.Draw(LGrid.Canvas, LRect.CenterPoint.X -
      (ImageList1.Width div 2), LRect.CenterPoint.Y - (ImageList1.Height div 2),
      LImageIndex);
  end;

end;

procedure TMainForm.FDMemTable1CalcFields(DataSet: TDataSet);
var
  LPassedExams: Integer;
  LTotExams: Integer;
begin
  LPassedExams := FDMemTable1.FieldByName('PassedExams').AsInteger;
  LTotExams := FDMemTable1.FieldByName('TotalExams').AsInteger;
  if LTotExams = 0 then
    FDMemTable1.FieldByName('PercPassedExams').AsFloat := 0
  else
    FDMemTable1.FieldByName('PercPassedExams').AsFloat := LPassedExams /
      LTotExams * 100;

  FDMemTable1.FieldByName('MoreThan50Percent').AsBoolean :=
    FDMemTable1.FieldByName('PercPassedExams').AsFloat > 50;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FDMemTable1.AppendRecord(['Ludwig van Beethoven', 30, 10, 4]);
  FDMemTable1.AppendRecord(['Johann Sebastian Bach', 24, 10, 2.5]);
  FDMemTable1.AppendRecord(['Wolfgang Amadeus Mozart', 30, 30, 5]);
  FDMemTable1.AppendRecord(['Giacomo Puccini', 25, 10, 2.2]);
  FDMemTable1.AppendRecord(['Antonio Vivaldi', 20, 20, 4.7]);
  FDMemTable1.AppendRecord(['Giuseppe Verdi', 30, 5, 5]);
  FDMemTable1.AppendRecord(['John Doe', 24, 5, 1.2]);
end;

end.
