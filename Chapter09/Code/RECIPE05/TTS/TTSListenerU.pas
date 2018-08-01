unit TTSListenerU;

interface

uses
  System.SysUtils, Androidapi.JNI.TTS, Androidapi.JNIBridge;

type
  TttsOnInitListener = class(TJavaLocal, JTextToSpeech_OnInitListener)
  private
    FCallback: TProc<boolean>;
  public
    constructor Create(ACallback: TProc<boolean>);
    procedure onInit(status: Integer); cdecl;
  end;

implementation

{ TForm1.TttsOnInitListener }

constructor TttsOnInitListener.Create(ACallback: TProc<boolean>);
begin
  inherited Create;
  FCallback := ACallback;
end;

procedure TttsOnInitListener.onInit(status: Integer);
begin
  if assigned(FCallback) then
    FCallback(status = TJTextToSpeech.JavaClass.SUCCESS);
end;

end.
