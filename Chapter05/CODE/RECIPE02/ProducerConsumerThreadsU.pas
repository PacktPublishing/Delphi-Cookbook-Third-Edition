unit ProducerConsumerThreadsU;

interface

uses
  System.Classes, System.Generics.Collections;

type
  TReaderThread = class(TThread)
  private
    FQueue: TThreadedQueue<Byte>;
  protected
    procedure Execute; override;
  public
    constructor Create(AQueue: TThreadedQueue<Byte>);
  end;

implementation

{ TReaderThread }

constructor TReaderThread.Create(AQueue: TThreadedQueue<Byte>);
begin
  FQueue := AQueue;
  inherited Create(false);
end;

procedure TReaderThread.Execute;
begin
  while not Terminated do
  begin
    TThread.Sleep(200 + Trunc(Random(500)));
    // e.g. reading from an actual device
    FQueue.PushItem(Random(256));
  end;
end;

end.
