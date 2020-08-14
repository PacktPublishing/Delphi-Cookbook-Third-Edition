unit ReaderThreadU;

interface

uses
  System.Classes;

type

 TReaderThread = class (TThread)
 protected
  procedure Execute;
 end;

implementation

{ TReaderThread }

procedure TReaderThread.Execute;
begin

end;

end.
