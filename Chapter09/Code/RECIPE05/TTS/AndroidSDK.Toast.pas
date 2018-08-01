unit AndroidSDK.Toast;

interface

uses
  AndroidAPI.JNIBridge,
  AndroidAPI.JNI.JavaTypes,
  AndroidAPI.JNI.GraphicsContentViewText;

type

  [JavaSignature('android/widget/Toast')]
  JToast = interface(JObject)
    ['{AC116FB8-FE4D-47E8-BEC9-96E919A01CC7}']
    procedure cancel; cdecl;
    function getDuration: Integer; cdecl;
    function getGravity: Integer; cdecl;
    function getHorizontalMargin: Single; cdecl;
    function getVerticalMargin: Single; cdecl;
    function getView: JView; cdecl;
    function getXOffset: Integer; cdecl;
    function getYOffset: Integer; cdecl;
    procedure setDuration(duration: Integer); cdecl;
    procedure setGravity(gravity: Integer; xOffset: Integer; yOffset: Integer); cdecl;
    procedure setMargin(horizontalMargin: Single; verticalMargin: Single); cdecl;
    procedure setText(resId: Integer); cdecl; overload;
    procedure setText(s: JCharSequence); cdecl; overload;
    procedure setView(view: JView); cdecl;
    procedure show; cdecl;
  end;

  JToastClass = interface(JObjectClass)
    ['{127EA3ED-B569-4DBF-9BCA-FE1491FC615E}']
    function init(context: JContext): JToast; cdecl;
    function makeText(context: JContext; resId: Integer; duration: Integer): JToast; cdecl; overload;
    function makeText(context: JContext; text: JCharSequence; duration: Integer): JToast; cdecl; overload;
  end;

  TJToast = class(TJavaGenericImport<JToastClass, JToast>)
  const
    LENGTH_LONG = 1;
    LENGTH_SHORT = 0;
  end;

{$SCOPEDENUMS ON}

type
  TToastDuration = (Short = 0, Long = 1);
  TToastPosition = (default = 0, Top = 48, Bottom = 80, Center = 17, VerticalCenter = 16, HorizontalCenter = 1);
procedure ShowToast(const AText: string; const ADuration: TToastDuration = TToastDuration.Short;
  const APosition: TToastPosition = TToastPosition.Default);

implementation

uses
  FMX.Helpers.Android, AndroidAPI.Helpers;

procedure ShowToast(const AText: string; const ADuration: TToastDuration = TToastDuration.Short;
  const APosition: TToastPosition = TToastPosition.Default);
begin
  CallInUiThread(
    procedure
    var
      Toast: JToast;
    begin
      Toast := TJToast.JavaClass.makeText(SharedActivityContext,
        StrToJCharSequence(AText), Integer(ADuration));
      if APosition <> TToastPosition.Default then
        Toast.setGravity(Integer(APosition), 0, 0);
      Toast.show();
    end);
end;

end.
