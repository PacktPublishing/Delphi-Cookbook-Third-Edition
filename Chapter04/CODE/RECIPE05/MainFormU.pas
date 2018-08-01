unit MainFormU;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.Objects, Generics.Collections;

type
  TMainForm = class(TForm)
    PathValues: TPath;
    Timer1: TTimer;
    PathAxis: TPath;
    Panel1: TPanel;
    Panel2: TPanel;
    PathValues2: TPath;
    PathAxis2: TPath;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    FValuesQueue: TList<Integer>;
    procedure RefreshGraph;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}


procedure TMainForm.FormCreate(Sender: TObject);
var
  I: Integer;
  svggrid: string;
begin
  FValuesQueue := TList<Integer>.Create;
  for I := 0 to 19 do
    FValuesQueue.Add(0);

  svggrid := '';
  for I := 0 to FValuesQueue.Count - 1 do
    svggrid := svggrid + ' M' + I.ToString + ',0 V100';
  for I := 1 to 10 do
    svggrid := svggrid + ' M0,' + IntToStr(I * 10) + ' H20';
  PathAxis.Data.Data := svggrid;
  PathAxis2.Data.Data := svggrid;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  FValuesQueue.Free;
end;

procedure TMainForm.RefreshGraph;
var
  I: Integer;
  svg: string;
begin
  svg := 'M0,100 ';
  if FValuesQueue.Count > 19 then
  begin
    svg := svg + 'L0,' + (100 - FValuesQueue.First).ToString;
    FValuesQueue.Delete(0);
  end;

  for I := 0 to FValuesQueue.Count - 1 do
  begin
    svg := svg + ' L' + I.ToString + ',' + (100 - FValuesQueue[I]).ToString;
  end;

  svg := svg + ' L' + IntToStr(FValuesQueue.Count - 1) + ' 100 ';
  PathValues.Data.Data := svg;
  PathValues2.Data.Data := svg;
end;

procedure TMainForm.Timer1Timer(Sender: TObject);
begin
  FValuesQueue.Add(Trunc(Random * 100));
  RefreshGraph;
end;

end.
