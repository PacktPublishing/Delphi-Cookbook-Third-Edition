program HelloMessaging;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils,
  System.Messaging;

begin

  // subscribe to a String message on the default message manager
  TMessageManager.DefaultManager.SubscribeToMessage(TMessage<String>,
    procedure(const Sender: TObject; const AMessage: TMessage)
    begin
      WriteLn('Called callback1 with value: ',
        TMessage<String>(AMessage).Value);
    end);

  // subscribe to a String message on the default message manager
  TMessageManager.DefaultManager.SubscribeToMessage(TMessage<String>,
    procedure(const Sender: TObject; const AMessage: TMessage)
    begin
      WriteLn('Called callback2 with value: ',
        TMessage<String>(AMessage).Value);
    end);

  // send a String message to the default message manager
  WriteLn('Let''s send a message to the subscribers...');
  TMessageManager.DefaultManager.SendMessage(nil,
    TMessage<String>.Create('Hello Messaging'));

  Readln; // wait for a return...

end.
