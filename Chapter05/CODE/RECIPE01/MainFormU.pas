unit MainFormU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  System.Generics.Collections, System.Classes, FileWriterThreadU;

type
  TMainForm = class(TForm)
    btnStart: TButton;
    ListBox1: TListBox;
    Timer1: TTimer;
    procedure btnStartClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Timer1Timer(Sender: TObject);
  private
    FOutputFile: TStreamWriter;
    FRunningThreads: TObjectList<TFileWriterThread>;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.btnStartClick(Sender: TObject);
var
  I: Integer;
  Th: TFileWriterThread;
begin
  for I := 1 to 10 do
  begin
    Th := TFileWriterThread.Create(FOutputFile);
    FRunningThreads.Add(Th);
  end;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
var
  Th: TFileWriterThread;
begin
  for Th in FRunningThreads do
    Th.Terminate;
  FRunningThreads.Free; // Implicit WaitFor...
  FOutputFile.Free;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FRunningThreads := TObjectList<TFileWriterThread>.Create(true);
  FOutputFile := TStreamWriter.Create(TFileStream.Create('OutputFile.txt',
    fmCreate or fmShareDenyWrite));
end;

procedure TMainForm.Timer1Timer(Sender: TObject);
var
  Th: TFileWriterThread;
begin
  ListBox1.Items.BeginUpdate;
  try
    ListBox1.Items.Clear;
    for Th in FRunningThreads do
    begin
      if Th.WaitFor(0) = WAIT_TIMEOUT then
        ListBox1.Items.Add(Format('%5d RUNNING', [Th.ThreadID]))
      else
        ListBox1.Items.Add(Format('%5d TERMINATED', [Th.ThreadID]))
    end;
  finally
    ListBox1.Items.EndUpdate;
  end;
end;

end.
