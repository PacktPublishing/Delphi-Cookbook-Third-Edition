unit rpi;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

const
  RELAY_PIN_1: integer = 17;
  RELAY_PIN_2: integer = 18;
  LED_PIN_1: integer = 20;
  LED_PIN_2: integer = 21;

type
  TGPIODirection = (dirINPUT, dirOUTPUT);

  { TRaspberryPI }

  TRaspberryPI = class
  private
    FExportedPINs: array of integer;
    FSetupDelay: word;
    procedure SetSetupDelay(AValue: word);
  protected
    procedure UnExport; virtual; overload;
    procedure ExportPIN(const PIN: integer);
  public
    procedure UnExport(inputs : array of Integer); overload;
    procedure SetPIN(const PIN: integer; const Status: boolean);
    function GetPIN(const PIN: integer): boolean;
    procedure SetPINDirection(const PIN: integer; const Direction: TGPIODirection);
    property SetupDelay: word read FSetupDelay write SetSetupDelay;
    constructor Create; virtual;
    destructor Destroy; override;
  end;




implementation

uses
  Unix, BaseUnix;

const
  PIN_ON: PChar = '1';
  PIN_OFF: PChar = '0';

procedure TRaspberryPI.SetPINDirection(const PIN: integer;
  const Direction: TGPIODirection);
var
  lPIN: string;
  lFile: integer;
begin
  ExportPIN(PIN);
  Sleep(FSetupDelay); //otherwise we cannot set the direction
  lPIN := IntToStr(PIN);
  lFile := fpopen('/sys/class/gpio/gpio' + lPIN + '/direction', O_WrOnly);
  try
    case Direction of
      dirINPUT:
      begin
        if fpwrite(lFile, PChar('in'), 2) = -1 then
          raise Exception.Create('Cannot setup ' + lPIN + ' as input');
      end;
      dirOUTPUT:
      begin
        if fpwrite(lFile, PChar('out'), 3) = -1 then
          raise Exception.Create('Cannot setup ' + lPIN + ' as output');
      end
      else
        raise Exception.Create('Invalid Direction');
    end;
  finally
    fpclose(lFile);
  end;

  SetLength(FExportedPINs, Length(FExportedPINs) + 1);
  FExportedPINs[Length(FExportedPINs) - 1] := PIN;
end;

constructor TRaspberryPI.Create;
begin
  inherited Create;
  SetupDelay := 500;
  SetLength(FExportedPINs, 0);
end;

destructor TRaspberryPI.Destroy;
begin
  UnExport;
  inherited Destroy;
end;

procedure TRaspberryPI.SetSetupDelay(AValue: word);
begin
  if FSetupDelay = AValue then
    Exit;
  FSetupDelay := AValue;
end;

procedure TRaspberryPI.UnExport;
var
  i, lPIN: integer;
  lFile: integer;
begin
  for i := 0 to Length(FExportedPINs) - 1 do
  begin
    try
      lFile := fpopen('/sys/class/gpio/unexport', O_WrOnly);
      try
        lPIN := FExportedPINs[i];
        fpwrite(lFile, PChar(IntToStr(lPIN)), 2);
      finally
        fpclose(lFile);
      end;
    except
    end;
  end;
end;

procedure TRaspberryPI.ExportPIN(const PIN: integer);
var
  lFile: integer;
begin
  lFile := fpopen('/sys/class/gpio/export', O_WrOnly);
  try
    if fpwrite(lFile, PChar(IntToStr(PIN)), 2) = -1 then
      raise Exception.CreateFmt('Cannot export PIN%d', [PIN]);
  finally
    fpclose(lFile);
  end;
end;

procedure TRaspberryPI.UnExport(inputs: array of Integer);
var
  i, lPIN: integer;
  lFile: integer;
begin
  for i := 0 to Length(inputs) - 1 do
  begin
    try
      lFile := fpopen('/sys/class/gpio/unexport', O_WrOnly);
      try
        lPIN := inputs[i];
        fpwrite(lFile, PChar(IntToStr(lPIN)), 2);
      finally
        fpclose(lFile);
      end;
    except
    end;
  end;
end;

procedure TRaspberryPI.SetPIN(const PIN: integer; const Status: boolean);
var
  fileDesc: integer;
  lValueToWrite: PChar;
  lRetCode: integer;
begin
  fileDesc := fpopen('/sys/class/gpio/gpio' + IntToStr(PIN) + '/value', O_WrOnly);
  try
    if Status then
      lValueToWrite := PIN_ON
    else
      lValueToWrite := PIN_OFF;
    lRetCode := fpwrite(fileDesc, lValueToWrite, 1);
    if lRetCode = -1 then
      raise Exception.Create('Cannot write to the GPIO sysfs descriptor');
  finally
    fpclose(fileDesc);
  end;
end;

function TRaspberryPI.GetPIN(const PIN: integer): boolean;
var
  lFile: integer;
  lRetCode: integer;
  lStatus: string[1] = '1';
begin
  lFile := fpopen('/sys/class/gpio/gpio' + IntToStr(PIN) + '/value', O_RdOnly);
  try
    if lFile > 0 then
    begin
      { Read status of this pin (0: button pressed, 1: button released): }
      lRetCode := fpread(lFile, lStatus[1], 1);
      Result := lStatus = '1';
    end
    else
      raise Exception.CreateFmt('Cannot read from PIN%d', [PIN]);
  finally
    fpclose(lFile);
  end;
end;


end.
