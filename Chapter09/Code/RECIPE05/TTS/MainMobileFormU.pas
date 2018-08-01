unit MainMobileFormU;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  Androidapi.JNI.TTS, FMX.StdCtrls, FMX.Layouts, FMX.Memo, Androidapi.JNIBridge,
  IPPeerClient, IPPeerServer, IdBaseComponent, IdComponent, IdUDPBase,
  IdUDPServer, IdGlobal, IdSocketHandle, TTSListenerU, FMX.Controls.Presentation;

type
  TMainForm = class(TForm)
    Timer1: TTimer;
    IdUDPServer1: TIdUDPServer;
    Label1: TLabel;
    procedure Timer1Timer(Sender: TObject);
    procedure IdUDPServer1UDPRead(AThread: TIdUDPListenerThread;
      const AData: TIdBytes; ABinding: TIdSocketHandle);
  private
    { Private declarations }
    FTTSListener: TttsOnInitListener;
    FTTS: JTextToSpeech;
    procedure Speak(const AText: string);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}


uses
  Androidapi.JNI.JavaTypes, FMX.Helpers.Android, Androidapi.JNI.GraphicsContentViewText, Androidapi.Helpers;

constructor TMainForm.Create(AOwner: TComponent);
begin
  inherited;
  FTTSListener := TttsOnInitListener.Create(
    procedure(AInitOK: boolean)
    var
      Res: Integer;
    begin
      if AInitOK then
      begin
        Res := FTTS.setLanguage(TJLocale.JavaClass.ENGLISH);
        //Res := FTTS.setLanguage(TJLocale.JavaClass.ITALIAN);
        //Res := FTTS.setLanguage(TJLocale.JavaClass.JAPANESE);
        //Res := FTTS.setLanguage(TJLocale.JavaClass.GERMAN);
        //Res := FTTS.setLanguage(TJLocale.JavaClass.FRENCH);
        if (Res = TJTextToSpeech.JavaClass.LANG_MISSING_DATA) or
          (Res = TJTextToSpeech.JavaClass.LANG_NOT_SUPPORTED) then
          Label1.Text := 'Selected language is not supported'
        else
        begin
          Label1.Text := 'READY To SPEAK!';
          IdUDPServer1.Active := True;
        end;
      end
      else
        Label1.Text := 'Initialization Failed!';
    end);
end;

destructor TMainForm.Destroy;
begin
  if Assigned(FTTS) then
  begin
    FTTS.stop;
    FTTS.shutdown;
    FTTS := nil;
  end;
  FTTSListener := nil;
  inherited;
end;

procedure TMainForm.IdUDPServer1UDPRead(AThread: TIdUDPListenerThread;
const AData: TIdBytes; ABinding: TIdSocketHandle);
var
  bytes: TBytes;
begin
  bytes := TBytes(AData);
  Speak(TEncoding.ASCII.GetString(bytes));
end;

procedure TMainForm.Speak(const AText: string);
begin
  FTTS.Speak(StringToJString(AText), TJTextToSpeech.JavaClass.QUEUE_FLUSH, nil);
end;

procedure TMainForm.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := False;
  FTTS := TJTextToSpeech.JavaClass.init(TAndroidHelper.Context, FTTSListener);

end;

end.
