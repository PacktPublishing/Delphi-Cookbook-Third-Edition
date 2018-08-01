unit MainFormU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    btnGenerateJSON: TButton;
    btnModifyJSON: TButton;
    btnParseJSON: TButton;
    procedure btnParseJSONClick(Sender: TObject);
    procedure btnModifyJSONClick(Sender: TObject);
    procedure btnGenerateJSONClick(Sender: TObject);
  private
    procedure SetJSON(const Value: string);
    function GetJSON: string;
  public
    property JSON: string read GetJSON write SetJSON;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  System.JSON {WAS "Data.DBXJSON" in Delphi XE5};

type
  TCarInfo = (Manufacturer = 1, name = 2, Currency = 3, Price = 4);

var
  Cars: array [1 .. 4] of array [Manufacturer .. Price] of string = (
    (
      'Ferrari',
      '360 Modena',
      'EUR',
      '250000'
    ),
    (
      'Ford',
      'Mustang',
      'USD',
      '80000'
    ),
    (
      'Lamborghini',
      'Countach',
      'EUR',
      '300000'
    ),
    (
      'Chevrolet',
      'Corvette',
      'USD',
      '100000'
    )
  );

procedure TForm1.btnGenerateJSONClick(Sender: TObject);
var
  i: Integer;
  JSONCars: TJSONArray;
  Car, Price: TJSONObject;
begin
  JSONCars := TJSONArray.Create;
  try
    for i := low(Cars) to high(Cars) do
    begin
      Car := TJSONObject.Create;
      JSONCars.AddElement(Car);
      Car.AddPair('manufacturer', Cars[i][TCarInfo.Manufacturer]);
      Car.AddPair('name', Cars[i][TCarInfo.Name]);
      Price := TJSONObject.Create;
      Car.AddPair('price', Price);
      Price.AddPair('value', TJSONNumber.Create(Cars[i][TCarInfo.Price]
        .ToInteger));
      Price.AddPair('currency', Cars[i][TCarInfo.Currency]);
    end;
    JSON := JSONCars.ToJSON;
  finally
    JSONCars.Free;
  end;
end;

procedure TForm1.btnModifyJSONClick(Sender: TObject);
var
  JSONCars: TJSONArray;
  Car, Price: TJSONObject;
begin
  JSONCars := TJSONObject.ParseJSONValue(JSON) as TJSONArray;
  if not Assigned(JSONCars) then
    raise Exception.Create('Not a valid JSON');
  try
    Car := TJSONObject.Create;
    JSONCars.AddElement(Car);
    Car.AddPair('manufacturer', 'Hennessey');
    Car.AddPair('name', 'Venom GT');
    Price := TJSONObject.Create;
    Car.AddPair('price', Price);
    Price.AddPair('value', TJSONNumber.Create(600000));
    Price.AddPair('currency', 'USD');
    JSON := JSONCars.ToJSON;
  finally
    JSONCars.Free;
  end;
end;

procedure TForm1.btnParseJSONClick(Sender: TObject);
var
  JSONCars: TJSONArray;
  i: Integer;
  Car, JSONPrice: TJSONObject;
  CarPrice: Double;
  s, CarName, CarManufacturer, CarCurrencyType: string;
begin
  s := '';
  JSONCars := TJSONObject.ParseJSONValue(JSON) as TJSONArray;
  if not Assigned(JSONCars) then
    raise Exception.Create('Not a valid JSON');
  try
    for i := 0 to JSONCars.Count - 1 do
    begin
      Car := JSONCars.Items[i] as TJSONObject;
      CarName := Car.GetValue('name').Value;
      CarManufacturer := Car.GetValue('manufacturer').Value;
      JSONPrice := Car.GetValue('price') as TJSONObject;
      CarPrice := (JSONPrice.GetValue('value') as TJSONNumber).AsDouble;
      CarCurrencyType := JSONPrice.GetValue('currency').Value;
      s := s + Format('Name = %s' + sLineBreak + 'Manufacturer = %s' +
        sLineBreak + 'Price = %.0n%s' + sLineBreak + '-----' + sLineBreak,
        [CarName, CarManufacturer, CarPrice, CarCurrencyType]);
    end;
    JSON := s;
  finally
    JSONCars.Free;
  end;
end;

function TForm1.GetJSON: string;
begin
  Result := Memo1.Lines.Text;

end;

procedure TForm1.SetJSON(const Value: string);
begin
  Memo1.Lines.Text := Value;
end;

end.
