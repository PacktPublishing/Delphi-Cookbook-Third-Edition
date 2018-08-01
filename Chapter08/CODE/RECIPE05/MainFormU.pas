unit MainFormU;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.MobilePreview, FMX.ListView, Data.Bind.GenData, FMX.Bind.GenData,
  System.Rtti,
  System.Bindings.Outputs, FMX.Bind.Editors, Data.Bind.EngExt,
  FMX.Bind.DBEngExt, Data.Bind.Components,
  Data.Bind.ObjectScope, IPPeerClient, REST.Client, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Data.Bind.DBScope, FMX.Edit, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.Controls.Presentation;

type
  TMainForm = class(TForm)
    Header: TToolBar;
    Footer: TToolBar;
    HeaderLabel: TLabel;
    ListView1: TListView;
    BindingsList1: TBindingsList;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    Panel1: TPanel;
    btnGetForecasts: TButton;
    EditCity: TEdit;
    EditCountry: TEdit;
    lblInfo: TLabel;
    AniIndicator1: TAniIndicator;
    procedure btnGetForecastsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ListView1UpdateObjects(const Sender: TObject;
      const AItem: TListViewItem);
  private
    Lang: string;
    procedure AddFooter(AItems: TAppearanceListViewItems;
      const LMinInTheDay, LMaxInTheDay: Double);
    procedure AddHeader(AItems: TAppearanceListViewItems; const ADay: String);
    procedure AddForecastItem(AItems: TAppearanceListViewItems;
      const AForecastDateTime: TDateTime; const AWeatherDescription: String;
      const ATempMin, ATempMax: Double);
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

const
  // get your own APPID here http://openweathermap.org/appid
  APPID = '05ccda731b87c262a622f20bcecc1026';

implementation

uses
  System.DateUtils, FMX.Platform, System.JSON, System.Math, FMX.Utils;

{$R *.fmx}

procedure TMainForm.AddHeader(AItems: TAppearanceListViewItems;
  const ADay: String);
var
  LItem: TListViewItem;
begin
  LItem := AItems.Add;
  LItem.Purpose := TListItemPurpose.Header;
  LItem.Objects.FindDrawable('HeaderLabel').Data := ADay;
end;

procedure TMainForm.AddForecastItem(AItems: TAppearanceListViewItems;
  const AForecastDateTime: TDateTime; const AWeatherDescription: String;
  const ATempMin, ATempMax: Double);
var
  LItem: TListViewItem;
begin
  LItem := AItems.Add;
  LItem.Objects.FindDrawable('WeatherDescription').Data :=
    FormatDateTime('HH', AForecastDateTime) + ' ' + AWeatherDescription;
  LItem.Objects.FindDrawable('MinTemp').Data :=
    FormatFloat('#0.00', ATempMin) + '°';
  LItem.Objects.FindDrawable('MaxTemp').Data :=
    FormatFloat('#0.00', ATempMax) + '°';
end;

procedure TMainForm.AddFooter(AItems: TAppearanceListViewItems;
  const LMinInTheDay, LMaxInTheDay: Double);
var
  LItem: TListViewItem;
begin
  LItem := AItems.Add;
  LItem.Purpose := TListItemPurpose.Footer;
  LItem.Text := Format('min %2.2f°C max %2.2f°C', [LMinInTheDay, LMaxInTheDay]);
end;

