unit MainFormU;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation;

type
  TMainForm = class(TForm)
    Header: TToolBar;
    Footer: TToolBar;
    HeaderLabel: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

uses FMX.Helpers.android, Androidapi.Helpers, AndroidSDK.Toast.Utils,
  Androidapi.JNI.GraphicsContentViewText, AndroidSDK.Java2OP.Toast,
  Androidapi.JNI.JavaTypes;

procedure TMainForm.Button1Click(Sender: TObject);
begin
  // This code now is deprecated
  // see http://docwiki.embarcadero.com/RADStudio/Tokyo/en/What%27s_New - Other Firemonkey changes
  CallInUiThread(
    procedure
    var
      Toast: JToast;
    begin
      Toast := TJToast.JavaClass.makeText(TAndroidHelper.Context,
        StrToJCharSequence('Hello World'), TJToast.JavaClass.LENGTH_SHORT);
      Toast.show();
    end);
end;

procedure TMainForm.Button2Click(Sender: TObject);
begin
  ShowToast('Hello Toast World');
end;

procedure TMainForm.Button3Click(Sender: TObject);
var
  Toast: JToast;
begin
  Toast := TJToast.JavaClass.makeText(TAndroidHelper.Context,
    StrToJCharSequence('Hello World'), TJToast.JavaClass.LENGTH_SHORT);
  Toast.show();
end;

procedure TMainForm.Button4Click(Sender: TObject);
begin
  ShowToast('Hello Toast World', TToastDuration.Long);
end;

procedure TMainForm.Button5Click(Sender: TObject);
begin
  ShowToast('Hello Toast World', TToastDuration.Long, TToastPosition.Center);
end;

end.
