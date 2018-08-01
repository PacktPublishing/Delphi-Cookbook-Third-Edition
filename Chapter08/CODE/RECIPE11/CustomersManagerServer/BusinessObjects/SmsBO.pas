unit SmsBO;

interface

type
  TSMS = class(TObject)
  private
    FDESTINATION: String;
    FFROM: String;
    FTEXT: String;
    procedure SetDESTINATION(const Value: String);
    procedure SetFROM(const Value: String);
    procedure SetTEXT(const Value: String);
  public
    property FROM: String read FFROM write SetFROM;
    property DESTINATION: String read FDESTINATION write SetDESTINATION;
    property TEXT: String read FTEXT write SetTEXT;
  end;

implementation

{ TSMS }

procedure TSMS.SetDESTINATION(const Value: String);
begin
  FDESTINATION := Value;
end;

procedure TSMS.SetFROM(const Value: String);
begin
  FFROM := Value;
end;

procedure TSMS.SetTEXT(const Value: String);
begin
  FTEXT := Value;
end;

end.