procedure TMainForm.btnGetForecastsClick(Sender: TObject);
begin
  ListView1.Items.Clear;
  RESTRequest1.Params.ParameterByName('country').Value :=
    String.Join(',', [EditCity.Text, EditCountry.Text]);
  RESTRequest1.Params.ParameterByName('lang').Value := Lang;
  AniIndicator1.Visible := True;
  AniIndicator1.Enabled := True;
  btnGetForecasts.Enabled := False;
  RESTRequest1.ExecuteAsync(
    procedure
    var
      LForecastDateTime: TDateTime;
      LJValue: TJSONValue;
      LJObj, LMainForecast, LForecastItem, LJObjCity: TJSONObject;
      LJArrWeather, LJArrForecasts: TJSONArray;
      LTempMin, LTempMax: Double;
      LDay, LLastDay: string;
      LWeatherDescription: string;
      LAppRespCode: string;
      LMinInTheDay: Double;
      LMaxInTheDay: Double;

    begin

      try

        LJObj := RESTRequest1.Response.JSONValue as TJSONObject;

        // check for errors
        LAppRespCode := LJObj.GetValue('cod').Value;
        if LAppRespCode.Equals('404') then
        begin
          lblInfo.Text := 'City not found';
          Exit;
        end;
        if not LAppRespCode.Equals('200') then
        begin
          lblInfo.Text := 'Error ' + LAppRespCode;
          Exit;
        end;

        // parsing forecasts
        LMinInTheDay := 1000;
        LMaxInTheDay := -LMinInTheDay;
        LJArrForecasts := LJObj.GetValue('list') as TJSONArray;
        for LJValue in LJArrForecasts do
        begin
          LForecastItem := LJValue as TJSONObject;
          LForecastDateTime := UnixToDateTime((LForecastItem.GetValue('dt')
            as TJSONNumber).AsInt64);
          LMainForecast := LForecastItem.GetValue('main') as TJSONObject;
          LTempMin := (LMainForecast.GetValue('temp_min')
            as TJSONNumber).AsDouble;
          LTempMax := (LMainForecast.GetValue('temp_max')
            as TJSONNumber).AsDouble;
          LJArrWeather := LForecastItem.GetValue('weather') as TJSONArray;
          LWeatherDescription := TJSONObject(LJArrWeather.Items[0])
            .GetValue('description').Value;
          LDay := FormatDateTime('ddd d mmm yyyy', DateOf(LForecastDateTime));
          if LDay <> LLastDay then
          begin
            if not LLastDay.IsEmpty then
            begin
              AddFooter(ListView1.Items, LMinInTheDay, LMaxInTheDay);
            end;
            AddHeader(ListView1.Items, LDay);
            LMinInTheDay := 1000;
            LMaxInTheDay := -LMinInTheDay;
          end;
          LLastDay := LDay;
          LMinInTheDay := Min(LMinInTheDay, LTempMin);
          LMaxInTheDay := Max(LMaxInTheDay, LTempMax);

          AddForecastItem(ListView1.Items, LForecastDateTime,
            LWeatherDescription, LTempMin, LTempMax);
        end; // for in

        if not LLastDay.IsEmpty then
          AddFooter(ListView1.Items, LMinInTheDay, LMaxInTheDay);

        LJObjCity := LJObj.GetValue('city') as TJSONObject;
        lblInfo.Text := LJObjCity.GetValue('name').Value + ', ' +
          LJObjCity.GetValue('country').Value;

      finally
        AniIndicator1.Visible := False;
        AniIndicator1.Enabled := False;
        btnGetForecasts.Enabled := True;
      end;

    end);
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  LocaleService: IFMXLocaleService;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXLocaleService) then
  begin
    LocaleService := TPlatformServices.Current.GetPlatformService
      (IFMXLocaleService) as IFMXLocaleService;
    Lang := LocaleService.GetCurrentLangID;
  end
  else
    Lang := 'US';

  EditCountry.Text := Lang;
  RESTClient1.BaseURL := 'http://api.openweathermap.org/data/2.5';
  RESTRequest1.Resource :=
    'forecast?q={country}&mode=json&lang={lang}&units=metric&APPID={APPID}';
  RESTRequest1.Params.ParameterByName('APPID').Value := APPID;
  AniIndicator1.Visible := False;
end;

procedure TMainForm.ListView1UpdateObjects(const Sender: TObject;
const AItem: TListViewItem);
var
  AQuarter: Double;
  lb: TListItemText;
  lListView: TListView;
begin
  lListView := Sender as TListView;
  case AItem.Purpose of
    TListItemPurpose.None:
      begin
        AQuarter := (lListView.Width - lListView.ItemSpaces.Left -
          lListView.ItemSpaces.Right) / 4;
        AItem.Height := 24;

        lb := TListItemText(AItem.Objects.FindDrawable('WeatherDescription'));
        if not Assigned(lb) then
        begin
          lb := TListItemText.Create(AItem);
          lb.PlaceOffset.X := 0;
          lb.TextAlign := TTextAlign.Leading;
          lb.Name := 'WeatherDescription';
        end;
        lb.PlaceOffset.X := 0;

        lb := TListItemText(AItem.Objects.FindDrawable('MinTemp'));
        if not Assigned(lb) then
        begin
          lb := TListItemText.Create(AItem);
          lb.TextAlign := TTextAlign.Trailing;
          lb.TextColor := TAlphaColorRec.Blue;
          lb.Name := 'MinTemp';
        end;
        lb.PlaceOffset.X := AQuarter * 2;
        lb.Width := AQuarter;

        lb := TListItemText(AItem.Objects.FindDrawable('MaxTemp'));
        if not Assigned(lb) then
        begin
          lb := TListItemText.Create(AItem);
          lb.TextAlign := TTextAlign.Trailing;
          lb.TextColor := TAlphaColorRec.Red;
          lb.Name := 'MaxTemp';
        end;
        lb.PlaceOffset.X := AQuarter * 3;
        lb.Width := AQuarter;
      end;
    TListItemPurpose.Header:
      begin
        AItem.Height := 48;
        lb := TListItemText(AItem.Objects.FindDrawable('HeaderLabel'));
        if not Assigned(lb) then
        begin
          lb := TListItemText.Create(AItem);
          lb.TextAlign := TTextAlign.Center;
          lb.Align := TListItemAlign.Center;
          lb.TextColor := TAlphaColorRec.Red;
          lb.Name := 'HeaderLabel';
        end;
        lb.PlaceOffset.Y := AItem.Height / 4;
      end;
    TListItemPurpose.Footer:
      begin
        AItem.Objects.TextObject.TextAlign := TTextAlign.Trailing;
      end;
  end;

end;

end.
