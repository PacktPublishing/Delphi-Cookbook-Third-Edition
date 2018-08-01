unit BooksModuleU;

interface

uses
  System.SysUtils, System.Classes, BookBO, System.Generics.Collections,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, Data.DB, FireDAC.Comp.Client,
  FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TBookModule = class(TDataModule)
    Conn: TFDConnection;
    updBooks: TFDUpdateSQL;
    qryBooks: TFDQuery;
  public
    procedure CreateBook(ABook: TBook);
    procedure UpdateBook(ABook: TBook);
    procedure DeleteBook(AID: Integer);
    function GetBookByID(AID: Integer): TDataSet;
    function GetBooks: TDataSet;
  end;

implementation

{$R *.dfm}

uses
  MVCFramework.FireDAC.Utils;

{ TBookModule }

procedure TBookModule.CreateBook(ABook: TBook);
var
  InsCommand: TFDCustomCommand;
begin
  InsCommand := updBooks.Commands[arInsert];
  TFireDACUtils.ObjectToParameters(InsCommand.Params, ABook, 'NEW_');
  InsCommand.Execute;
  ABook.ID := Conn.GetLastAutoGenValue('gen_book_id');
end;

procedure TBookModule.DeleteBook(AID: Integer);
var
  DelCommand: TFDCustomCommand;
begin
  DelCommand := updBooks.Commands[arDelete];
  DelCommand.ParamByName('OLD_ID').AsInteger := AID;
  DelCommand.Execute;
end;

function TBookModule.GetBookByID(AID: Integer): TDataSet;
begin
  qryBooks.Open('SELECT * FROM books WHERE ID = :ID', [AID]);
  Result := qryBooks;
end;

function TBookModule.GetBooks: TDataSet;
begin
  qryBooks.Open('SELECT * FROM books ');
  Result := qryBooks;
end;

procedure TBookModule.UpdateBook(ABook: TBook);
var
  UpdCommand: TFDCustomCommand;
begin
  UpdCommand := updBooks.Commands[arUpdate];

  TFireDACUtils.ObjectToParameters(UpdCommand.Params, ABook, 'NEW_');
  UpdCommand.Params.ParamByName('OLD_ID').AsInteger := ABook.ID;
  UpdCommand.Execute;
end;

end.
