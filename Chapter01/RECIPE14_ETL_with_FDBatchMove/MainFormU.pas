unit MainFormU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.WinXPanels, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, FireDAC.Stan.Intf,
  FireDAC.Comp.BatchMove, Vcl.ComCtrls, FireDAC.Comp.BatchMove.Text,
  FireDAC.Comp.BatchMove.DataSet, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys,
  FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.VCLUI.Wait, FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.Phys.IB,
  FireDAC.Phys.IBDef;

type
  TMainForm = class(TForm)
    FDBatchMove: TFDBatchMove;
    CustomersTable: TFDQuery;
    dsCustomers: TDataSource;
    CustomerTable: TFDQuery;
    dsCustomer: TDataSource;
    EmployeeConnection: TFDConnection;
    PageControl1: TPageControl;
    TabSheet3: TTabSheet;
    Button1: TButton;
    DBGrid2: TDBGrid;
    DBGrid3: TDBGrid;
    Panel1: TPanel;
    Panel2: TPanel;
    ComboBox1: TComboBox;
    TabSheet2: TTabSheet;
    btnResetData: TButton;
    btnOpenDatasets: TButton;
    DelphicookbookConnection: TFDConnection;
    procedure btnResetDataClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btnOpenDatasetsClick(Sender: TObject);
  private
    { Private declarations }
    procedure CloseDataSets;
    procedure OpenDataSets;
    procedure SetUpReader;
    procedure SetUpWriter;
    procedure ResetData;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses
  IOUtils;

{$R *.dfm}

procedure TMainForm.btnOpenDatasetsClick(Sender: TObject);
begin
  OpenDataSets;
end;

procedure TMainForm.btnResetDataClick(Sender: TObject);
begin
  ResetData;
end;

procedure TMainForm.Button1Click(Sender: TObject);
begin
  // ensure user make a choice
  if ComboBox1.ItemIndex = -1 then
  begin
    ShowMessage('You have to make a choice');
    exit;
  end;

  CloseDataSets;

  // Create reader
  SetUpReader;

  // Create writer
  SetUpWriter;

  // Analyze source text file structure
  FDBatchMove.GuessFormat;
  FDBatchMove.Execute;

  // show data
  OpenDataSets;

end;

procedure TMainForm.CloseDataSets;
begin
  CustomersTable.Close;
end;

procedure TMainForm.OpenDataSets;
begin
  CustomersTable.Close;
  CustomersTable.Open;
  CustomerTable.Close;
  CustomerTable.Open;
end;

procedure TMainForm.SetUpReader;
var
  LTextReader: TFDBatchMoveTextReader;
  LDataSetReader: TFDBatchMoveDataSetReader;
begin
  case ComboBox1.ItemIndex of
    0:
      begin
        // Create text reader
        // FDBatchMove will automatically manage the reader instance.
        LTextReader := TFDBatchMoveTextReader.Create(FDBatchMove);
        // Set source text data file name
        // data.txt provided with demo
        LTextReader.FileName := ExtractFilePath(Application.ExeName) +
          '..\..\data\data.txt';
        // Setup file format
        LTextReader.DataDef.Separator := ';';
        // to estabilish if first row is definition row (it is this case)
        LTextReader.DataDef.WithFieldNames := True;
      end;
    1:
      begin
        // Create text reader
        // FDBatchMove will automatically manage the reader instance.
        LDataSetReader := TFDBatchMoveDataSetReader.Create(FDBatchMove);
        // Set source dataset
        LDataSetReader.DataSet := CustomerTable;
        LDataSetReader.Optimise := False;
      end;
    2:
      begin
        LDataSetReader := TFDBatchMoveDataSetReader.Create(FDBatchMove);
        // set dataset source
        LDataSetReader.DataSet := CustomersTable;
        // because dataset will be show on ui
        LDataSetReader.Optimise := False;
      end;
  end;
end;

procedure TMainForm.SetUpWriter;
var
  LDataSetWriter: TFDBatchMoveDataSetWriter;
  LTextWriter: TFDBatchMoveTextWriter;
begin
  case ComboBox1.ItemIndex of
    0:
      begin
        // Create dataset writer and set FDBatchMode as owner. Then
        // FDBatchMove will automatically manage the writer instance.
        LDataSetWriter := TFDBatchMoveDataSetWriter.Create(FDBatchMove);
        // Set destination dataset
        LDataSetWriter.DataSet := CustomersTable;
        // because dataset will be show on ui
        LDataSetWriter.Optimise := False;
      end;
    1:
      begin
        // Create dataset writer and set FDBatchMode as owner. Then
        // FDBatchMove will automatically manage the writer instance.
        LDataSetWriter := TFDBatchMoveDataSetWriter.Create(FDBatchMove);
        // Set destination dataset
        LDataSetWriter.DataSet := CustomersTable;
        // because dataset will be show on ui
        LDataSetWriter.Optimise := False;
      end;
    2:
      begin
        LTextWriter := TFDBatchMoveTextWriter.Create(FDBatchMove);
        // set destination file
        LTextWriter.FileName := ExtractFilePath(Application.ExeName) +
          'DataOut.txt';
        // ensure to write on empty file
        if TFile.Exists(LTextWriter.FileName) then
          TFile.Delete(LTextWriter.FileName);
      end;
  end;
end;

procedure TMainForm.ResetData;
begin
  DelphicookbookConnection.ExecSQL('delete from {id CUSTOMERS}');
end;

end.
