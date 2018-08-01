program FileRowsEnumerator;

{$APPTYPE CONSOLE}

{$R *.res}


uses
  System.SysUtils,
  FileEnumU in 'FileEnumU.pas', System.Types;

procedure Main;
var
  Row: String;
begin
  for Row in EachRows('..\..\myfile.txt') do
    WriteLn(Row);
end;

begin
  Main;
  ReadLn;

end.
