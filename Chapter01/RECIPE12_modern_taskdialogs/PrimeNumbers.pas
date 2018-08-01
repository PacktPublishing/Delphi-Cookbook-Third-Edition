unit PrimeNumbers;

interface

function IsPrimeNumber(Value: Integer): Boolean;

implementation

function IsPrimeNumber(Value: Integer): Boolean;
var
  I: Integer;
begin
  Result := True;
  for I := 2 to Value - 1 do
    if Value mod I = 0 then
      Exit(False);
end;

end.
