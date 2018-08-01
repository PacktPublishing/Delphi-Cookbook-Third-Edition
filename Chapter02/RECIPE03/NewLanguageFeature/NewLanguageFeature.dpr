program NewLanguageFeature;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils,
  PrimeEnumU in 'PrimeEnumU.pas',
  System.Types;

procedure Main;
var
  LTotal, LNextPrime: Integer;
begin
  LTotal := 2;
  for LNextPrime in GetPrimes(3) do
    if LNextPrime < 2000000 then
      LTotal := LTotal + LNextPrime
    else
    begin
      WriteLn(LTotal.ToString);
      break;
    end;

end;

begin
  Main;
  ReadLn;

end.
