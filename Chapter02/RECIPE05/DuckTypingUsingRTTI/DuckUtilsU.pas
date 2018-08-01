unit DuckUtilsU;

interface

uses MainFormU, System.Generics.Collections, System.SysUtils, System.Classes,
  System.Rtti;

type
  Duck = class sealed
    class procedure Apply(ArrayOf: TArray<TObject>; PropName: string;
      PropValue: TValue;
      AcceptFunction: TFunc<TObject, boolean> = nil); overload;
    class procedure Apply(AContainer: TComponent; PropName: string;
      PropValue: TValue;
      AcceptFunction: TFunc<TObject, boolean> = nil); overload;
  end;

implementation

class procedure Duck.Apply(ArrayOf: TArray<TObject>; PropName: string;
  PropValue: TValue; AcceptFunction: TFunc<TObject, boolean>);
var
  CTX: TRttiContext;
  Item, PropObj: TObject;
  RttiType: TRttiType;
  Prop: TRttiProperty;
  PropertyPath: TArray<string>;
  i: Integer;
begin
  CTX := TRttiContext.Create;
  try
    for Item in ArrayOf do
    begin
      if (Assigned(AcceptFunction)) and (not AcceptFunction(Item)) then
        continue;

      RttiType := CTX.GetType(Item.ClassType);
      if not Assigned(RttiType) then
        continue;

      PropertyPath := PropName.Split(['.']);
      Prop := RttiType.GetProperty(PropertyPath[0]);
      if not Assigned(Prop) then
        Continue;
      PropObj := Item;
      if Prop.GetValue(PropObj).isObject then
      begin
        PropObj := Prop.GetValue(Item).AsObject;
        for i := 1 to Length(PropertyPath) - 1 do
        begin
          RttiType := CTX.GetType(PropObj.ClassType);
          Prop := RttiType.GetProperty(PropertyPath[i]);
          if not Assigned(Prop) then
            break;
          if Prop.GetValue(PropObj).isObject then
            PropObj := Prop.GetValue(PropObj).AsObject
          else
            break;
        end;
      end;
      if Assigned(Prop) and (Prop.IsWritable) then
        Prop.SetValue(PropObj, PropValue);
    end;
  finally
    CTX.Free;
  end;
end;

class procedure Duck.Apply(AContainer: TComponent; PropName: string;
  PropValue: TValue; AcceptFunction: TFunc<TObject, boolean>);
var
  Item: TComponent;
  List: TList<TObject>;
begin
  List := TList<TObject>.Create;
  try
    for Item in AContainer do
    begin
      List.Add(Item);
    end;
    Apply(List.ToArray, PropName, PropValue, AcceptFunction);
  finally
    List.Free;
  end;
end;

end.
