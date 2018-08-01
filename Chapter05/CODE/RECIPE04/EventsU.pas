unit EventsU;

interface

type

  TAuthenticationEvent = class(TObject)
  private
    FResult: Boolean;
    procedure SetResult(const Value: Boolean);
  public
    constructor Create(AResult: Boolean);
    property Result: Boolean read FResult write SetResult;
  end;

implementation

{ TAuthenticationEvent }

constructor TAuthenticationEvent.Create(AResult: Boolean);
begin
  inherited Create;
  Result := AResult;
end;

procedure TAuthenticationEvent.SetResult(const Value: Boolean);
begin
  FResult := Value;
end;

end.
