unit MainFormU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, ProducerConsumerThreadsU,
  System.Generics.Collections, Vcl.ExtCtrls, System.Classes;

type
  TMainForm = class(TForm)
    btnStartStop: TButton;
    Timer1: TTimer;
    ListBox1: TListBox;
    procedure btnStartStopClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    Rdr: TReaderThread;
    FQueue: TThreadedQueue<Byte>;
    procedure StopReader;
    procedure UpdateGUI;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}


uses System.SyncObjs;

const
  START_CAPTION = 'Start Thread';
  STOP_CAPTION = 'Stop Thread';

procedure TMainForm.btnStartStopClick(Sender: TObject);
begin
  if Assigned(Rdr) then
    StopReader
  else
    Rdr := TReaderThread.Create(FQueue);
  UpdateGUI;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FQueue := TThreadedQueue<Byte>.Create(100, 1000, 1);
  UpdateGUI;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  StopReader; // stops the thread if it is running
  FQueue.DoShutDown; // release all the pushes/pops
  FQueue.Free;
end;

procedure TMainForm.StopReader;
begin
  if Assigned(Rdr) then
  begin
    Rdr.Terminate;
    Rdr.WaitFor;
    FreeAndNil(Rdr);
  end;
end;

procedure TMainForm.Timer1Timer(Sender: TObject);
var
  Value: Byte;
begin
  while FQueue.PopItem(Value) = TWaitResult.wrSignaled do
  begin
    ListBox1.Items.Add(Format('[%3.3d]', [Value]));
  end;
  ListBox1.ItemIndex := ListBox1.Count - 1;
end;

procedure TMainForm.UpdateGUI;
begin
  if Assigned(Rdr) then
    btnStartStop.Caption := STOP_CAPTION
  else
    btnStartStop.Caption := START_CAPTION;
end;

end.
