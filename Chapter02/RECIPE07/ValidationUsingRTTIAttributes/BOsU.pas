unit BOsU;

interface

uses
  AttributesU;

type

  TCustomer = class(TObject)
  private
    FEmail: String;
    FLastname: String;
    FPassword: String;
    FFirstname: String;
    procedure SetEmail(const Value: String);
    procedure SetFirstname(const Value: String);
    procedure SetLastname(const Value: String);
    procedure SetPassword(const Value: String);
  public
    [RequiredValidation('Firstname cannot be blank...')]
    [MinLengthValidationAttribute
      ('Firstname must have a length between 4 and 15 characters', 4)]
    [MaxLengthValidationAttribute
      ('Firstname must have a length between 4 and 15 characters', 15)]
    property Firstname: String read FFirstname write SetFirstname;
    [RequiredValidation('Lastname cannot be blank...')]
    [MinLengthValidationAttribute
      ('Lastname must have a length between 4 and 15 characters', 4)]
    [MaxLengthValidationAttribute
      ('Lastname must have a length between 4 and 15 characters', 15)]
    property Lastname: String read FLastname write SetLastname;
    [RequiredValidation('Email cannot be blank...')]
    [RegexValidation('The value does not seem to be a correct email...',
      '^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      ]
    property Email: String read FEmail write SetEmail;
    [RequiredValidation('Password cannot be blank...')]
    [RegexValidation('The value does not respect password criteria...',
      '^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$')]
    property Password: String read FPassword write SetPassword;
  end;

implementation

{ TCustomer }

procedure TCustomer.SetEmail(const Value: String);
begin
  FEmail := Value;
end;

procedure TCustomer.SetFirstname(const Value: String);
begin
  FFirstname := Value;
end;

procedure TCustomer.SetLastname(const Value: String);
begin
  FLastname := Value;
end;

procedure TCustomer.SetPassword(const Value: String);
begin
  FPassword := Value;
end;

end.
