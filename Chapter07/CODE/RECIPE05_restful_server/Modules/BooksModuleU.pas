unit BooksModuleU;

interface

uses
  System.SysUtils, System.Classes, BookBO, System.Generics.Collections;

type
  TBookModule = class(TDataModule)
  public
    procedure CreateBook(ABook: TBook);
    procedure UpdateBook(ABook: TBook);
    procedure DeleteBook(AID: Integer);
    function GetBookByID(AID: Integer): TBook;
    function GetBooks: TObjectList<TBook>;
  end;

implementation

{$R *.dfm}

var
  BooksData: TObjectList<TBook>;

  { TBookModule }

procedure TBookModule.CreateBook(ABook: TBook);
begin
  BooksData.Add(ABook);
end;

procedure TBookModule.DeleteBook(AID: Integer);
var
  LBook: TBook;
begin
  LBook := GetBookByID(AID);
  BooksData.Extract(LBook).Free;
end;

function TBookModule.GetBookByID(AID: Integer): TBook;
var
  LBook: TBook;
begin
  Result := nil;
  for LBook in BooksData do
    if LBook.ID = AID then
      Exit(LBook);
end;

function TBookModule.GetBooks: TObjectList<TBook>;
begin
  Result := BooksData;
end;

procedure TBookModule.UpdateBook(ABook: TBook);
var
  LBook: TBook;
begin
  LBook := GetBookByID(ABook.ID);

  LBook.TITLE := ABook.TITLE;
  LBook.AUTHOR := ABook.AUTHOR;
  LBook.NUMBER_OF_PAGES := ABook.NUMBER_OF_PAGES;
  LBook.YEAR := ABook.YEAR;
  LBook.PLOT := ABook.PLOT;

end;

initialization

BooksData := BookBO.GenerateRandomData;

finalization

BooksData.Free;

end.
