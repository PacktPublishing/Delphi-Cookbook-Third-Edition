unit MyThreadU;

interface

uses
  System.Classes, System.SyncObjs;

type
  TMyThread = class(TThread)
  private
    FEvent: TEvent;
    FData: Integer;
  protected
    procedure Execute; override;
  public
    constructor Create(AEvent: TEvent);
    destructor Destroy; override;
    property Event: TEvent read FEvent;
    function GetData: Integer;
  end;

implementation

uses System.sysutils;
{ TMyThread }

constructor TMyThread.Create(AEvent: TEvent);
begin
  FEvent := AEvent;
  inherited Create(False);
end;

destructor TMyThread.Destroy;
begin
  FreeAndNil(FEvent);
  inherited;
end;

procedure TMyThread.Execute;
begin
  TThread.Sleep(2000 + Random(4000));
  FData := Random(1000);
  FEvent.SetEvent;
end;

function TMyThread.GetData: Integer;
begin
  Result := FData;
end;

end.
