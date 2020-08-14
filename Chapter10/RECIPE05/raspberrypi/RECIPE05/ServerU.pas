unit ServerU;

interface

procedure RunServer;


implementation

uses
  blcksock, synsock, rpi,
  SysUtils;

procedure InitializeGPIO(PRaspberryPI: TRaspberryPI);
begin
  PRaspberryPI.UnExport([RELAY_PIN_1, RELAY_PIN_2]);
  PRaspberryPI.SetPINDirection(RELAY_PIN_1, TGPIODirection.dirOUTPUT);
  PRaspberryPI.SetPINDirection(RELAY_PIN_2, TGPIODirection.dirOUTPUT);
  PRaspberryPI.SetPIN(RELAY_PIN_1, True);
  PRaspberryPI.SetPIN(RELAY_PIN_2, True);
end;

function HandleGPIOCmd(PRaspberryPI: TRaspberryPI; PCmd: string): string;
var
  LPin: string;
  LDir, LPinI: integer;
begin
  // command accept 2 chars: PIN and Direction ex. R1, L1, R0.
  LPin := PCmd[1];
  // light bulb 1
  if LPin = 'R' then
    LPinI := RELAY_PIN_1
  // ligh bulb 2
  else if LPin = 'L' then
    LPinI := RELAY_PIN_2
  else
    exit('');

  LDir := StrToInt(PCmd[2]);
  PRaspberryPI.SetPIN(LPinI, LDir > 0);
  exit('ok');
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
    InitializeGPIO(LRPi);
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
