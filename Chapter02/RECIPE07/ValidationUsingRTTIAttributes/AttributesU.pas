unit AttributesU;

interface

uses
  ValidatorU;

type

  ValidationAttribute = class abstract(TCustomAttribute)
  protected
    FErrorMessage: string;
    function DoValidate(AValue: string): Boolean; virtual; abstract;
  public
    constructor Create(AErrorMessage: string);
    function Validate(AValue: string): TValidationResult;
  end;

  RequiredValidationAttribute = class(ValidationAttribute)
  public
    function DoValidate(AValue: string): Boolean; override;
  end;

  MaxLengthValidationAttribute = class(ValidationAttribute)
  protected
    FLength: Integer;
  public
    constructor Create(AErrorMessage: string; ALength: Integer);
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
    constructor Create(AErrorMessage: string; ARegex: string);
    function DoValidate(AValue: string): Boolean; override;
  end;

implementation

uses
  System.SysUtils, System.RegularExpressions;

{ ValidationAttribute }

constructor ValidationAttribute.Create(AErrorMessage: string);
begin
  FErrorMessage := AErrorMessage;
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
  ALength: Integer);
begin
  inherited Create(AErrorMessage);
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

constructor RegexValidationAttribute.Create(AErrorMessage, ARegex: string);
begin
  inherited Create(AErrorMessage);
  FRegex := ARegex;
end;

function RegexValidationAttribute.DoValidate(AValue: string): Boolean;
begin
  // Match the value of regular expression
  Result := TRegEx.IsMatch(AValue, FRegex);
end;

end.
