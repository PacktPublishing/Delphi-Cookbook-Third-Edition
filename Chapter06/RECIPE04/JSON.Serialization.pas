unit JSON.Serialization;

interface

uses
  REST.JSON, System.Generics.Collections, Data.DBXJSON, System.JSON;

type
  TJSONUtils = class(TJSON)
  public
    class function ObjectsToJSONArray<T: class, constructor>
      (AList: TObjectList<T>): TJSONArray;
    class function JSONArrayToObjects<T: class, constructor>
      (AJSONArray: TJSONArray): TObjectList<T>;
  end;

implementation

uses
  System.SysUtils;

{ TJSONHelper }

class function TJSONUtils.JSONArrayToObjects<T>(AJSONArray: TJSONArray)
  : TObjectList<T>;
var
  I: Integer;
begin
  Result := TObjectList<T>.Create(True);
  try
    for I := 0 to AJSONArray.Count - 1 do
      Result.Add(TJSON.JsonToObject<T>(AJSONArray.Items[I] as TJSONObject));
  except
    FreeAndNil(Result);
    raise;
  end;
end;

class function TJSONUtils.ObjectsToJSONArray<T>(AList: TObjectList<T>)
  : TJSONArray;
var
  Item: T;
begin
  Result := TJSONArray.Create;
  try
    for Item in AList do
      Result.AddElement(TJSON.ObjectToJsonObject(Item));
  except
    FreeAndNil(Result);
    raise;
  end;
end;

end.
