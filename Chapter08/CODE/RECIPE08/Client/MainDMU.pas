unit MainDMU;

interface

uses
  System.SysUtils, System.Classes, IPPeerClient, Data.Bind.Components,
  Data.Bind.ObjectScope, REST.Client, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

const
  SERVERBASEURL = 'http://192.168.1.242:8080';

type
  TdmMain = class(TDataModule)
    RESTClient: TRESTClient;
    RESTRequest: TRESTRequest;
    dsPeople: TFDMemTable;
    dsPeopleFIRST_NAME: TStringField;
    dsPeopleLAST_NAME: TStringField;
    dsPeopleWORK_PHONE_NUMBER: TStringField;
    dsPeopleMOBILE_PHONE_NUMBER: TStringField;
    dsPeopleEMAIL: TStringField;
    dsPeopleFULL_NAME: TStringField;
    dsPeopleID: TIntegerField;
    procedure dsPeopleCalcFields(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
  public
    procedure SavePerson(AOnSuccess: TProc;
      AOnError: TProc<Integer, String> = nil);
    procedure DeletePerson(AOnSuccess: TProc;
      AOnError: TProc<Integer, String> = nil);
    procedure LoadAll(AOnSuccess: TProc;
      AOnError: TProc<Integer, String> = nil);
    function CanSave: Boolean;
  end;

var
  dmMain: TdmMain;

implementation

uses
  REST.Types, MVCFramework.DataSet.Utils;

{ %CLASSGROUP 'FMX.Controls.TControl' }

{$R *.dfm}
{ TdmMain }

function TdmMain.CanSave: Boolean;
begin
  Result := dsPeople.State in [dsInsert, dsEdit];
end;

procedure TdmMain.DataModuleCreate(Sender: TObject);
begin
  RESTClient.BaseURL := SERVERBASEURL;
end;

procedure TdmMain.DeletePerson(AOnSuccess: TProc;
  AOnError: TProc<Integer, String> = nil);
begin
  RESTRequest.ClearBody;
  RESTRequest.Resource := 'people/{id}';
  RESTRequest.Method := TRESTRequestMethod.rmDELETE;
  RESTRequest.AddParameter('id', dsPeopleID.AsString,
    TRESTRequestParameterKind.pkURLSEGMENT);
  RESTRequest.ExecuteAsync(
    procedure
    begin
      if RESTRequest.Response.StatusCode = 204 then
      begin
        dsPeople.Delete;
        if Assigned(AOnSuccess) then
          AOnSuccess();
      end
      else if Assigned(AOnError) then
        AOnError(RESTRequest.Response.StatusCode,
          RESTRequest.Response.StatusText);
    end);
end;

procedure TdmMain.dsPeopleCalcFields(DataSet: TDataSet);
begin
  DataSet.FieldByName('FULL_NAME').AsString := DataSet.FieldByName('FIRST_NAME')
    .AsString + ' ' + DataSet.FieldByName('LAST_NAME').AsString;

end;

procedure TdmMain.LoadAll(AOnSuccess: TProc; AOnError: TProc<Integer, String>);
begin
  if dsPeople.State in [dsInsert, dsEdit] then
    dsPeople.Cancel;
  dsPeople.Close;
  RESTRequest.ClearBody;
  RESTRequest.Resource := 'people';
  RESTRequest.Method := TRESTRequestMethod.rmGET;
  RESTRequest.ExecuteAsync(
    procedure
    begin
      if RESTRequest.Response.StatusCode = 200 then
      begin
        dsPeople.Active := True;
        dsPeople.AppendFromJSONArrayString
          (RESTRequest.Response.JSONValue.ToString);
        dsPeople.First;
        if Assigned(AOnSuccess) then
          AOnSuccess();
      end
      else if Assigned(AOnError) then
        AOnError(RESTRequest.Response.StatusCode,
          RESTRequest.Response.StatusText);
    end);

  // TThread.CreateAnonymousThread(
  // procedure
  // begin
  // try
  // RESTRequest.Execute;
  // TThread.Synchronize(nil,
  // procedure
  // begin
  // if RESTRequest.Response.StatusCode = 200 then
  // begin
  // dsPeople.Active := True;
  // dsPeople.AppendFromJSONArrayString(RESTRequest.Response.JSONValue.ToString);
  // if Assigned(AOnSuccess) then
  // AOnSuccess();
  // end
  // else
  // AOnError(RESTRequest.Response.StatusCode, RESTRequest.Response.StatusText);
  // end);
  // except
  // on E: Exception do
  // begin
  // if Assigned(AOnError) then
  // begin
  // ErrMsg := E.Message;
  // TThread.Synchronize(nil,
  // procedure
  // begin
  // AOnError(0, ErrMsg);
  // end);
  // end
  // end;
  // end;
  // end).Start;
end;

procedure TdmMain.SavePerson(AOnSuccess: TProc;
AOnError: TProc<Integer, String>);
begin
  RESTRequest.ClearBody;
  case dsPeople.State of
    dsInsert:
      begin
        RESTRequest.Resource := 'people';
        RESTRequest.Method := TRESTRequestMethod.rmPOST;
      end;
    dsEdit:
      begin
        RESTRequest.Resource := 'people/{id}';
        RESTRequest.Method := TRESTRequestMethod.rmPUT;
        RESTRequest.AddParameter('id', dsPeopleID.AsString,
          TRESTRequestParameterKind.pkURLSEGMENT);
      end
  else
    raise Exception.Create('Invalid State');
  end;

  RESTRequest.AddBody(dsPeople.AsJSONObject, ctAPPLICATION_JSON);
  RESTRequest.ExecuteAsync(
    procedure
    begin
      if RESTRequest.Response.StatusCode in [200, 201] then
      begin
        dsPeople.Post;
        if Assigned(AOnSuccess) then
          AOnSuccess();
      end
      else if Assigned(AOnError) then
        AOnError(RESTRequest.Response.StatusCode,
          RESTRequest.Response.StatusText);
    end);
end;

end.
