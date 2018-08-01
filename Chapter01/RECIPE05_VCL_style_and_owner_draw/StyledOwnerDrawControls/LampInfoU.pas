unit LampInfoU;

interface

type
  TLampInfo = class
  private
    FIsOn: boolean;
    FServedZone: string;
    FThereAreElectricalProblems: boolean;
    FLastPowerOnTimeStamp: TTime;
    FProblemsSince: TTime;
    procedure SetThereAreElectricalProblems(const Value: boolean);
    procedure SetServedZone(const Value: string);
    procedure SetIsOn(const Value: boolean);
    procedure SetLastPowerOnTimeStamp(const Value: TTime);
    procedure SetProblemsSince(const Value: TTime);
  public
    procedure ToggleState;
    property ThereAreElectricalProblems: boolean
      read FThereAreElectricalProblems write SetThereAreElectricalProblems;
    property ServedZone: string read FServedZone write SetServedZone;
    property IsOn: boolean read FIsOn write SetIsOn;
    property LastPowerOnTimeStamp: TTime read FLastPowerOnTimeStamp
      write SetLastPowerOnTimeStamp;
    property ProblemsSince: TTime read FProblemsSince write SetProblemsSince;
    constructor Create(AServedZone: string);
  end;

const
  LAMPS_FOR_EACH_ROW = 5;

implementation

uses
  System.SysUtils;

constructor TLampInfo.Create(AServedZone: string);
begin
  inherited Create;
  FServedZone := AServedZone;
  FIsOn := False;
  FThereAreElectricalProblems := False;
end;

procedure TLampInfo.SetIsOn(const Value: boolean);
begin
  FIsOn := Value;
  if FIsOn then
    FLastPowerOnTimeStamp := Now
  else
    FLastPowerOnTimeStamp := 0;
end;

procedure TLampInfo.SetLastPowerOnTimeStamp(const Value: TTime);
begin
  FLastPowerOnTimeStamp := Value;
end;

procedure TLampInfo.SetProblemsSince(const Value: TTime);
begin
  FProblemsSince := Value;
end;

procedure TLampInfo.SetServedZone(const Value: string);
begin
  FServedZone := Value;
end;

procedure TLampInfo.SetThereAreElectricalProblems(const Value: boolean);
begin
  FThereAreElectricalProblems := Value;
  if FThereAreElectricalProblems then
    FProblemsSince := Time
  else
    FProblemsSince := 0;
end;

procedure TLampInfo.ToggleState;
begin
  IsOn := not IsOn;
end;

end.
