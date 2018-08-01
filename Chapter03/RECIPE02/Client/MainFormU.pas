unit MainFormU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IPPeerClient,
  Data.DB, Vcl.Grids, Vcl.DBGrids, Datasnap.DBClient, REST.Response.Adapter,
  Vcl.StdCtrls, Vcl.Mask,
  Vcl.DBCtrls, System.Rtti,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtCtrls, Vcl.ComCtrls,
  System.Net.URLClient, System.Net.HttpClient, System.Net.HttpClientComponent;

type
  TMainForm = class(TForm)
    dsrcPeople: TDataSource;
    dsrcPerson: TDataSource;
    Label5: TLabel;
    dsPeople: TFDMemTable;
    dsPeopleID: TStringField;
    dsPeopleFIRST_NAME: TStringField;
    dsPeopleLAST_NAME: TStringField;
    dsPeopleWORK_PHONE_NUMBER: TStringField;
    dsPeopleEMAIL: TStringField;
    dsPerson: TFDMemTable;
    dsPersonID: TStringField;
    dsPersonFIRST_NAME: TStringField;
    dsPersonLAST_NAME: TStringField;
    dsPersonWORK_PHONE_NUMBER: TStringField;
    dsPersonMOBILE_PHONE_NUMBER: TStringField;
    dsPersonEMAIL: TStringField;
    dsPeopleMOBILE_PHONE_NUMBER: TStringField;
    Label6: TLabel;
    pcMain: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    btnOpen: TButton;
    DBNavigator1: TDBNavigator;
    DBGrid1: TDBGrid;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    EditSearch: TEdit;
    Button1: TButton;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    DBEdit9: TDBEdit;
    DBEdit10: TDBEdit;
    Label1: TLabel;
    DBNavigator2: TDBNavigator;
    procedure btnOpenClick(Sender: TObject);
    procedure btnGetPersonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure dsPeopleBeforePost(DataSet: TDataSet);
    procedure dsPeopleAfterOpen(DataSet: TDataSet);
    procedure dsPeopleBeforeDelete(DataSet: TDataSet);
    procedure dsPersonBeforePost(DataSet: TDataSet);
  private
    FHTTPClient: THTTPClient;
    function CreateRecordOnServer(ADataSet: TDataSet): string;
    procedure UpdateRecordOnServer(ADataSet: TDataSet);
    procedure DeleteRecordOnServer(ADataSet: TDataSet);
    procedure UpdateDataSetFromURL(AURL: string; ADataSet: TDataSet);
  public const
    BASEURL = 'http://localhost:8080';
    ERROR_FORMAT_STRING = 'HTTP %d' + sLineBreak + '%s';
  end;

var
  MainForm: TMainForm;

implementation

uses
  MVCFramework.DataSet.Utils, MVCFramework.Commons, System.NetEncoding;

{$R *.dfm}

procedure TMainForm.btnOpenClick(Sender: TObject);
begin
  dsPeople.Close;
  dsPeople.BeforePost := nil;
  try
    dsPeople.Open;
    dsPeople.First;
  finally
    dsPeople.BeforePost := dsPeopleBeforePost;
  end;
end;

procedure TMainForm.btnGetPersonClick(Sender: TObject);
var
  LResponse: IHTTPResponse;
begin
  dsPerson.Close;
  LResponse := FHTTPClient.Get(BASEURL + '/people/' + TNetEncoding.URL.Encode
    (EditSearch.Text));
  if LResponse.StatusCode = HTTP_STATUS.OK then
  begin
    if LResponse.HeaderValue['Content-Type'].StartsWith('application/json') then
    begin
      dsPerson.Open;
      dsPerson.BeforePost := nil;
      dsPerson.Insert;
      dsPerson.LoadFromJSONObjectString(LResponse.ContentAsString);
      dsPerson.Post;
      dsPerson.BeforePost := dsPersonBeforePost;
    end
    else
    begin
      ShowMessageFmt
        ('Invalid response format (expected application/json, actual %s',
        [LResponse.HeaderValue['Content-Type']]);
    end;
  end
  else
  begin
    ShowMessageFmt(ERROR_FORMAT_STRING, [LResponse.StatusCode,
      LResponse.StatusText]);
  end;
end;

function TMainForm.CreateRecordOnServer(ADataSet: TDataSet): string;
var
  LPOSTRequest: IHTTPRequest;
  LResponse: IHTTPResponse;
  LBody: TStringStream;
