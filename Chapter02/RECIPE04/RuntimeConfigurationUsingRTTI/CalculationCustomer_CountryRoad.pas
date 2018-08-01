unit CalculationCustomer_CountryRoad;

interface

type
  TCalculationCustomer_CountryRoad = class
  public
    function GetTotal(Price: Currency; Quantity: Integer; Discount: double): Currency;
  end;

implementation

function TCalculationCustomer_CountryRoad.GetTotal(Price: Currency; Quantity: Integer; Discount: double): Currency;
begin
  if Quantity > 10 then
    if Discount < 50 then
      Discount := 50;
  Result := (Price * Quantity) * (1 - Discount / 100);
end;

initialization

TCalculationCustomer_CountryRoad.ClassName;

end.
