unit MainFormU;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, Androidapi.JNI.Net, System.Generics.Collections, FMX.Layouts,
  FMX.ListBox, FMX.Controls.Presentation;

type
  TMainForm = class(TForm)
    Header: TToolBar;
    Footer: TToolBar;
    HeaderLabel: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    ListBox1: TListBox;
    btnSTT: TButton;
    GridPanelLayout1: TGridPanelLayout;
    btnWebSite: TButton;
    btnMaps: TButton;
    Label3: TLabel;
    btnEmailEx: TButton;
    btnTwitter: TButton;
    btnEmail: TButton;
    procedure btnWebSiteClick(Sender: TObject);
    procedure btnTwitterClick(Sender: TObject);
    procedure btnEmailClick(Sender: TObject);
    procedure btnMapsClick(Sender: TObject);
    procedure btnSTTClick(Sender: TObject);
    procedure btnEmailExClick(Sender: TObject);
  private
    procedure LaunchViewIntent(AURI: string; AEncodeURL: boolean = true);
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses
  System.Messaging,
  FMX.Helpers.Android,
  Androidapi.Helpers,
  AndroidSDK.Toast, Androidapi.JNI.GraphicsContentViewText,
  Androidapi.JNI.JavaTypes, idURI,
  FMX.Platform.Android, Androidapi.JNI.App, Androidapi.JNIBridge;

{$R *.fmx}


procedure TMainForm.LaunchViewIntent(AURI: string; AEncodeURL: boolean);
var
  Intent: JIntent;
  URI: JString;
begin
  if AEncodeURL then
    AURI := TIdURI.URLEncode(AURI);
  Intent := TJIntent.Create;
  Intent.setAction(TJIntent.JavaClass.ACTION_VIEW);
  URI := StringToJString(AURI);
  Intent.setData(TJnet_Uri.JavaClass.parse(URI));
  TAndroidHelper.Context.startActivity(Intent);
end;

procedure TMainForm.btnSTTClick(Sender: TObject);
var
  Intent: JIntent;
  ReqCode: Integer;
const
  STT_REQUEST = 1001;
  ACTION_RECOGNIZE_SPEECH = 'android.speech.action.RECOGNIZE_SPEECH';
  EXTRA_LANGUAGE_MODEL = 'android.speech.extra.LANGUAGE_MODEL';
  EXTRA_RESULTS = 'android.speech.extra.RESULTS';
begin
  ReqCode := STT_REQUEST;
  Intent := TJIntent.Create;
  Intent.setAction(StringToJString(ACTION_RECOGNIZE_SPEECH));
  Intent.putExtra(StringToJString(EXTRA_LANGUAGE_MODEL), StringToJString('en-US'));

  TMessageManager.DefaultManager.SubscribeToMessage(
    TMessageResultNotification,
    procedure(const Sender: TObject; const Message: TMessage)
    var
      M: TMessageResultNotification;
      i: Integer;
      Words: JArrayList;
      TheWord: string;
    begin
      M := TMessageResultNotification(message);
      if M.RequestCode = ReqCode then
      begin
        if (M.ResultCode = TJActivity.JavaClass.RESULT_OK) then
        begin
          Words := M.Value.getStringArrayListExtra(StringToJString(EXTRA_RESULTS));
          ListBox1.Clear;
          if Words.size > 0 then
          begin
            ListBox1.BeginUpdate;
            try
              for i := 0 to Words.size - 1 do
              begin
                TheWord := JStringToString(JString(Words.get(i)));
                ListBox1.Items.Add(TheWord);
              end;
            finally
              ListBox1.EndUpdate;
            end;
          end
          else
            ShowToast('Some problems occurred');
        end
        else
          ShowToast('Nothing to recognise');
      end;
    end);

  TAndroidHelper.Activity.startActivityForResult(Intent, ReqCode);
end;

procedure TMainForm.btnWebSiteClick(Sender: TObject);
begin
  LaunchViewIntent('http://www.danielespinetti.it');
end;

procedure TMainForm.btnEmailExClick(Sender: TObject);
var
  Intent: JIntent;
  AddressesTo, AddressesCC, AddressesBCC: TJavaObjectArray<JString>;
begin
  Intent := TJIntent.Create;
  Intent.setAction(TJIntent.JavaClass.ACTION_SENDTO);
  Intent.setData(TJnet_Uri.JavaClass.parse(StringToJString('mailto:')));
  AddressesTo := TJavaObjectArray<JString>.Create(2);
  AddressesTo.Items[0] := StringToJString('d.spinetti@bittime.it');
  AddressesTo.Items[1] := StringToJString('john.doe@nowhere.com');

  AddressesCC := TJavaObjectArray<JString>.Create(1);
  AddressesCC.Items[0] := StringToJString('jane.doe@nowhere.com');

  AddressesBCC := TJavaObjectArray<JString>.Create(1);
  AddressesBCC.Items[0] := StringToJString('secret007@icannotsayit.co.uk');

  Intent.putExtra(TJIntent.JavaClass.EXTRA_EMAIL, AddressesTo);
  Intent.putExtra(TJIntent.JavaClass.EXTRA_CC, AddressesCC);
  Intent.putExtra(TJIntent.JavaClass.EXTRA_BCC, AddressesBCC);
  Intent.putExtra(TJIntent.JavaClass.EXTRA_SUBJECT, StringToJString('Greetings from Italy'));
  Intent.putExtra(TJIntent.JavaClass.EXTRA_TEXT,
    StringToJString('I''m learning how to use Android Intents!' + sLineBreak +
    'They are very powerful!' + sLineBreak + sLineBreak + 'See you...'));
  TAndroidHelper.Activity.startActivity(Intent);
end;

procedure TMainForm.btnMapsClick(Sender: TObject);
begin
  LaunchViewIntent('geo://0,0?q=Piazza del Colosseo 1,00184 Roma');
end;

procedure TMainForm.btnEmailClick(Sender: TObject);
begin
  LaunchViewIntent('mailto:d.spinetti@bittime.it', false);
end;

procedure TMainForm.btnTwitterClick(Sender: TObject);
begin
  LaunchViewIntent('http://twitter.com/spinettaro');
end;

end.
