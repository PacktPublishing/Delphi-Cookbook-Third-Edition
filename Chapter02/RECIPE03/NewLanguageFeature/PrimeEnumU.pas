unit PrimeEnumU;

interface

uses
  System.Classes, System.Generics.Collections;

type
  TPrimesEnumerable = record
  private
    FStart: Integer;
  public
    constructor Create(AStart: Integer);
    function GetEnumerator: TEnumerator<Integer>;
  end;

function GetPrimes(const AStart: Integer): TPrimesEnumerable;

function IsPrime(const ANumber: Integer): Boolean;

implementation

uses
  System.IOUtils;

type
  TPrimesEnumerator = class(TEnumerator<Integer>)
  private
    FCurrent: Integer;
  protected
    constructor Create(const AStart: Integer);
    function DoGetCurrent: Integer; override;
    function DoMoveNext: Boolean; override;
  end;

constructor TPrimesEnumerable.Create(AStart: Integer);
begin
  FStart := AStart;
end;

function TPrimesEnumerable.GetEnumerator: TEnumerator<Integer>;
begin
  Result := TPrimesEnumerator.Create(FStart);
end;

{ TFileEnumerator }

constructor TPrimesEnumerator.Create(const AStart: Integer);
begin
  inherited Create;
  FCurrent := AStart;
end;

function TPrimesEnumerator.DoGetCurrent: Integer;
begin
  Result := FCurrent;
end;

function TPrimesEnumerator.DoMoveNext: Boolean;
begin

  while True do
  begin
    try
      if IsPrime(FCurrent) then
        Exit(True);
    finally
      Inc(FCurrent);
    end;
  end;

end;

function GetPrimes(const AStart: Integer): TPrimesEnumerable;
begin
  Result := TPrimesEnumerable.Create(AStart);
end;

function IsPrime(const ANumber: Integer): Boolean;
var
  count: Int64;
  I: Integer;
begin

  if ANumber <= 1 then
    Exit(false);

  if ANumber = 2 then
    Exit(True);

  if (ANumber mod 2) = 0 then
    Exit(false);

  count := Trunc(Sqrt(ANumber) + 1);

  for I := 3 to count do
    if (ANumber Mod I) = 0 then
    begin
      Exit(false)
    end;

  Result := True;
end;

end.
