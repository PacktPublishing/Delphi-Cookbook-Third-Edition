unit ColorsUtilsU;

interface

uses
	System.UITypes;

function GetDarkerColorByPercent(
	AColor: TAlphaColor;
	ADarkerPercent: Integer): TAlphaColor;
function GetLighterColorByPercent(
	AColor: TAlphaColor;
	ADarkerPercent: Integer): TAlphaColor;
function GetColor(AIndex: Integer): TAlphaColor;

implementation

uses FMX.Utils;

const
	Colors: TArray<TAlphaColor> = [
		$FF4285F4,
		$FFFBBC05,
		$FF34A853,
		$FFEA4335,
		$FFA90FF4,
		$FF9F3C00];

function GetColor(AIndex: Integer): TAlphaColor;
begin
	Result := Colors[AIndex mod Length(Colors)];
end;

function GetDarkerColorByPercent(AColor: TAlphaColor; ADarkerPercent: Integer)
	: TAlphaColor;
begin
	Result := InterpolateColor(AColor, TAlphaColorRec.Black,
		ADarkerPercent / 100);
end;

function GetLighterColorByPercent(AColor: TAlphaColor; ADarkerPercent: Integer)
	: TAlphaColor;
begin
	Result := InterpolateColor(AColor, TAlphaColorRec.White,
		ADarkerPercent / 100);
end;

end.
