unit MainFormU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.SyncObjs, System.Generics.Collections,
  MyThreadU, Vcl.ExtCtrls;

type
  TMainForm = class(TForm)
    btnStart: TButton;
    Timer1: TTimer;
    ListBox1: TListBox;
    procedure FormCreate(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    Handles: THandleObjectArray;
    FThreads: TObjectList<TMyThread>;
    function AreThereThreadsStillRunning: Boolean;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}


function TMainForm.AreThereThreadsStillRunning: Boolean;
var
  H: THandleObject;
begin
  Result := TEvent.WaitForMultiple(Handles, 1, True, H) = TWaitResult.wrTimeout;
end;

procedure TMainForm.btnStartClick(Sender: TObject);
var
  i: Integer;
  Evt: TEvent;
begin
  if (FThreads.Count > 0) and AreThereThreadsStillRunning then
  begin
    ShowMessage('Please wait, there are threads still running');
    Exit;
  end;
  FThreads.Clear;
  for i := 0 to High(Handles) do
  begin
    Evt := TEvent.Create;
    Handles[i] := Evt;
    FThreads.Add(TMyThread.Create(Evt));
  end;
  ListBox1.Items.Add('Threads running');
  Timer1.Enabled := True;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := not ((FThreads.Count > 0) and AreThereThreadsStillRunning);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FThreads := TObjectList<TMyThread>.Create(True);
  SetLength(Handles, 5);
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  FThreads.Free;
end;

procedure TMainForm.Timer1Timer(Sender: TObject);
var
  th: TMyThread;
begin
  if not AreThereThreadsStillRunning then
  begin
    Timer1.Enabled := False;
    ListBox1.Items.Add('All threads terminated');
    for th in FThreads do
    begin
      ListBox1.Items.Add(Format('Th %4.4d = %4d', [th.ThreadID, th.GetData]));
    end;
  end;
end;

end.
