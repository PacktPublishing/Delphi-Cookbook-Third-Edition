unit CalculationCustomer_CityMall;

interface

type
  TCalculationCustomer_CityMall = class
  public
    function GetTotal(Price: Currency; Quantity: Integer; Discount: Double): Currency;
  end;

implementation

{ TCalculationCustomer_CityMall }

function TCalculationCustomer_CityMall.GetTotal(Price: Currency; Quantity: Integer; Discount: Double): Currency;
begin
  Result := (Price * Quantity) * (1 - Discount / 100);
  // 10% discount if total is greater than 1000
  if Result > 1000 then
    Result := Result * 0.90;
end;

initialization

TCalculationCustomer_CityMall.ClassName;

end.
