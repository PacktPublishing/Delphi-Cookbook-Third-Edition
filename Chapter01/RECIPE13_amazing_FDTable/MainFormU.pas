unit MainFormU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, Vcl.Grids, Vcl.DBGrids,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.DBCtrls, Vcl.Menus, FireDAC.Phys.IB, FireDAC.Phys.IBDef;

type
  TMainForm = class(TForm)
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    DBNavigator1: TDBNavigator;
    PopupMenu1: TPopupMenu;
    CustomerInfoMenu: TMenuItem;
    EmployeeConnection: TFDConnection;
    SalesTable: TFDTable;
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure FormCreate(Sender: TObject);
    procedure CustomerInfoClick(Sender: TObject);
  private
    FLastColumnClickIndex: Integer;
    procedure CreateAggregates;
    procedure CreateIndexes;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.CreateAggregates;
begin
  with SalesTable.Aggregates.Add do
  begin
    Name := 'CustomerTotal';
    Expression := 'SUM(TOTAL_VALUE)';
    GroupingLevel := 1;
    Active := true;
    IndexName := 'MyCustNoIdx';

  end;

  with SalesTable.Aggregates.Add do
  begin
    Name := 'CustomerMax';
    Expression := 'MAX(TOTAL_VALUE)';
    GroupingLevel := 1;
    Active := true;
    IndexName := 'MyCustNoIdx';

  end;

  with SalesTable.Aggregates.Add do
  begin
    Name := 'CustomerLastDate';
    Expression := 'MAX(ORDER_DATE)';
    GroupingLevel := 1;
    Active := true;
    IndexName := 'MyCustNoIdx';

  end;
end;

procedure TMainForm.CreateIndexes;
var
  LCustNoIndex: TFDIndex;
begin
  LCustNoIndex := SalesTable.Indexes.Add;
  LCustNoIndex.Name := 'MyCustNoIdx';
  LCustNoIndex.Fields := 'Cust_No';
  LCustNoIndex.Active := true;
end;

procedure TMainForm.CustomerInfoClick(Sender: TObject);
var
  LOldIndexFieldNames: string;
begin

  // i use LOldIndexFieldNames to reset the index to last user choice
  LOldIndexFieldNames := SalesTable.IndexFieldNames;
  DBGrid1.Visible := false;
  // the right index for aggregate
  SalesTable.IndexName := 'MyCustNoIdx';

  // show some customer info
  ShowMessageFmt('The total value of order of this customer is %m. ' +
    'The max value order of this customer is %m. ' + 'Last order on %s ',
    [StrToFloat(SalesTable.Aggregates[0].Value),
    StrToFloat(SalesTable.Aggregates[1].Value),
    DateTimeToStr(SalesTable.Aggregates[2].Value)]);

  SalesTable.IndexFieldNames := LOldIndexFieldNames;
  DBGrid1.Visible := true;
end;

procedure TMainForm.DBGrid1TitleClick(Column: TColumn);
begin

  // if reset the column caption of LastColumnClickIndex, because index could be change...
  if FLastColumnClickIndex > 0 then
    DBGrid1.Columns[FLastColumnClickIndex].Title.Caption :=
      DBGrid1.Columns[FLastColumnClickIndex].FieldName;

  // if the order is descending set the IndexFieldNames to ''.
  if SalesTable.IndexFieldNames = (Column.Field.FieldName + ':D') then
  begin
    Column.Title.Caption := Column.Field.FieldName;
    SalesTable.IndexFieldNames := '';
  end
  // if the order is ascending set it to descending
  else if SalesTable.IndexFieldNames = Column.Field.FieldName then
  begin
    SalesTable.IndexFieldNames := Column.Field.FieldName + ':D';
    Column.Title.Caption := Column.Field.FieldName + ' ▼';
  end
  // if no order is specified I'll use ascending one
  else
  begin
    SalesTable.IndexFieldNames := Column.Field.FieldName;
    Column.Title.Caption := Column.Field.FieldName + ' ▲';
  end;

  // set last column index
  FLastColumnClickIndex := Column.Index;

end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  SalesTable.Active := false;
  CreateIndexes;
  CreateAggregates;
  SalesTable.IndexName := 'MyCustNoIdx';
  // index activated
  SalesTable.IndexesActive := true;
  // aggregates activated
  SalesTable.AggregatesActive := true;
  SalesTable.Active := true;
end;

end.
