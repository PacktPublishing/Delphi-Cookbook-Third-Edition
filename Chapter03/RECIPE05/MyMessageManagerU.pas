unit MyMessageManagerU;

interface

uses
  System.Messaging;

type
  TStringMessage = class(TMessage<String>)
  end;

function MessageManager: TMessageManager;

implementation

var
  LMessageManager: TMessageManager = nil;

function MessageManager: TMessageManager;
begin
  if not Assigned(LMessageManager) then
  begin
    LMessageManager := TMessageManager.Create;
  end;
  Result := LMessageManager;
end;

initialization

finalization

LMessageManager.Free;

end.
