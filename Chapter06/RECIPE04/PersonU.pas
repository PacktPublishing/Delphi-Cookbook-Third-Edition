unit PersonU;

interface

uses
  REST.Json.Types;

type
  TPerson = class
  private
    [JsonName('id')]
    FID: Integer;
    FEMail: String;
    FLastName: String;
    FWorkPhone: String;
    FMobilePhone: String;
    FFirstName: String;
    procedure SetEMail(const Value: String);
    procedure SetFirstName(const Value: String);
    procedure SetID(const Value: Integer);
    procedure SetLastName(const Value: String);
    procedure SetMobilePhone(const Value: String);
    procedure SetWorkPhone(const Value: String);
  public
    property ID: Integer read FID write SetID;
    property FirstName: String read FFirstName write SetFirstName;
    property LastName: String read FLastName write SetLastName;
    property WorkPhone: String read FWorkPhone write SetWorkPhone;
    property MobilePhone: String read FMobilePhone write SetMobilePhone;
    property EMail: String read FEMail write SetEMail;
  end;

implementation

{ TPerson }

procedure TPerson.SetEMail(const Value: String);
begin
  FEMail := Value;
end;

procedure TPerson.SetFirstName(const Value: String);
begin
  FFirstName := Value;
end;

procedure TPerson.SetID(const Value: Integer);
begin
  FID := Value;
end;

procedure TPerson.SetLastName(const Value: String);
begin
  FLastName := Value;
end;

procedure TPerson.SetMobilePhone(const Value: String);
begin
  FMobilePhone := Value;
end;

procedure TPerson.SetWorkPhone(const Value: String);
begin
  FWorkPhone := Value;
end;

end.
