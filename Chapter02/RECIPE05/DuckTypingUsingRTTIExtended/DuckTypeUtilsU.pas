unit DuckTypeUtilsU;

interface

uses
  System.Rtti, System.Classes, System.SysUtils;

type
  IDuckValue = interface
    ['{392AA4C2-AE46-4387-9384-9DE418319EE6}']
    procedure ToValue(AValue: TValue);
  end;

  IDuckAction = interface
    ['{6E00572C-08C1-45F9-B8E8-676498D0D5A3}']
    function SetProperty(APropertyName: String): IDuckValue;
    function Apply(AFunc: TProc<TComponent>): IDuckAction;
  end;

  IDuckSelector = interface
    ['{DAB7AC4D-0180-4B18-89D5-1315677CEFCB}']
    function All: IDuckAction;
    function Where(Func: TFunc<TComponent, Boolean>): IDuckAction; overload;
    function Where(Clazz: TClass): IDuckAction; overload;
  end;

function Duck(AComponent: TComponent): IDuckSelector;

implementation

type
  TDuckAction = class(TInterfacedObject, IDuckAction)
  protected
    FObject: TComponent;
    FCTX: TRttiContext;
    FDuckSelector: IDuckSelector;
    FPropertyName: String;
    function SetProperty(APropertyName: string): IDuckValue;
    function Apply(AFunc: TProc<TComponent>): IDuckAction;
  end;

  TDuckValueSetter = class(TInterfacedObject, IDuckValue)
  protected
    FDuckProperty: IDuckAction;
    procedure ToValue(AValue: TValue);
  end;

  TDuckSelector = class(TInterfacedObject, IDuckSelector)
  protected
    FFunc: TFunc<TComponent, Boolean>;
    FCTX: TRttiContext;
    FObject: TComponent;
    FCollection: Boolean;
    function All: IDuckAction;
    function Where(Func: TFunc<TComponent, Boolean>): IDuckAction; overload;
    function Where(Clazz: TClass): IDuckAction; overload;
  end;

function Duck(AComponent: TComponent): IDuckSelector;
var
  CTX: TRttiContext;
begin
  CTX := TRttiContext.Create;
  Result := TDuckSelector.Create;
  TDuckSelector(Result).FCTX := CTX;
  TDuckSelector(Result).FObject := AComponent;
end;

{ TDuckAction }

function TDuckAction.Apply(AFunc: TProc<TComponent>): IDuckAction;
var
  Component: TComponent;
  P: TRttiProperty;
  Obj: TComponent;
  PropName: String;
  CTX: TRttiContext;
  CompFilter: TFunc<TComponent, Boolean>;
  M: TRttiMethod;
begin
  Obj := Self.FObject;
  CompFilter := TDuckSelector(FDuckSelector).FFunc;
  CTX := TDuckSelector(FDuckSelector).FCTX;
  if not(Obj is TComponent) then
    raise Exception.Create('Sorry, you can iterate only on TComponent classes');

  for Component in TComponent(Obj) do
    if (not Assigned(CompFilter)) or (CompFilter(Component)) then
      AFunc(Component);
  if (not Assigned(CompFilter)) or (CompFilter(Obj)) then
    AFunc(Obj);
  Result := Self;
end;

function TDuckAction.SetProperty(APropertyName: string): IDuckValue;
begin
  FPropertyName := APropertyName;
  Result := TDuckValueSetter.Create;
  TDuckValueSetter(Result).FDuckProperty := Self;
end;

{ TDuckValueSetter }

procedure TDuckValueSetter.ToValue(AValue: TValue);
var
  Component: TComponent;
  P: TRttiProperty;
  Obj: TObject;
  PropName: String;
  CTX: TRttiContext;
  CompFilter: TFunc<TComponent, Boolean>;
begin
  Obj := TDuckSelector(TDuckAction(FDuckProperty).FDuckSelector).FObject;
  PropName := TDuckAction(FDuckProperty).FPropertyName;
  CompFilter := TDuckSelector(TDuckAction(FDuckProperty).FDuckSelector).FFunc;
  CTX := TDuckAction(FDuckProperty).FCTX;
  if not(Obj is TComponent) then
    raise Exception.Create('Sorry, you can iterate only on TComponent classes');

  for Component in TComponent(Obj) do
  begin
    if (not Assigned(CompFilter)) or (CompFilter(Component)) then
      Duck(Component).All.SetProperty(PropName).ToValue(AValue);
  end;
  P := CTX.GetType(Obj.ClassType).GetProperty(PropName);
  if Assigned(P) then
    P.SetValue(Obj, AValue);
end;

{ TDuckSelector }

function TDuckSelector.All: IDuckAction;
begin
  Result := TDuckAction.Create;
  FFunc := nil;
  FCollection := True;
  TDuckAction(Result).FDuckSelector := Self;
  TDuckAction(Result).FObject := FObject;
end;

function TDuckSelector.Where(Func: TFunc<TComponent, Boolean>): IDuckAction;
begin
  Result := All;
  FFunc := Func;
end;

function TDuckSelector.Where(Clazz: TClass): IDuckAction;
begin
  Result := All;
  FFunc := function(Comp: TComponent): Boolean
    begin
      Result := Comp is Clazz;
    end;
end;

end.
