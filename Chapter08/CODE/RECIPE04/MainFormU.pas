unit MainFormU;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.MobilePreview, FMX.ListView.Types, FMX.ListView, Data.Bind.GenData,
  FMX.Bind.GenData, System.Rtti,
  System.Bindings.Outputs, FMX.Bind.Editors, Data.Bind.EngExt,
  FMX.Bind.DBEngExt, Data.Bind.Components,
  Data.Bind.ObjectScope, IPPeerClient, REST.Client, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Data.Bind.DBScope, FMX.Edit, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.Controls.Presentation;

type
  TMainForm = class(TForm)
    Header: TToolBar;
    Footer: TToolBar;
    HeaderLabel: TLabel;
    ListView1: TListView;
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
  private
    FOSLang: string;
    { Private declarations }
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
  System.DateUtils, FMX.Platform, System.JSON;

{$R *.fmx}

procedure TMainForm.btnGetForecastsClick(Sender: TObject);
begin
  ListView1.Items.Clear;
  RESTRequest1.Params.ParameterByName('country').Value :=
    string.Join(',', [EditCity.Text, EditCountry.Text]);
  RESTRequest1.Params.ParameterByName('lang').Value := FOSLang;
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
      LItem: TListViewItem;
      LWeatherDescription: string;
      LAppRespCode: string;

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

        // parsing response...
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
            LItem := ListView1.Items.Add;
            LItem.Purpose := TListItemPurpose.Header;
            LItem.Text := LDay;
          end;
          LLastDay := LDay;
          LItem := ListView1.Items.Add;
          LItem.Text := FormatDateTime('HH', LForecastDateTime) + ' ' +
            LWeatherDescription + Format(' (min %2.2f max %2.2f)',
            [LTempMin, LTempMax]);
        end;

        // display the city name at the bottom
        LJObjCity := LJObj.GetValue('city') as TJSONObject;
        lblInfo.Text := LJObjCity.GetValue('name').Value + ', ' +
          LJObjCity.GetValue('country').Value;

      finally
        // stop the waiting animation
        AniIndicator1.Visible := False;
        AniIndicator1.Enabled := False;
        btnGetForecasts.Enabled := True;
      end;

    end);
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  LLocaleService: IFMXLocaleService;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXLocaleService) then
  begin
    LLocaleService := TPlatformServices.Current.GetPlatformService
      (IFMXLocaleService) as IFMXLocaleService;
    FOSLang := LLocaleService.GetCurrentLangID;
  end
  else
    FOSLang := 'US';

  EditCountry.Text := FOSLang;
  RESTClient1.BaseURL := 'http://api.openweathermap.org/data/2.5';
  RESTRequest1.Resource :=
    'forecast?q={country}&mode=json&lang={lang}&units=metric&APPID={APPID}';
  RESTRequest1.Params.ParameterByName('APPID').Value := APPID;
  AniIndicator1.Visible := False;

end;

end.
