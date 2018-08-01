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
  FMX.Controls.Presentation,  FMX.Bind.Grid,
  Data.Bind.Grid, FMX.Layouts, FMX.Grid, DelphiCookbookListViewAppearanceU;

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
    FDMemTable1: TFDMemTable;
    FDMemTable1day: TStringField;
    FDMemTable1description: TStringField;
    FDMemTable1mintemp: TFloatField;
    FDMemTable1maxtemp: TFloatField;
    BindSourceDB1: TBindSourceDB;
    LinkListControlToField1: TLinkListControlToField;
    procedure btnGetForecastsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    Lang: string;
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
  System.DateUtils, FMX.Platform, System.JSON, System.Math;

{$R *.fmx}

procedure TMainForm.btnGetForecastsClick(Sender: TObject);
begin
  // ListView1.Items.Clear;
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
      LDay, LWeatherDescription, LAppRespCode: string;
    begin
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

      FDMemTable1.EmptyView;
      FDMemTable1.DisableControls;
      try
        // parsing forecasts
        LJArrForecasts := LJObj.GetValue('list') as TJSONArray;
        for LJValue in LJArrForecasts do
        begin
          // parse the json object and put data into local variables
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

          // add data into the mem table
          FDMemTable1.Append;
          FDMemTable1day.AsString := LDay;
          FDMemTable1description.Value := FormatDateTime('HH',
            LForecastDateTime) + ' ' + LWeatherDescription;
          FDMemTable1mintemp.Value := LTempMin;
          FDMemTable1maxtemp.Value := LTempMax;
          FDMemTable1.Post;
        end; // for in
      finally
        FDMemTable1.EnableControls;
        BindSourceDB1.ResetNeeded;
        FDMemTable1.First;
      end;
      LJObjCity := LJObj.GetValue('city') as TJSONObject;
      lblInfo.Text := LJObjCity.GetValue('name').Value + ', ' +
        LJObjCity.GetValue('country').Value;
      AniIndicator1.Visible := False;
      AniIndicator1.Enabled := False;
      btnGetForecasts.Enabled := True;
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
    Lang := 'us';

  EditCountry.Text := Lang;
  RESTClient1.BaseURL := 'http://api.openweathermap.org/data/2.5';
  RESTRequest1.Resource :=
    'forecast?q={country}&mode=json&lang={lang}&units=metric&APPID={APPID}';
  RESTRequest1.Params.ParameterByName('APPID').Value := APPID;
  AniIndicator1.Visible := False;
end;

end.
