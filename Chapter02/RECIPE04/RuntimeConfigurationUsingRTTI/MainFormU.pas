unit MainFormU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Vcl.Mask, Vcl.DBCtrls, Datasnap.DBClient,
  System.Rtti;

type
  TMainForm = class(TForm)
    ClientDataSet1: TClientDataSet;
    ClientDataSet1PRICE: TCurrencyField;
    ClientDataSet1QUANTITY: TIntegerField;
    ClientDataSet1DISCOUNT: TFloatField;
    ClientDataSet1TOTAL: TCurrencyField;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    DataSource1: TDataSource;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    Label5: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure ClientDataSet1CalcFields(DataSet: TDataSet);
    procedure FormDestroy(Sender: TObject);
  private
    FCTX: TRttiContext;
    FCalcEngineObj: TObject;
    FCalcEngineMethod: TRttiMethod;
    procedure LoadCalculationEngine;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}


uses
  System.IOUtils;

procedure TMainForm.ClientDataSet1CalcFields(DataSet: TDataSet);
begin
  ClientDataSet1TOTAL.Value := FCalcEngineMethod.Invoke(FCalcEngineObj,
    [ClientDataSet1PRICE.Value,
    ClientDataSet1QUANTITY.Value,
    ClientDataSet1DISCOUNT.Value]).AsCurrency;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FCTX := TRttiContext.Create;
  ClientDataSet1.Insert;
  LoadCalculationEngine;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  FCalcEngineObj.Free;
  FCTX.Free;
end;

procedure TMainForm.LoadCalculationEngine;
var
  TheClassName: string;
  CalcEngineType: TRttiType;
const
  CONFIG_FILENAME = '..\..\calculation.config.txt';
begin
  if not TFile.Exists(CONFIG_FILENAME) then
    TheClassName := 'CalculationCustomerDefaultU.TCalculationCustomerDefault'
  else
    TheClassName := TFile.ReadAllLines(CONFIG_FILENAME)[0]; // read the first line of the file

  CalcEngineType := FCTX.FindType(TheClassName.Trim);
  if not assigned(CalcEngineType) then
    raise Exception.CreateFmt('Class %s not found', [TheClassName]);
  if not CalcEngineType.GetMethod('Create').IsConstructor then
    raise Exception.CreateFmt('There isn''t a parameterless constructor called Create in %s', [TheClassName]);

  FCalcEngineObj := CalcEngineType.GetMethod('Create').Invoke(CalcEngineType.AsInstance.MetaclassType, []).AsObject;
  FCalcEngineMethod := CalcEngineType.GetMethod('GetTotal');
  Label5.Caption := 'Current Calc Engine: ' + TheClassName;
end;

end.
