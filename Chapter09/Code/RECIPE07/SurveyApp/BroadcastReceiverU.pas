unit BroadcastReceiverU;

interface

uses
  Androidapi.JNIBridge,
  Androidapi.JNI.Embarcadero,
  Androidapi.JNI.GraphicsContentViewText;

type
  TMyReceiver = class(TJavaLocal, JFMXBroadcastReceiverListener)
  public
    procedure onReceive(context: JContext; intent: JIntent); cdecl;
  end;

implementation

uses
  Androidapi.Helpers,
  Androidapi.JNI.JavaTypes,
  Androidapi.JNI.Widget,
  UtilsU, ConstantsU, LogU;

procedure TMyReceiver.onReceive(context: JContext; intent: JIntent);
var
  LText: string;
begin
  if JStringToString(intent.getAction) = TSurveyConstants.SURVEY_RESPONSE_ERROR
  then
  begin
    LText := JStringToString(intent.getStringExtra(StringToJString('error')));
    LText := 'Error: ' + sLineBreak + LText;
  end
  else
  begin
    LText := JStringToString(intent.getStringExtra(StringToJString('result')));
    LText := 'Just Arrived: ' + sLineBreak + LText;
  end;
  ShowToast(LText);
  LogInfo('Broadcast Received = %s -> %s',
    [JStringToString(intent.getAction), LText], 'survey');
end;

end.
