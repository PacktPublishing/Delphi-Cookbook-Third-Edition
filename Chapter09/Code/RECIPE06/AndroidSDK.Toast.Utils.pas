unit AndroidSDK.Toast.Utils;

interface

{$SCOPEDENUMS ON}

type
  TToastDuration = (Short = 0, Long = 1);
  TToastPosition = (default = 0, Top = 48, Bottom = 80, Center = 17,
    VerticalCenter = 16, HorizontalCenter = 1);
procedure ShowToast(const AText: string;
  const ADuration: TToastDuration = TToastDuration.Short;
  const APosition: TToastPosition = TToastPosition.Default);

implementation

uses
  FMX.Helpers.Android, AndroidAPI.Helpers, AndroidSDK.Java2OP.Toast,
  AndroidAPI.JNI.JavaTypes;

procedure ShowToast(const AText: string;
  const ADuration: TToastDuration = TToastDuration.Short;
  const APosition: TToastPosition = TToastPosition.Default);
var
  Toast: JToast;
begin
  Toast := TJToast.JavaClass.makeText(TAndroidHelper.Context,
    StrToJCharSequence(AText), Integer(ADuration));
  if APosition <> TToastPosition.Default then
    Toast.setGravity(Integer(APosition), 0, 0);
  Toast.show();
end;

end.
