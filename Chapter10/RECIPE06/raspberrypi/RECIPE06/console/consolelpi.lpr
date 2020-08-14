program consolelpi;

{$mode objfpc}{$H+}

uses {$IFDEF UNIX} {$IFDEF UseCThreads}
  cthreads, {$ENDIF} {$ENDIF}
  rpi, Classes;

var
  LRPI: TRaspberryPI;

begin

  LRPI := TRaspberryPI.Create;

  LRPI.UnExport([RELAY_PIN_1, RELAY_PIN_2]);
  LRPI.SetPINDirection(RELAY_PIN_1, TGPIODirection.dirOUTPUT);
  LRPI.SetPINDirection(RELAY_PIN_2, TGPIODirection.dirOUTPUT);
  LRPI.SetPIN(RELAY_PIN_1, True);
  LRPI.SetPIN(RELAY_PIN_2, True);

  while True do
  begin

    // insert a delay
    TThread.Sleep(2000);

    // turn light bulb 1 ON
    LRPI.SetPIN(RELAY_PIN_1, False);
    TThread.Sleep(5000);

    // turn light bulb 1 OFF
    LRPI.SetPIN(RELAY_PIN_1, True);
    TThread.Sleep(5000);

    // turn light bulb 2 ON
    LRPI.SetPIN(RELAY_PIN_2, False);
    TThread.Sleep(5000);

    // turn light bulb 2 ON
    LRPI.SetPIN(RELAY_PIN_2, True);
    TThread.Sleep(5000);

  end;

end.




