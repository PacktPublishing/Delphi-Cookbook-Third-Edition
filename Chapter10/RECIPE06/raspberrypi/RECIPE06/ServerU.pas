unit ServerU;

interface

procedure RunServer;


implementation

uses
  blcksock, synsock, rpi, SysUtils;

function HandleGPIOCmd(PRaspberryPI: TRaspberryPI; PCmd: string): string;
var
  LPin: string;
  LDir, LPinI: integer;
begin
  // command accept 1 char: 'R' light bulb 1 or 'L' light bulb 2
  LPin := PCmd[1];
  // light bulb 1
  if LPin = 'R' then
    LPinI := RELAY_PIN_1
  // light bulb 2
  else if LPin = 'L' then
    LPinI := RELAY_PIN_2
  else
    exit('');

  Result := BoolToStr(PRaspberryPI.GetPIN(LPinI), '0', '1');
end;

procedure HandleClient(aSocket: TSocket; PRaspberry: TRaspberryPI);
var
  lCmd, LSS: string;
  sock: TTCPBlockSocket;
begin
  sock := TTCPBlockSocket.Create;
  try
    Sock.socket := aSocket;
    sock.GetSins;
    lCmd := Trim(Sock.RecvTerminated(60000, #13));
    if Sock.LastError <> 0 then
    begin
      Sock.SendString('error:' + sock.LastErrorDesc);
      Exit;
    end;

    // do something on the rpi
    LSS := HandleGPIOCmd(PRaspberry, lCmd);
    Sock.SendString(LSS);
    if Sock.LastError <> 0 then
    begin
      Sock.SendString('error:' + sock.LastErrorDesc);
      Exit;
    end;
  finally
    Sock.Free;
  end;
end;

procedure RunServer;
var
  ClientSock: TSocket;
  lSocket: TTCPBlockSocket;
  LRPi: TRaspberryPI;
begin
  LRPi := TRaspberryPI.Create;
  try
    // initialize GPIO
    lSocket := TTCPBlockSocket.Create;
    try
      lSocket.CreateSocket;
      lSocket.setLinger(True, 10000);
      lSocket.Bind('0.0.0.0', '8008');
      lSocket.Listen;
      while True do
      begin
        if lSocket.CanRead(1000) then
        begin
          ClientSock := lSocket.Accept;
          if lSocket.LastError = 0 then
            HandleClient(ClientSock, LRPi);
        end;
      end;
    finally
      lSocket.Free;
    end;
  finally
    LRPi.Free;
  end;
end;

end.
