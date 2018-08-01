unit MainFormU;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, System.JSON,
  Androidapi.JNI.JavaTypes,
  Androidapi.Helpers,
  Androidapi.JNI.GraphicsContentViewText,
  System.Android.Service,
  BroadcastReceiverU,
  Androidapi.JNI.Embarcadero, Androidapi.JNIBridge, FMX.EditBox, FMX.SpinBox,
  FMX.Layouts, FMX.Edit, System.Actions, FMX.ActnList;

type
  TMainForm = class(TForm)
    Button1: TButton;
    EditFirstName: TEdit;
    EditLastName: TEdit;
    Layout1: TLayout;
    SwitchOption1: TSwitch;
    Layout2: TLayout;
    SwitchOption2: TSwitch;
    Label1: TLabel;
    Label2: TLabel;
    Layout3: TLayout;
    SpinBoxAge: TSpinBox;
    Label3: TLabel;
    ActionList1: TActionList;
    actSendSurvey: TAction;
    procedure FormCreate(Sender: TObject);
    procedure actSendSurveyExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FMyListener: TMyReceiver;
    FBroadcastReceiver: JFMXBroadcastReceiver;
    procedure StartService(const AServiceName: string; const AIntent: JIntent);
  public
    procedure SendSurveyInterview(ASurveyData: TJSONObject);
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

uses ConstantsU;

procedure TMainForm.actSendSurveyExecute(Sender: TObject);
var
  LJSurvey: TJSONObject;
begin
  LJSurvey := TJSONObject.Create;
  LJSurvey.AddPair('first_name', EditFirstName.Text);
  LJSurvey.AddPair('last_name', EditLastName.Text);
  LJSurvey.AddPair('option1', TJSONBool.Create(SwitchOption1.IsChecked));
  LJSurvey.AddPair('option2', TJSONBool.Create(SwitchOption2.IsChecked));
  LJSurvey.AddPair('age', TJSONNumber.Create(SpinBoxAge.Value));
  SendSurveyInterview(LJSurvey);
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  Filter: JIntentFilter;
begin
  FMyListener := TMyReceiver.Create;
  FBroadcastReceiver := TJFMXBroadcastReceiver.JavaClass.init(FMyListener);
  Filter := TJIntentFilter.JavaClass.init;
  Filter.addAction(StringToJString(TSurveyConstants.SURVEY_RESPONSE));
  Filter.addAction(StringToJString(TSurveyConstants.SURVEY_RESPONSE_ERROR));
  TAndroidHelper.Context.registerReceiver(FBroadcastReceiver, Filter);
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  TAndroidHelper.Context.getApplicationContext.unregisterReceiver
    (FBroadcastReceiver);
end;

procedure TMainForm.SendSurveyInterview(ASurveyData: TJSONObject);
var
  LIntent: JIntent;
begin
  LIntent := TJIntent.Create;
  LIntent.putExtra(StringToJString('data'),
    StringToJString(ASurveyData.ToJSON));
  StartService('MySurveyService', LIntent);
end;

procedure TMainForm.StartService(const AServiceName: string;
  const AIntent: JIntent);
var
  LService: string;
begin
  LService := AServiceName;
  if not LService.StartsWith('com.embarcadero.services.') then
    LService := 'com.embarcadero.services.' + LService;
  AIntent.setClassName(TAndroidHelper.Context.getPackageName(),
    TAndroidHelper.StringToJString(LService));
  TAndroidHelper.Context.StartService(AIntent);
end;

end.
