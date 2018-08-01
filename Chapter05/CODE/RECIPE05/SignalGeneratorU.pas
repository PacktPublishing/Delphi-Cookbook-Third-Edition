unit SignalGeneratorU;

interface

uses
  System.Classes, System.Generics.Collections;

type
  TSignalGeneratorThread = class(TThread)
  private
    FQueue: TThreadedQueue<Extended>;
  protected
    procedure Execute; override;
  public
    constructor Create(AQueue: TThreadedQueue<Extended>);
  end;

implementation

{ TSignalGeneratorThread }

constructor TSignalGeneratorThread.Create(AQueue: TThreadedQueue<Extended>);
begin
  FQueue := AQueue;
  inherited Create(False);
end;

procedure TSignalGeneratorThread.Execute;
var
  Value: Extended;
begin
  inherited;
  Value := 0;
  while not Terminated do
  begin
    TThread.Sleep(10);
    FQueue.PushItem(Sin(Value) * 100);
    Value := Value + 0.05;
    if Value >= 360 then
      Value := 0;
  end;
end;

end.
