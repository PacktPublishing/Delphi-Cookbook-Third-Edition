unit CalculationCustomerDefaultU;

interface

type
  TCalculationCustomerDefault = class
  public
    function GetTotal(Price: Currency; Quantity: Integer; Discount: Double): Currency;
  end;

implementation

{ TCalculationCustomer1 }

function TCalculationCustomerDefault.GetTotal(Price: Currency; Quantity: Integer; Discount: Double): Currency;
begin
  // plain calculation
  Result := (Price * Quantity) * (1 - Discount / 100);
end;

{ TCalculationCustomer2 }

initialization

TCalculationCustomerDefault.ClassName;

end.
