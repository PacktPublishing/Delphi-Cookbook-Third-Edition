unit ValidatorU;

interface

uses
  System.RTTI;

type

  TValidationResult = record
  public
    ErrorMessage: String;
    function Validation: Boolean;
  end;

  TValidator = class(TObject)
  protected
    class var FContext: TRTTIContext;
  public
    class constructor Create;
    class function Validate(AObject: TObject; out AErrors: TArray<string>;
      AContext: String = ''): Boolean;
  end;

implementation

uses
  System.SysUtils, AttributesU;

{ TValidator }

class constructor TValidator.Create;
begin
  FContext := TRTTIContext.Create;
end;

class function TValidator.Validate(AObject: TObject;
  out AErrors: TArray<string>; AContext: String = ''): Boolean;
var
  rt: TRttiType;
  a: TCustomAttribute;
  p: TRttiProperty;
  m: TRttiMethod;
  LResult: TValidationResult;
begin
  AErrors := [];
  rt := FContext.GetType(AObject.ClassType);
  // iterate over object properties
  for p in rt.GetProperties do
    // iterate over attributes of this property
    for a in p.GetAttributes do
    begin
      // ensure that is a ValidationAttribute
      if not(a is ValidationAttribute) then
        continue;
      // reference to Validate method
      m := FContext.GetType(a.ClassType).GetMethod('Validate');
      if m = nil then
        continue;
      // check the context
      if (not AContext.IsEmpty) and
        (not ValidationAttribute(a).AcceptContext(AContext)) then
        continue;

      // invoke method
      LResult := m.Invoke(a, [p.GetValue(AObject).AsString])
        .AsType<TValidationResult>;
      // eventually add error to errors array
      if not LResult.Validation then
        AErrors := AErrors + [LResult.ErrorMessage];
    end;
  Result := Length(AErrors) = 0;
end;

{ TValidationResult }

function TValidationResult.Validation: Boolean;
begin
  Result := ErrorMessage.IsEmpty;
end;

end.
