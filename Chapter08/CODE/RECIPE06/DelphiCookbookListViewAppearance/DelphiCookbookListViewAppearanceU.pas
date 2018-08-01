unit DelphiCookbookListViewAppearanceU;

interface

uses System.Types, FMX.ListView, FMX.ListView.Types, FMX.ListView.Appearances,
  System.Classes, System.SysUtils,
  FMX.Types, FMX.Controls, System.UITypes, FMX.MobilePreview;

type

  TDelphiCookbookAppearanceNames = class
  public const
    ListItem = 'DelphiCookbookWeatherAppearance';
    MinTemp = 'mintemp';
    MaxTemp = 'maxtemp';
  end;

implementation

type
  TDelphiCookbookItemAppearance = class(TPresetItemObjects)
  public const
    DEFAULT_HEIGHT = 40;
  private
    FMinTemp: TTextObjectAppearance;
    FMaxTemp: TTextObjectAppearance;
    procedure SetMinTemp(const Value: TTextObjectAppearance);
    procedure SetMaxTemp(const Value: TTextObjectAppearance);
  protected
    function DefaultHeight: Integer; override;
    procedure UpdateSizes(const FinalSize: TSizeF); override;
    function GetGroupClass: TPresetItemObjects.TGroupClass; override;
  public
    constructor Create(const Owner: TControl); override;
    destructor Destroy; override;
  published
    property Accessory;
    property Text;
    property MinTemp: TTextObjectAppearance read FMinTemp write SetMinTemp;
    property MaxTemp: TTextObjectAppearance read FMaxTemp write SetMaxTemp;
  end;

const
  MIN_TEMP_MEMBER = 'MinTemp';
  MAX_TEMP_MEMBER = 'MaxTemp';

constructor TDelphiCookbookItemAppearance.Create(const Owner: TControl);
var
  LInitTextObject: TProc<TTextObjectAppearance>;
begin
  inherited;
  LInitTextObject := procedure(pTextObject: TTextObjectAppearance)
    begin
      pTextObject.OnChange := ItemPropertyChange;
      pTextObject.DefaultValues.Align := TListItemAlign.Leading;
      pTextObject.DefaultValues.VertAlign := TListItemAlign.Center;
      pTextObject.DefaultValues.TextVertAlign := TTextAlign.Center;
      pTextObject.DefaultValues.TextAlign := TTextAlign.Trailing;
      pTextObject.DefaultValues.PlaceOffset.Y := 0;
      pTextObject.DefaultValues.PlaceOffset.X := 0;
      pTextObject.DefaultValues.Width := 80;
      pTextObject.DefaultValues.Visible := True;
      pTextObject.RestoreDefaults;
      pTextObject.Owner := Self;
    end;

  FMinTemp := TTextObjectAppearance.Create;
  FMinTemp.Name := TDelphiCookbookAppearanceNames.MinTemp;
  FMinTemp.DefaultValues.TextColor := TAlphaColorRec.Blue;
  LInitTextObject(FMinTemp);

  FMaxTemp := TTextObjectAppearance.Create;
  FMaxTemp.Name := TDelphiCookbookAppearanceNames.MaxTemp;
  FMaxTemp.DefaultValues.TextColor := TAlphaColorRec.Red;
  LInitTextObject(FMaxTemp);

  // Define livebindings members
  FMinTemp.DataMembers := TObjectAppearance.TDataMembers.Create
    (TObjectAppearance.TDataMember.Create(MIN_TEMP_MEMBER,
    // Displayed by LiveBindings
    Format('Data["%s"]', [TDelphiCookbookAppearanceNames.MinTemp])));
  // Expression to access value from TListViewItem

  FMaxTemp.DataMembers := TObjectAppearance.TDataMembers.Create
    (TObjectAppearance.TDataMember.Create(MAX_TEMP_MEMBER,
    // Displayed by LiveBindings
    Format('Data["%s"]', [TDelphiCookbookAppearanceNames.MaxTemp])));
  // Expression to access value from TListViewItem

  // Define the appearance objects
  AddObject(Text, True);
  AddObject(MinTemp, True);
  AddObject(MaxTemp, True);
end;

function TDelphiCookbookItemAppearance.DefaultHeight: Integer;
begin
  Result := DEFAULT_HEIGHT;
end;

destructor TDelphiCookbookItemAppearance.Destroy;
begin
  FMinTemp.Free;
  FMaxTemp.Free;
  inherited;
end;

procedure TDelphiCookbookItemAppearance.SetMinTemp
  (const Value: TTextObjectAppearance);
begin
  FMinTemp.Assign(Value);
end;

procedure TDelphiCookbookItemAppearance.SetMaxTemp
  (const Value: TTextObjectAppearance);
begin
  FMaxTemp.Assign(Value);
end;

function TDelphiCookbookItemAppearance.GetGroupClass
  : TPresetItemObjects.TGroupClass;
begin
  Result := TDelphiCookbookItemAppearance;
end;

procedure TDelphiCookbookItemAppearance.UpdateSizes(const FinalSize: TSizeF);
var
  LColWidth: Extended;
  LFullWidth: Boolean;
begin
  BeginUpdate;
  try
    inherited;
    LColWidth := FinalSize.Width / 12;
    LFullWidth := LColWidth * 4 >= MinTemp.Width;
    if LFullWidth then
    begin
      MinTemp.Visible := True;
      Text.InternalWidth := LColWidth * 6;
      MinTemp.PlaceOffset.X := LColWidth * 6;
      MinTemp.InternalWidth := LColWidth * 2;
      MaxTemp.PlaceOffset.X := LColWidth * 9;
      MaxTemp.InternalWidth := LColWidth * 2;
    end
    else
    begin
      MinTemp.Visible := False;
      Text.InternalWidth := LColWidth * 8;
      MaxTemp.PlaceOffset.X := LColWidth * 8;
      MaxTemp.InternalWidth := LColWidth * 4;
    end;
  finally
    EndUpdate;
  end;
end;

const
  sThisUnit = 'DelphiCookbookListViewAppearanceU';

initialization

TAppearancesRegistry.RegisterAppearance(TDelphiCookbookItemAppearance,
  TDelphiCookbookAppearanceNames.ListItem, [TRegisterAppearanceOption.Item],
  sThisUnit);

finalization

TAppearancesRegistry.UnregisterAppearances
  (TArray<TItemAppearanceObjectsClass>.Create(TDelphiCookbookItemAppearance));

end.
