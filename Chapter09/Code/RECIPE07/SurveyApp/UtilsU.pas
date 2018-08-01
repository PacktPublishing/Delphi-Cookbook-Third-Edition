unit UtilsU;

interface

uses
  Androidapi.JNI.Widget;

procedure ShowToast(const Value: String);

implementation

uses
  Androidapi.Helpers, AndroidAPI.JNI.JavaTypes;

procedure ShowToast(const Value: String);
begin
  TJToast.JavaClass.makeText(TAndroidHelper.Context, StrToJCharSequence(Value),
    TJToast.JavaClass.LENGTH_SHORT).show;
end;

end.
