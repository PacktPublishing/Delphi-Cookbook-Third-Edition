unit CalculationCustomer_Spark;

interface

type
  TCalculationCustomer_Spark = class
  public
    function GetTotal(Price: Currency; Quantity: Integer; Discount: Double): Currency;
  end;

implementation

uses
  System.dateutils, System.SysUtils;

{ TCalculationCustomer2 }

function TCalculationCustomer_Spark.GetTotal(Price: Currency; Quantity: Integer; Discount: Double): Currency;
begin
  Result := (Price * Quantity) * (1 - Discount / 100);
  // 50% discount if in weekend
  if DayOfTheWeek(Date) in [1, 7] then
    Result := Result * 0.50;
end;

initialization

TCalculationCustomer_Spark.ClassName;

end.
