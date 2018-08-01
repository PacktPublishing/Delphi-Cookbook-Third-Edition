unit ServerMethodsUnit1;

interface

uses System.SysUtils, System.Classes, System.Json,
    Datasnap.DSServer, Datasnap.DSAuth, DataSnap.DSProviderDataModuleAdapter,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.IB, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Phys.IBDef, FireDAC.VCLUI.Wait, MVCFramework.Serializer.JSON,
  MVCFramework.Serializer.Commons;

type
{$METHODINFO ON}
  TServerMethods1 = class(TDataModule)
    FDConnection1: TFDConnection;
    FDQuery1: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    FSerializer: TMVCJSONSerializer;
    { Private declarations }
  public
    { Public declarations }
    function EchoString(Value: string): string;
    function ReverseString(Value: string): string;
    function GetEmployees: TJSONArray;
  end;
{$METHODINFO OFF}

implementation


{$R *.dfm}


uses System.StrUtils, MVCFramework.DataSet.Utils;

procedure TServerMethods1.DataModuleCreate(Sender: TObject);
begin
  FSerializer := TMVCJSONSerializer.Create;
end;

function TServerMethods1.EchoString(Value: string): string;
begin
  Result := Value;
end;

function TServerMethods1.GetEmployees: TJSONArray;
var
  JObj: TJSONObject;
begin
  FDQuery1.Open('SELECT * FROM PEOPLE');
  Result := TJSONArray.Create;
  while not FDQuery1.Eof do
  begin
    JObj := TJSONObject.Create;
    FSerializer.DataSetToJSONObject(FDQuery1, JObj, TMVCNameCase.ncAsIs, []);
    Result.Add(JObj);
    FDQuery1.Next;
  end;
  FDQuery1.AsJSONArray;
end;

function TServerMethods1.ReverseString(Value: string): string;
begin
  Result := System.StrUtils.ReverseString(Value);
end;

end.

