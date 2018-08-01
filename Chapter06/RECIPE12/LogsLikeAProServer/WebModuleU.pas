unit WebModuleU;

interface

uses System.SysUtils, System.Classes, Web.HTTPApp, Data.DBXJSON,
  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Phys.IBBase, FireDAC.Phys.IB,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Moni.Base,
  FireDAC.Moni.FlatFile, FireDAC.Moni.Custom, System.JSON,
  FireDAC.Phys.IBDef, FireDAC.VCLUI.Wait, MVCFramework.Serializer.JSON;

type
  TwmMain = class(TWebModule)
    Connection: TFDConnection;
    FDPhysIBDriverLink1: TFDPhysIBDriverLink;
    cmdInsertPerson: TFDCommand;
    qryPeople: TFDQuery;
    cmdUpdatePerson: TFDCommand;
    WebFileDispatcher1: TWebFileDispatcher;
    procedure wmMainDefaultHandlerAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure wmMainwaGetPeopleAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure wmMainwaDeletePersonAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure wmMainwaSavePersonAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure ConnectionBeforeConnect(Sender: TObject);
    procedure WebModuleCreate(Sender: TObject);
    procedure WebModuleDestroy(Sender: TObject);
    procedure WebModuleException(Sender: TObject; E: Exception;
      var Handled: Boolean);
    procedure WebModuleBeforeDispatch(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure WebModuleAfterDispatch(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
  private
    FSerializer: TMVCJSONSerializer;
    procedure PrepareResponse(AJSONValue: TJSONValue;
      AWebResponse: TWebResponse);
  end;

var
  WebModuleClass: TComponentClass = TwmMain;

implementation

{$R *.dfm}

uses
  MVCFramework.DataSet.Utils, {this unit comes from delphimvcframework project}
  MVCFramework.Serializer.Commons,
  System.RegularExpressions,
  System.IOUtils,
  System.StrUtils,
  LoggerProConfig;

procedure TwmMain.wmMainDefaultHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  Response.SendRedirect('/index.html');
end;

procedure TwmMain.wmMainwaDeletePersonAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  Connection.ExecSQL('DELETE FROM PEOPLE WHERE ID = ?',
    [Request.ContentFields.Values['id']]);
  PrepareResponse(nil, Response);
end;

procedure TwmMain.wmMainwaGetPeopleAction(Sender: TObject; Request: TWebRequest;
  Response: TWebResponse; var Handled: Boolean);
var
  JPeople: TJSONArray;
  SQL: string;
  OrderBy: string;
  JObj: TJSONObject;
begin
  SQL := 'SELECT * FROM PEOPLE ';
  OrderBy := Request.QueryFields.Values['jtSorting'].Trim.ToUpper;
  if OrderBy.IsEmpty then
    SQL := SQL + 'ORDER BY FIRST_NAME ASC'
  else
  begin
    if TRegEx.IsMatch(OrderBy, '^[A-Z,_]+[ ]+(ASC|DESC)$') then
      SQL := SQL + 'ORDER BY ' + OrderBy
    else
      raise Exception.Create('Invalid order clause syntax');
  end;

  // execute query and prepare response
  qryPeople.Open(SQL);
  try
    JPeople := TJSONArray.Create;
    while not qryPeople.Eof do
    begin
      JObj := TJSONObject.Create;
      FSerializer.DataSetToJSONObject(qryPeople, JObj,
        TMVCNameCase.ncLowerCase, []);
      JPeople.Add(JObj);
      qryPeople.Next;
    end;
  finally
    qryPeople.Close;
  end;
  PrepareResponse(JPeople, Response);
end;

procedure TwmMain.wmMainwaSavePersonAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  InsertMode: Boolean;
  LastID: Integer;
  HTTPFields: TStrings;
  JPeople: TJSONObject;

  procedure CheckNoEmpty(const AName, AValue: String);
  const
    NO_EMPTY_FIELD: array of string = ['FIRST_NAME', 'LAST_NAME', 'EMAIL'];
  begin
    if not MatchText(AName, NO_EMPTY_FIELD) then
      exit;
    if AValue.IsEmpty then
      raise Exception.CreateFmt('Field %s cannot be empty', [AName]);
  end;

  procedure MapStringsToParams(AStrings: TStrings; AFDParams: TFDParams);
  var
    i: Integer;
  begin
    for i := 0 to HTTPFields.Count - 1 do
    begin
      if AStrings.ValueFromIndex[i].IsEmpty then
      begin
        CheckNoEmpty(AStrings.Names[i].ToUpper, AStrings.ValueFromIndex[i]);
        AFDParams.ParamByName(AStrings.Names[i].ToUpper).Clear();
      end
      else
        AFDParams.ParamByName(AStrings.Names[i].ToUpper).Value :=
          AStrings.ValueFromIndex[i];
    end;
  end;

begin
  HTTPFields := Request.ContentFields;
  InsertMode := HTTPFields.IndexOfName('id') = -1;
  if InsertMode then
  begin
    MapStringsToParams(HTTPFields, cmdInsertPerson.Params);
    cmdInsertPerson.Execute();
    LastID := Connection.GetLastAutoGenValue('GEN_PEOPLE_ID');
  end
  else
  begin
    MapStringsToParams(HTTPFields, cmdUpdatePerson.Params);
    cmdUpdatePerson.Execute();
    LastID := HTTPFields.Values['id'].ToInteger;
  end;

  // execute query and prepare response
  qryPeople.Open('SELECT * FROM PEOPLE WHERE ID = ?', [LastID]);
  try
    JPeople := TJSONObject.Create;
    FSerializer.DataSetToJSONObject(qryPeople, JPeople,
      TMVCNameCase.ncLowerCase, []);
    PrepareResponse(JPeople, Response);
  finally
    qryPeople.Close;
  end;
end;

procedure TwmMain.ConnectionBeforeConnect(Sender: TObject);
begin
  Connection.Params.Values['Database'] :=
    TPath.GetDirectoryName(WebApplicationFileName) + '\..\..\DATA\SAMPLES.IB';
end;

procedure TwmMain.PrepareResponse(AJSONValue: TJSONValue;
  AWebResponse: TWebResponse);
var
  JObj: TJSONObject;
begin
  JObj := TJSONObject.Create;
  try
    JObj.AddPair('Result', 'OK');
    if Assigned(AJSONValue) then
    begin
      if AJSONValue is TJSONArray then
        JObj.AddPair('Records', AJSONValue)
      else
        JObj.AddPair('Record', AJSONValue)
    end;
    AWebResponse.Content := JObj.ToString;
    AWebResponse.StatusCode := 200;
    AWebResponse.ContentType := 'application/json';
  finally
    JObj.Free;
  end;
end;

procedure TwmMain.WebModuleAfterDispatch(Sender: TObject; Request: TWebRequest;
  Response: TWebResponse; var Handled: Boolean);
begin
  Log.DebugFmt('Response ok for request <%s>', [Request.PathInfo], LOG_TAG);
end;

procedure TwmMain.WebModuleBeforeDispatch(Sender: TObject; Request: TWebRequest;
  Response: TWebResponse; var Handled: Boolean);
begin
  Log.DebugFmt('Start processing of request <%s> - <%s>',
    [Request.PathInfo, Request.Method], LOG_TAG);
end;

procedure TwmMain.WebModuleCreate(Sender: TObject);
begin
  FSerializer := TMVCJSONSerializer.Create;
  WebFileDispatcher1.RootDirectory := TPath.GetDirectoryName
    (WebApplicationFileName) + '\www';
end;

procedure TwmMain.WebModuleDestroy(Sender: TObject);
begin
  FSerializer.Free;
end;

procedure TwmMain.WebModuleException(Sender: TObject; E: Exception;
  var Handled: Boolean);
begin
  Log.Error(E.Message, LoggerProConfig.LOG_TAG);
end;

end.
