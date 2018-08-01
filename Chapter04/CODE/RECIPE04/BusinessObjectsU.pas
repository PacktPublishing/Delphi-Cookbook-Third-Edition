unit BusinessObjectsU;

interface

uses
  System.Generics.Collections;

type
  TEmail = class
  private
    FAddress: String;
    procedure SetAddress(const Value: String);
  public
    constructor Create; overload;
    constructor Create(AEmail: String); overload;
    property Address: String read FAddress write SetAddress;
  end;

  TPerson = class
  private
    FLastName: String;
    FAge: Integer;
    FFirstName: String;
    FEmails: TObjectList<TEmail>;
    procedure SetLastName(const Value: String);
    procedure SetAge(const Value: Integer);
    procedure SetFirstName(const Value: String);
    function GetEmailsCount: Integer;
  public
    constructor Create; overload;
    constructor Create(const FirstName, LastName: string; Age: Integer);
      overload; virtual;
    destructor Destroy; override;
    property FirstName: String read FFirstName write SetFirstName;
    property LastName: String read FLastName write SetLastName;
    property Age: Integer read FAge write SetAge;
    property EmailsCount: Integer read GetEmailsCount;
    property Emails: TObjectList<TEmail> read FEmails;
  end;

implementation

uses
  System.SysUtils;

{ TPersona }

constructor TPerson.Create(const FirstName, LastName: string; Age: Integer);
begin
  Create;
  FFirstName := FirstName;
  FLastName := LastName;
  FAge := Age;
end;

// Called by LB to insert a row
constructor TPerson.Create;
begin
  inherited Create;
  FFirstName := '<name>';
  //initialize the emails list
  FEmails := TObjectList<TEmail>.Create(true);
end;

destructor TPerson.Destroy;
begin
  FEmails.Free;
  inherited;
end;

function TPerson.GetEmailsCount: Integer;
begin
  Result := FEmails.Count;
end;

procedure TPerson.SetLastName(const Value: String);
begin
  FLastName := Value;
end;

procedure TPerson.SetAge(const Value: Integer);
begin
  FAge := Value;
end;

procedure TPerson.SetFirstName(const Value: String);
begin
  FFirstName := Value;
end;

{ TEmail }

constructor TEmail.Create(AEmail: String);
begin
  inherited Create;
  FAddress := AEmail;
end;

// Called by LB to insert a row
constructor TEmail.Create;
begin
  Create('<email>');
end;

procedure TEmail.SetAddress(const Value: String);
begin
  FAddress := Value;
end;

end.
