unit BoolToStringConverterU;

interface

uses System.Classes, System.SysUtils, Data.DB, Data.Bind.Components,
  System.Bindings.Helper, System.Generics.Collections;

implementation

uses System.Bindings.EvalProtocol, System.Rtti, System.Bindings.Outputs;

const
  sBoolToString = 'BoolToString';

procedure RegisterOutputConversions;
begin
  TValueRefConverterFactory.UnRegisterConversion(TypeInfo(Boolean),
    TypeInfo(String));
  TValueRefConverterFactory.RegisterConversion(TypeInfo(Boolean),
    TypeInfo(String), TConverterDescription.Create(
    procedure(const InValue: TValue; var OutValue: TValue)
    begin
      if InValue.AsBoolean then
        OutValue := '1'
      else
        OutValue := '0';
    end, sBoolToString, sBoolToString, '', True, sBoolToString, nil));
end;

procedure UnregisterOutputConversions;
begin
  TValueRefConverterFactory.UnRegisterConversion(TypeInfo(Boolean),
    TypeInfo(String));
end;

initialization

// comment the following line to see the exception "EDatabaseError"
RegisterOutputConversions;

finalization

UnregisterOutputConversions;

end.
