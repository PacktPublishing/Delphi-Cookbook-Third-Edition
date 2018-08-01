unit AttributesU;

interface

uses
  ValidatorU;

type

  ValidationAttribute = class abstract(TCustomAttribute)
  private
    FContext: String;
  protected
    FErrorMessage: string;
    function DoValidate(AValue: string): Boolean; virtual; abstract;
  public
    constructor Create(AErrorMessage: string; AContext: String = '');
    function Validate(AValue: string): TValidationResult;
    function AcceptContext(AContext: String): Boolean;
  end;

  RequiredValidationAttribute = class(ValidationAttribute)
  public
    function DoValidate(AValue: string): Boolean; override;
  end;

  MaxLengthValidationAttribute = class(ValidationAttribute)
  protected
    FLength: Integer;
  public
    constructor Create(AErrorMessage: string; ALength: Integer;
      AContext: String = '');
    function DoValidate(AValue: string): Boolean; override;
  end;

  MinLengthValidationAttribute = class(MaxLengthValidationAttribute)
  public
    function DoValidate(AValue: string): Boolean; override;
  end;

  RegexValidationAttribute = class(ValidationAttribute)
  private
    FRegex: string;
  public
    constructor Create(AErrorMessage: string; ARegex: string;
      AContext: String = '');
    function DoValidate(AValue: string): Boolean; override;
  end;

implementation

uses
  System.SysUtils, System.RegularExpressions;

{ ValidationAttribute }

function ValidationAttribute.AcceptContext(AContext: String): Boolean;
var
  LContexts: TArray<String>;
  LContext: String;
begin
  Result := False;
  LContexts := FContext.Split([';']);
  for LContext in LContexts do
    if LContext.ToLower = AContext.ToLower then
      Exit(true)
end;

constructor ValidationAttribute.Create(AErrorMessage: string;
  AContext: String = '');
begin
  FErrorMessage := AErrorMessage;
  FContext := AContext;
end;

function ValidationAttribute.Validate(AValue: string): TValidationResult;
begin
  if not DoValidate(AValue) then
    Result.ErrorMessage := FErrorMessage;
end;

{ RequiredValidationAttribute }

function RequiredValidationAttribute.DoValidate(AValue: string): Boolean;
begin
  // value cannot be empty
  Result := not AValue.IsEmpty;
end;

{ MaxLengthValidationAttribute }

constructor MaxLengthValidationAttribute.Create(AErrorMessage: string;
  ALength: Integer; AContext: String = '');
begin
  inherited Create(AErrorMessage, AContext);
  FLength := ALength;
end;

function MaxLengthValidationAttribute.DoValidate(AValue: string): Boolean;
begin
  // length of value must be less than or equal to length provided in attributes
  Result := Length(AValue) <= FLength;
end;

{ MinLengthValidationAttribute }

function MinLengthValidationAttribute.DoValidate(AValue: string): Boolean;
begin
  // length of value must be greather than or equal to length provided in attributes
  Result := Length(AValue) >= FLength;
end;

{ RegexValidationAttribute }

constructor RegexValidationAttribute.Create(AErrorMessage: string;
  ARegex: string; AContext: String = '');
begin
  inherited Create(AErrorMessage, AContext);
  FRegex := ARegex;
end;

function RegexValidationAttribute.DoValidate(AValue: string): Boolean;
begin
  // Match the value of regular expression
  Result := TRegEx.IsMatch(AValue, FRegex);
end;

end.
