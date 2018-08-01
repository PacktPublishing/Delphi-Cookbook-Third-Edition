unit PersonBO;

interface

uses
  ObjectsMappers, System.SysUtils;

type
  EBLException = class(Exception)

  end;

  [MapperJSONNaming(JSONNameLowerCase)]
  TPerson = class
  private
    FWORK_PHONE_NUMBER: string;
    FEMAIL: string;
    FFIRST_NAME: string;
    FID: Integer;
    FMOBILE_PHONE_NUMBER: string;
    FLAST_NAME: string;
    procedure SetEMAIL(const Value: string);
    procedure SetFIRST_NAME(const Value: string);
    procedure SetID(const Value: Integer);
    procedure SetLAST_NAME(const Value: string);
    procedure SetMOBILE_PHONE_NUMBER(const Value: string);
    procedure SetWORK_PHONE_NUMBER(const Value: string);
  public
    procedure Validate;
    property ID: Integer read FID write SetID;
    property FIRST_NAME: string read FFIRST_NAME write SetFIRST_NAME;
    property LAST_NAME: string read FLAST_NAME write SetLAST_NAME;
    property WORK_PHONE_NUMBER: string read FWORK_PHONE_NUMBER write SetWORK_PHONE_NUMBER;
    property MOBILE_PHONE_NUMBER: string read FMOBILE_PHONE_NUMBER write SetMOBILE_PHONE_NUMBER;
    property EMAIL: string read FEMAIL write SetEMAIL;
    function ToString: String; override;
  end;

implementation

uses
  System.RegularExpressions;

{ TPerson }

procedure TPerson.SetEMAIL(const Value: string);
begin
  FEMAIL := Value;
end;

procedure TPerson.SetFIRST_NAME(const Value: string);
begin
  FFIRST_NAME := Value;
end;

procedure TPerson.SetID(const Value: Integer);
begin
  FID := Value;
end;

procedure TPerson.SetLAST_NAME(const Value: string);
begin
  FLAST_NAME := Value;
end;

procedure TPerson.SetMOBILE_PHONE_NUMBER(const Value: string);
begin
  FMOBILE_PHONE_NUMBER := Value;
end;

procedure TPerson.SetWORK_PHONE_NUMBER(const Value: string);
begin
  FWORK_PHONE_NUMBER := Value;
end;

function TPerson.ToString: String;
begin
  Result := Format('%s, %s', [FIRST_NAME, LAST_NAME]);
end;

procedure TPerson.Validate;
begin
  if not TRegEx.IsMatch(EMAIL, '^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$', [roIgnoreCase]) then
    raise EBLException.CreateFmt('Invalid email "%s"', [EMAIL]);
  if LAST_NAME.Trim.IsEmpty then
    raise EBLException.Create('Field "LastName" is required');
end;

end.