begin
  LPOSTRequest := FHTTPClient.GetRequest('POST', BASEURL + '/people');
  LPOSTRequest.AddHeader('content-type', 'application/json');
  LBody := TStringStream.Create(ADataSet.AsJSONObject);
  try
    LPOSTRequest.SourceStream := LBody;
    LResponse := FHTTPClient.Execute(LPOSTRequest);
  finally
    LBody.Free;
  end;
  if LResponse.StatusCode <> HTTP_STATUS.Created then
    raise Exception.CreateFmt(ERROR_FORMAT_STRING,
      [LResponse.StatusCode, LResponse.StatusText]);

  // the server returned the newly created resource in the LOCATION header
  Result := LResponse.HeaderValue['location'];
end;

procedure TMainForm.DeleteRecordOnServer(ADataSet: TDataSet);
var
  LResponse: IHTTPResponse;
begin
  LResponse := FHTTPClient.Delete(BASEURL + '/people/' +
    ADataSet.FieldByName('ID').AsString);
  if LResponse.StatusCode <> HTTP_STATUS.NoContent then
    raise Exception.CreateFmt(ERROR_FORMAT_STRING,
      [LResponse.StatusCode, LResponse.StatusText]);
end;

procedure TMainForm.dsPeopleAfterOpen(DataSet: TDataSet);
var
  LResponse: IHTTPResponse;
begin
  LResponse := FHTTPClient.Get(BASEURL + '/people', nil,
    [TNameValuePair.Create('accept', 'application/json')]);
  if LResponse.StatusCode = HTTP_STATUS.OK then
  begin
    DataSet.AppendFromJSONArrayString(LResponse.ContentAsString);
  end
  else
  begin
    raise Exception.CreateFmt(ERROR_FORMAT_STRING,
      [LResponse.StatusCode, LResponse.StatusText]);
  end;
end;

procedure TMainForm.dsPeopleBeforeDelete(DataSet: TDataSet);
begin
  DeleteRecordOnServer(DataSet);
end;

procedure TMainForm.dsPeopleBeforePost(DataSet: TDataSet);
var
  LNewlyCreatedResourceURI: string;
begin
  case DataSet.State of
    dsInsert:
      begin
        LNewlyCreatedResourceURI := CreateRecordOnServer(DataSet);
        UpdateDataSetFromURL(LNewlyCreatedResourceURI, DataSet);
      end;
    dsEdit:
      UpdateRecordOnServer(DataSet);
  else
    raise Exception.Create('Invalid state');
  end;
end;

procedure TMainForm.dsPersonBeforePost(DataSet: TDataSet);
begin
  // only updates allowed here
  if DataSet.State <> dsEdit then
    raise Exception.Create('Invalid dataset state');
  UpdateRecordOnServer(DataSet);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FHTTPClient := THTTPClient.Create;
  pcMain.ActivePageIndex := 0;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  FHTTPClient.Free;
end;

procedure TMainForm.UpdateDataSetFromURL(AURL: string; ADataSet: TDataSet);
var
  LResponse: IHTTPResponse;
begin
  // get it...
  LResponse := FHTTPClient.Get(BASEURL + AURL, nil,
    [TNameValuePair.Create('accept', 'application/json')]);
  if LResponse.StatusCode <> HTTP_STATUS.OK then
    raise Exception.CreateFmt(ERROR_FORMAT_STRING,
      [LResponse.StatusCode, LResponse.StatusText]);
  // ...and update the dataset with the server generated values
  ADataSet.LoadFromJSONObjectString(LResponse.ContentAsString);
end;

procedure TMainForm.UpdateRecordOnServer(ADataSet: TDataSet);
var
  LPUTRequest: IHTTPRequest;
  LResponse: IHTTPResponse;
  LBody: TStringStream;
begin
  LPUTRequest := FHTTPClient.GetRequest('PUT', BASEURL + '/people/' +
    ADataSet.FieldByName('ID').AsString);
  LPUTRequest.AddHeader('content-type', 'application/json');
  LBody := TStringStream.Create(ADataSet.AsJSONObject);
  try
    LPUTRequest.SourceStream := LBody;
    LResponse := FHTTPClient.Execute(LPUTRequest);
  finally
    LBody.Free;
  end;
  if LResponse.StatusCode <> HTTP_STATUS.OK then
    raise Exception.CreateFmt(ERROR_FORMAT_STRING,
      [LResponse.StatusCode, LResponse.StatusText]);
end;

end.
