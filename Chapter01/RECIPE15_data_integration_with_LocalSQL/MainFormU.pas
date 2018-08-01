unit MainFormU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls,
  Vcl.DBCtrls, FireDAC.Comp.BatchMove, FireDAC.Comp.BatchMove.Text,
  FireDAC.Comp.BatchMove.DataSet, FireDAC.Phys.IB, FireDAC.Phys.IBDef,
  Datasnap.DBClient, FireDAC.Phys.SQLiteVDataSet, Vcl.StdCtrls;

type
  TMainForm = class(TForm)
    FDConnection1: TFDConnection;
    DBNavigator1: TDBNavigator;
    DBGrid1: TDBGrid;
    LocalQuery: TFDQuery;
    FDLocalSQL1: TFDLocalSQL;
    CustomersCDS: TClientDataSet;
    dsLocalQuery: TDataSource;
    DelphicookbookConnection: TFDConnection;
    SalesTable: TFDQuery;
    btnExecute: TButton;
    Edit1: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure btnExecuteClick(Sender: TObject);
  private
    { Private declarations }
    procedure OpenDataSets;
    procedure CloseDataSets;
    procedure PrepareDataSets;
  public
    { Public declarations }

  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}
{ TMainForm }

procedure TMainForm.btnExecuteClick(Sender: TObject);
var
  LAmount: Integer;
begin

  // ensure amount is an integer
  if not TryStrToInt(Edit1.Text, LAmount) then
  begin
    ShowMessage('Amount must be integer...');
    exit;
  end;

  LocalQuery.Close;
  OpenDataSets;
  // apply user data
  LocalQuery.ParamByName('v').AsInteger := LAmount;
  // Execute the query through eterogeneous sources
  LocalQuery.Open;
end;

procedure TMainForm.CloseDataSets;
begin

  SalesTable.Close();
  CustomersCDS.Active := false;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  PrepareDataSets;
end;

procedure TMainForm.OpenDataSets;
begin
  SalesTable.Open();
  CustomersCDS.Active := True;
end;

procedure TMainForm.PrepareDataSets;
begin
  CustomersCDS.FileName :=
    'C:\Users\Public\Documents\Embarcadero\Studio\19.0\Samples\Data\customer.xml';
  LocalQuery.SQL.Text := 'select distinct c.* from Customers c ' +
    ' JOIN Sales s on cast (s.CUST_NO as integer) = c.CustNo ' +
    ' where s.total_value > :v order by c.CustNo ';
end;

end.
