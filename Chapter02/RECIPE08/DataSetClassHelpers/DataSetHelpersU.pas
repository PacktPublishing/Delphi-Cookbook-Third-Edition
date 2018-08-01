unit DataSetHelpersU;

interface

uses
  Data.DB, System.SysUtils, System.Generics.Collections;

type

  // This is the actual iterator
  TDSIterator = class
  private
    FDataSet: TDataSet;
    function GetValue(const FieldName: string): TField;
    function GetValueAsString(const FieldName: string): string;
    function GetValueAsInteger(const FieldName: string): Integer;
  public
    constructor Create(ADataSet: TDataSet);
    // properties to access the current record values using the fieldname
    property Value[const FieldName: string]: TField read GetValue;
    property S[const FieldName: string]: string read GetValueAsString;
    property I[const FieldName: string]: Integer read GetValueAsInteger;
  end;

  TDataSetEnumerator = class(TEnumerator<TDSIterator>)
  private
    FDataSet: TDataSet; // the current dataset
    FDSIterator: TDSIterator; // the current "position"
    FFirstTime: Boolean;
  public
    constructor Create(ADataSet: TDataSet);
    destructor Destroy; override;
  protected
    // methods to override to support the for..in loop
    function DoGetCurrent: TDSIterator; override;
    function DoMoveNext: Boolean; override;
  end;

  TDataSetHelper = class helper for TDataSet
  public
    procedure SaveToCSVFile(AFileName: string);
    function GetEnumerator: TDataSetEnumerator;
  end;

implementation

uses
  System.Classes;

{ TDataSetHelper }

function TDataSetHelper.GetEnumerator: TDataSetEnumerator;
begin
  Self.First;
  Result := TDataSetEnumerator.Create(Self);
end;

procedure TDataSetHelper.SaveToCSVFile(AFileName: string);
var
  Fields: TArray<string>;
  CSVWriter: TStreamWriter;
  I: Integer;
  CurrPos: TArray<Byte>;
begin
  // save the current dataset position
  CurrPos := Self.Bookmark;
  Self.DisableControls;
  try
    Self.First;
    // create a TStreamWriter to write the CSV file
    CSVWriter := TStreamWriter.Create(AFileName);
    try
      SetLength(Fields, Self.Fields.Count);
      for I := 0 to Self.Fields.Count - 1 do
      begin
        Fields[I] := Self.Fields[I].FieldName.QuotedString('"');
      end;

      // Write the headers line joining the fieldnames with a ";"
      CSVWriter.WriteLine(string.Join(';', Fields));

      // Cycle the dataset
      while not Self.Eof do
      begin
        for I := 0 to Self.Fields.Count - 1 do
        begin
          // DoubleQuote the string values
          case Self.Fields[I].DataType of
            ftInteger, ftWord, ftSmallint, ftShortInt, ftLargeint, ftBoolean,
              ftFloat, ftSingle:
              begin
                CSVWriter.Write(Self.Fields[I].AsString);
              end;
          else
            CSVWriter.Write(Self.Fields[I].AsString.QuotedString('"'));
          end;
          // if at the last columns, newline, otherwise ";"
          if I < Self.FieldCount - 1 then
            CSVWriter.Write(';')
          else
            CSVWriter.WriteLine;
        end;
        // next record
        Self.Next;
      end;
    finally
      CSVWriter.Free;
    end;
  finally
    Self.EnableControls;
  end;
  // return to the position where the dataset was before
  if Self.BookmarkValid(CurrPos) then
    Self.Bookmark := CurrPos;
end;

{ TDataSetEnumerator }

constructor TDataSetEnumerator.Create(ADataSet: TDataSet);
begin
  inherited Create;
  FFirstTime := True;
  FDataSet := ADataSet;
  FDSIterator := TDSIterator.Create(ADataSet);
end;

destructor TDataSetEnumerator.Destroy;
begin
  FDSIterator.Free;
  inherited;
end;

function TDataSetEnumerator.DoGetCurrent: TDSIterator;
begin
  Result := FDSIterator;
end;

function TDataSetEnumerator.DoMoveNext: Boolean;
begin
  if not FFirstTime then
    FDataSet.Next;
  FFirstTime := False;
  Result := not FDataSet.Eof;
end;

{ TDSIterator }

constructor TDSIterator.Create(ADataSet: TDataSet);
begin
  inherited Create;
  FDataSet := ADataSet;
end;

function TDSIterator.GetValue(const FieldName: string): TField;
begin
  Result := FDataSet.FieldByName(FieldName);
end;

function TDSIterator.GetValueAsInteger(const FieldName: string): Integer;
begin
  Result := GetValue(FieldName).AsInteger;
end;

function TDSIterator.GetValueAsString(const FieldName: string): string;
begin
  Result := GetValue(FieldName).AsString;
end;

end.
