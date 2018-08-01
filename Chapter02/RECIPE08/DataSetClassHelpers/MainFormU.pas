unit MainFormU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls,
  FireDAC.Stan.StorageXML;

type
  TClassHelpersForm = class(TForm)
    FDMemTable1: TFDMemTable;
    btnSaveToCSV: TButton;
    ListBox1: TListBox;
    btnIterate: TButton;
    FDStanStorageXMLLink1: TFDStanStorageXMLLink;
    procedure FormCreate(Sender: TObject);
    procedure btnSaveToCSVClick(Sender: TObject);
    procedure btnIterateClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ClassHelpersForm: TClassHelpersForm;

implementation

{$R *.dfm}

uses
  DataSetHelpersU;

procedure TClassHelpersForm.btnSaveToCSVClick(Sender: TObject);
begin
  FDMemTable1.SaveToCSVFile('mydata.csv');
  ListBox1.Items.LoadFromFile('mydata.csv');
end;

procedure TClassHelpersForm.btnIterateClick(Sender: TObject);
var
  it: TDSIterator;
begin
  ListBox1.Clear;
  ListBox1.Items.Add(Format('%-10s %-10s %8s', ['FirstName', 'LastName',
    'EmpNo']));
  ListBox1.Items.Add(StringOfChar('-', 30));

  for it in FDMemTable1 do
  begin
    ListBox1.Items.Add(Format('%-10s %-10s %8d',
      [it.Value['FirstName'].AsString, it.S['LastName'], it.I['EmpNo']]));
  end;
end;

procedure TClassHelpersForm.FormCreate(Sender: TObject);
begin
  FDMemTable1.LoadFromFile('..\..\memorydata.xml', sfXML);
end;

end.
