unit UIDeviceSDK;

interface

uses
  iOSapi.CocoaTypes, iOSapi.Foundation, Macapi.ObjectiveC;

const
  // Declared in UIDevice.h
  UIDeviceBatteryStateUnknown = 0;
  UIDeviceBatteryStateUnplugged = 1;
  UIDeviceBatteryStateCharging = 2;
  UIDeviceBatteryStateFull = 3;

  // Declared in UIDevice.h
  UIDeviceOrientation_Unknown = 0;
  UIDeviceOrientation_Portrait = 1;
  UIDeviceOrientation_PortraitUpsideDown = 2;
  UIDeviceOrientation_LandscapeLeft = 3;
  UIDeviceOrientation_LandscapeRight = 4;
  UIDeviceOrientation_FaceUp = 5;
  UIDeviceOrientation_FaceDown = 6;

type
  UIDeviceBatteryState = NSUInteger;
  UIDeviceOrientation = NSUInteger;

  UIDeviceClass = interface(NSObjectClass)
    ['{A2DCE998-BF3A-4AB0-9B8D-4182B341C9DF}']
    function currentDevice: Pointer; cdecl;
  end;

  UIDevice = interface(NSObject)
    ['{70BB371D-314A-4BA9-912E-2EF72EB0F558}']
    function batteryLevel: Single; cdecl;
    function batteryState: UIDeviceBatteryState; cdecl;
    function isBatteryMonitoringEnabled: Boolean; cdecl;
    function isMultitaskingSupported: Boolean; cdecl;
    function isProximityMonitoringEnabled: Boolean; cdecl;
    function localizedModel: NSString; cdecl;
    function model: NSString; cdecl;
    function name: NSString; cdecl;
    function orientation: UIDeviceOrientation; cdecl;
    procedure playInputClick; cdecl;
    function proximityState: Boolean; cdecl;
    function systemName: NSString; cdecl;
    function systemVersion: NSString; cdecl;
    function uniqueIdentifier: NSString; cdecl;
  end;

  TUIDevice = class(TOCGenericImport<UIDeviceClass, UIDevice>)
  end;

implementation

end.
