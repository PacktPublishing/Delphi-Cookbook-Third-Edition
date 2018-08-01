unit MainFormU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, WorkerThreadU,
  Vcl.AppEvnts;

type
  TMainForm = class(TForm)
    btnStart: TButton;
    btnStop: TButton;
    btnPause: TButton;
    btnContinue: TButton;
    ApplicationEvents1: TApplicationEvents;
    procedure btnStartClick(Sender: TObject);
    procedure ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
    procedure btnStopClick(Sender: TObject);
    procedure btnPauseClick(Sender: TObject);
    procedure btnContinueClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FWorkerThread: TWorkerThread;
    { Private declarations }
  public
    { Public declarations }
  end;

{$R *.dfm}


var
  MainForm: TMainForm;

implementation

procedure TMainForm.btnStartClick(Sender: TObject);
begin
  FWorkerThread := TWorkerThread.Create(true);
  FWorkerThread.Start;
end;

procedure TMainForm.ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
begin
  btnStart.Enabled := not Assigned(FWorkerThread);
  btnStop.Enabled := Assigned(FWorkerThread);
  btnPause.Enabled := Assigned(FWorkerThread) and (not FWorkerThread.IsPaused);
  btnContinue.Enabled := Assigned(FWorkerThread) and FWorkerThread.IsPaused;
end;

procedure TMainForm.btnStopClick(Sender: TObject);
begin
  FWorkerThread.Terminate;
  FWorkerThread.WaitFor;
  FreeAndNil(FWorkerThread);
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  if Assigned(FWorkerThread) then
  begin
    FWorkerThread.Terminate;
    FWorkerThread.WaitFor;
    FreeAndNil(FWorkerThread);
  end;
end;

procedure TMainForm.btnPauseClick(Sender: TObject);
begin
  FWorkerThread.Pause;
end;

procedure TMainForm.btnContinueClick(Sender: TObject);
begin
  FWorkerThread.Continue;
end;

end.
