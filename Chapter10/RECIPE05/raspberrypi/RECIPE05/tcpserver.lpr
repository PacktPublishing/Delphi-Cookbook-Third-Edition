program tcpserver;

{$mode objfpc}{$H+}

uses {$IFDEF UNIX} {$IFDEF UseCThreads}
  cthreads, {$ENDIF} {$ENDIF}
  Classes,
  SysUtils,
  ServerU { you can add units after this };

begin
  try
    RunServer;
  except
    on E: Exception do
    begin
      WriteLn(E.Message);
    end;
  end;
end.



