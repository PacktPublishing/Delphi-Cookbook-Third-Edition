unit BookBO;

interface

uses
  System.Generics.Collections, MVCFramework.Serializer.Commons;

type

  [MVCNameCase(TMVCNameCase.ncLowerCase)]
  TBook = class(TObject)
  private
    FYEAR: Integer;
    FAUTHOR: String;
    FTITLE: String;
    FID: Integer;
    FPLOT: String;
    FNUMBER_OF_PAGES: Integer;
    procedure SetAUTHOR(const Value: String);
    procedure SetID(const Value: Integer);
    procedure SetNUMBER_OF_PAGES(const Value: Integer);
    procedure SetPLOT(const Value: String);
    procedure SetTITLE(const Value: String);
    procedure SetYEAR(const Value: Integer);
  public
    property ID: Integer read FID write SetID;
    property TITLE: String read FTITLE write SetTITLE;
    property AUTHOR: String read FAUTHOR write SetAUTHOR;
    property NUMBER_OF_PAGES: Integer read FNUMBER_OF_PAGES
      write SetNUMBER_OF_PAGES;
    property YEAR: Integer read FYEAR write SetYEAR;
    property PLOT: String read FPLOT write SetPLOT;
  end;

function GenerateRandomData: TObjectList<TBook>;

implementation

{ TBook }

procedure TBook.SetAUTHOR(const Value: String);
begin
  FAUTHOR := Value;
end;

procedure TBook.SetID(const Value: Integer);
begin
  FID := Value;
end;

procedure TBook.SetNUMBER_OF_PAGES(const Value: Integer);
begin
  FNUMBER_OF_PAGES := Value;
end;

procedure TBook.SetPLOT(const Value: String);
begin
  FPLOT := Value;
end;

procedure TBook.SetTITLE(const Value: String);
begin
  FTITLE := Value;
end;

procedure TBook.SetYEAR(const Value: Integer);
begin
  FYEAR := Value;
end;

function GenerateRandomData: TObjectList<TBook>;

  function NewBook(AID: Integer; ATitle, AAuthor: String;
    AYear, ANumberOfPages: Integer): TBook;
  begin
    Result := TBook.Create;
    Result.ID := AID;
    Result.TITLE := ATitle;
    Result.AUTHOR := AAuthor;
    Result.YEAR := AYear;
    Result.NUMBER_OF_PAGES := ANumberOfPages;
  end;

begin
  Result := TObjectList<TBook>.Create;
  Result.Add(NewBook(1, 'Divine Comedy', 'Dante Alighieri', 1321, 352));
  Result.Add(NewBook(2, 'In Search of Lost Time', 'Marcel Proust', 1908, 4500));
  Result.Add(NewBook(3, 'Ulysses', 'James Joyce', 1922, 730));
  Result.Add(NewBook(4, 'The Great Gatsby', 'F. Scott Fitzgerald', 1925, 240));
  Result.Add(NewBook(5, 'The Brothers Karamazov', '	Fyodor Dostoevsky',
    1880, 1033));

end;

end.
