unit MainFormU;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.Layouts,
  FMX.Memo,
  FMX.Platform,
  FMX.StdCtrls, System.Actions, FMX.ActnList, FMX.StdActns,
  FMX.MediaLibrary.Actions, FMX.Controls.Presentation, FMX.ScrollBox;

type
  TMainForm = class(TForm)
    Memo1: TMemo;
    ToolBar1: TToolBar;
    Label1: TLabel;
    ActionList1: TActionList;
    ShowShareSheetAction1: TShowShareSheetAction;
    GridLayout1: TGridLayout;
    Button2: TButton;
    Button1: TButton;
    Button3: TButton;
    Button6: TButton;
    Button5: TButton;
    Button4: TButton;
    CheckBox1: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDeactivate(Sender: TObject);
  private
    FLoggingService: IFMXLoggingService;
    FSubscrID: Integer;
    procedure LogEvent(Msg: string);
    procedure DoRealignGrid;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

uses SecondFormU, System.Messaging;

{ TForm11 }

procedure TMainForm.Button1Click(Sender: TObject);
begin
  ShowMessage('Hello World!');
end;

procedure TMainForm.Button2Click(Sender: TObject);
begin
  TSecondForm.Create(self).Show;
end;

procedure TMainForm.Button4Click(Sender: TObject);
begin
  LogEvent(StringOfChar('-', 30));
end;

procedure TMainForm.Button5Click(Sender: TObject);
begin
  Memo1.Lines.Clear;
end;

procedure TMainForm.Button6Click(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.DoRealignGrid;
begin
  GridLayout1.ItemWidth := GridLayout1.Width / 2; // - GridLayout1.Margins.Left;
end;

procedure TMainForm.FormActivate(Sender: TObject);
begin
  LogEvent('Event FormActivate');
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  LogEvent('Event FormClose');
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  LogEvent('Event FormCloseQuery');
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  TPlatformServices.Current.SupportsPlatformService(IFMXLoggingService,
    IInterface(FLoggingService));

  FSubscrID := TMessageManager.DefaultManager.SubscribeToMessage
    (TApplicationEventMessage,
    procedure(const Sender: TObject; const Msg: TMessage)
    var
      AppEvent: TApplicationEventMessage;
    begin
      AppEvent := TApplicationEventMessage(Msg);
      case AppEvent.Value.Event of
        TApplicationEvent.FinishedLaunching:
          LogEvent('App Finished Launching');
        TApplicationEvent.BecameActive:
          LogEvent('App Became Active');
        TApplicationEvent.WillBecomeInactive:
          LogEvent('App Will Become Inactive');
        TApplicationEvent.EnteredBackground:
          LogEvent('App Entered Background');
        TApplicationEvent.WillBecomeForeground:
          LogEvent('App Will Become Foreground');
        TApplicationEvent.WillTerminate:
          LogEvent('App Will Terminate');
        TApplicationEvent.LowMemory:
          LogEvent('App Low Memory');
        TApplicationEvent.TimeChange:
          LogEvent('App Time Change');
        TApplicationEvent.OpenURL:
          LogEvent('App Open URL');
      end;
    end);

  LogEvent('Event FormCreate');
end;

procedure TMainForm.FormDeactivate(Sender: TObject);
begin
  LogEvent('Event FormDeactivate');
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  LogEvent('Event FormDestroy');
  TMessageManager.DefaultManager.Unsubscribe(TApplicationEventMessage,
    FSubscrID, True);
end;

procedure TMainForm.FormHide(Sender: TObject);
begin
  LogEvent('Event FormHide');
end;

procedure TMainForm.FormResize(Sender: TObject);
begin
  DoRealignGrid;
  LogEvent('Event FormResize');
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  DoRealignGrid;
  LogEvent('Event FormShow');
end;

procedure TMainForm.LogEvent(Msg: string);
begin
  if (not CheckBox1.IsChecked) and Msg.StartsWith('event', True) then
    Exit;
  Memo1.Lines.Add(Format('%s: %s', [TimeToStr(Now), Msg]));
  Memo1.GoToTextEnd;
  if Assigned(FLoggingService) then
    FLoggingService.Log('LifeCycle: %s', [Msg]);
end;

end.
