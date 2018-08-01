unit MainFormU;

interface

uses
  Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, IPPeerClient,
  IPPeerServer, System.Tether.Manager, System.Tether.AppProfile, Vcl.StdCtrls,
  Vcl.ComCtrls, Vcl.Samples.Spin;

type
  TMainForm = class(TForm)
    tmrTime: TTimer;
    TetheringAppProfile1: TTetheringAppProfile;
    TetheringManager1: TTetheringManager;
    btnSetMinutes: TButton;
    seMinutes: TSpinEdit;
    Label1: TLabel;
    lblMinutes: TLabel;
    procedure TetheringAppProfile1ResourceReceived(const Sender: TObject;
      const AResource: TRemoteResource);
    procedure tmrTimeTimer(Sender: TObject);
    procedure btnSetMinutesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TetheringManager1PairedFromLocal(const Sender: TObject;
      const AManagerInfo: TTetheringManagerInfo);
  private
    FEndTime: TDateTime;
    procedure SendMinutesLeft;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses
  Winapi.Windows, System.DateUtils;

const
  NEXT_SLIDE = Ord(VK_RIGHT);
  PREV_SLIDE = Ord(VK_LEFT);
  DEFAULT_MINUTES = 30;

{$R *.dfm}

procedure SendKey(const C: Word);
var
  kb: TInput;
begin
  kb.Itype := INPUT_KEYBOARD;
  kb.ki.wVk := C;
  kb.ki.wScan := MapVirtualKey(C, 0);
  kb.ki.dwFlags := 0;
  SendInput(1, kb, SizeOf(kb));
  kb.ki.dwFlags := KEYEVENTF_KEYUP;
  SendInput(1, kb, SizeOf(kb));
end;

procedure TMainForm.TetheringAppProfile1ResourceReceived(const Sender: TObject;
  const AResource: TRemoteResource);
var
  Cmd: string;
begin
  Caption := AResource.Value.AsString;
  if AResource.Hint.Equals('cmd') then
  begin
    Cmd := AResource.Value.AsString;
    if Cmd.Equals('prev') then
      SendKey(PREV_SLIDE)
    else if Cmd.Equals('next') then
      SendKey(NEXT_SLIDE);
  end;
end;

procedure TMainForm.btnSetMinutesClick(Sender: TObject);
begin
  tmrTime.Enabled := False;
  FEndTime := Now + OneMinute * seMinutes.Value;
  tmrTime.Enabled := true;
  WindowState := wsMinimized;
  SendMinutesLeft;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  seMinutes.Value := DEFAULT_MINUTES;
end;

procedure TMainForm.SendMinutesLeft;
var
  MinutesLeft: String;
begin
  MinutesLeft := MinutesBetween(Now, FEndTime).ToString;
  TetheringAppProfile1.Resources.FindByName('time').Value := MinutesLeft;
  lblMinutes.Caption := MinutesLeft + ' minutes left';
end;

procedure TMainForm.TetheringManager1PairedFromLocal(const Sender: TObject;
  const AManagerInfo: TTetheringManagerInfo);
begin
  if tmrTime.Enabled then
    SendMinutesLeft;
end;

procedure TMainForm.tmrTimeTimer(Sender: TObject);
begin
  SendMinutesLeft;
end;

end.
