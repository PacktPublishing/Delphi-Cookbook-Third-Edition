unit SmsModuleU;

interface

uses
  System.SysUtils, System.Classes, SmsBO, System.Generics.Collections;

type
  TSmsModule = class(TDataModule)
  public
    procedure Push(ASMS: TSMS);
    function Pop: TSMS;
  end;

implementation

{$R *.dfm}

var
  SMSQueue: TThreadedQueue<TSMS>;

  { TSmsModule }

procedure TSmsModule.Push(ASMS: TSMS);
begin
  SMSQueue.PushItem(ASMS);
end;

function TSmsModule.Pop: TSMS;
begin
  Result := SMSQueue.PopItem;
end;

initialization

SMSQueue := TThreadedQueue<TSMS>.Create(1000, 1000, 1000);

finalization

SMSQueue.Free;

end.
