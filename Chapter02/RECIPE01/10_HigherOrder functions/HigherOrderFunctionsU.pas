unit HigherOrderFunctionsU;

interface

uses
  System.SysUtils;

type
  HigherOrder = class sealed
    class function Map<T>(InputArray: TArray<T>; MapFunction: TFunc<T, T>)
      : TArray<T>;
    class function Reduce<T: record >(InputArray: TArray<T>;
      ReduceFunction: TFunc<T, T, T>; InitValue: T): T;
    class function Filter<T>(InputArray: TArray<T>;
      FilterFunction: TFunc<T, boolean>): TArray<T>;
  end;

implementation

uses
  System.Generics.Collections;

{ HigherOrder }

class function HigherOrder.Filter<T>(InputArray: TArray<T>;
  FilterFunction: TFunc<T, boolean>): TArray<T>;
var
  I: Integer;
  List: TList<T>;
begin
  List := TList<T>.Create;
  try
    for I := 0 to length(InputArray) - 1 do
      if FilterFunction(InputArray[I]) then
        List.add(InputArray[I]);
    Result := List.ToArray;
  finally
    List.Free;
  end;
end;

class function HigherOrder.Map<T>(InputArray: TArray<T>;
  MapFunction: TFunc<T, T>): TArray<T>;
var
  I: Integer;
begin
  SetLength(Result, length(InputArray));
  for I := 0 to length(InputArray) - 1 do
    Result[I] := MapFunction(InputArray[I]);
end;

class function HigherOrder.Reduce<T>(InputArray: TArray<T>;
  ReduceFunction: TFunc<T, T, T>; InitValue: T): T;
var
  I: T;
begin
  Result := InitValue;
  for I in InputArray do
  begin
    Result := ReduceFunction(Result, I);
  end;
end;

end.
