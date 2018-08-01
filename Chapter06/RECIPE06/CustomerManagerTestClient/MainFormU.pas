unit MainFormU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IPPeerClient, Vcl.StdCtrls, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, Vcl.ExtCtrls;

type
  TForm9 = class(TForm)
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    Memo1: TMemo;
    Memo2: TMemo;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
  private
    procedure UpdateGUI;
  public
    { Public declarations }
  end;

var
  Form9: TForm9;

implementation

uses
  REST.Types, Data.DBXJSON, System.JSON;

{$R *.dfm}


procedure TForm9.Button1Click(Sender: TObject);
begin
  RESTRequest1.ClearBody;
  RESTRequest1.Resource := 'people';
  RESTRequest1.Method := TRESTRequestMEthod.rmGET;
  RESTRequest1.Execute;
  UpdateGUI;
end;

procedure TForm9.Button2Click(Sender: TObject);
var
  id: string;
begin
  id := InputBox('GET parameter', 'Which person?', '1');
  RESTRequest1.ClearBody;
  RESTRequest1.Resource := 'people/{id}';
  RESTRequest1.AddParameter('id', id, TRESTRequestParameterKind.pkURLSEGMENT);
  RESTRequest1.Method := TRESTRequestMEthod.rmGET;
  RESTRequest1.Execute;
  UpdateGUI;
end;

procedure TForm9.Button3Click(Sender: TObject);
var
  PersonJSON: string;
begin
  RESTRequest1.ClearBody;
  PersonJSON := '{"FIRST_NAME":"Daniele", ' +
    '"LAST_NAME":"Teti",' +
    '"WORK_PHONE_NUMBER":"(555) 1234578",' +
    '"MOBILE_PHONE_NUMBER":"(456) 98765432",' +
    '"EMAIL":"daniele.teti@gmail.com"}';
  RESTRequest1.Resource := 'people';
  RESTRequest1.AddBody(PersonJSON, TRESTContentType.ctAPPLICATION_JSON);
  RESTRequest1.Method := TRESTRequestMEthod.rmPOST;
  RESTRequest1.Execute;
  UpdateGUI;
end;

procedure TForm9.Button4Click(Sender: TObject);
var
  PersonJSON: string;
  id: string;
begin
  id := InputBox('PUT parameter', 'Which person?', '1');
  RESTRequest1.ClearBody;
  PersonJSON := '{"FIRST_NAME":"Daniele", ' +
    '"LAST_NAME":"Teti",' +
    '"WORK_PHONE_NUMBER":"UPDATED",' +
    '"MOBILE_PHONE_NUMBER":"UPDATED",' +
    '"EMAIL":"daniele.teti@gmail.com"}';
  RESTRequest1.Resource := 'people/{id}';
  RESTRequest1.AddParameter('id', id, TRESTRequestParameterKind.pkURLSEGMENT);
  RESTRequest1.AddBody(PersonJSON, TRESTContentType.ctAPPLICATION_JSON);
  RESTRequest1.Method := TRESTRequestMEthod.rmPUT;
  RESTRequest1.Execute;
  UpdateGUI;
end;

procedure TForm9.Button5Click(Sender: TObject);
var
  id: string;
begin
  id := InputBox('DELETE parameter', 'Which person?', '1');
  RESTRequest1.ClearBody;
  RESTRequest1.Resource := 'people/{id}';
  RESTRequest1.AddParameter('id', id, TRESTRequestParameterKind.pkURLSEGMENT);
  RESTRequest1.Method := TRESTRequestMEthod.rmDELETE;
  RESTRequest1.Execute;
  UpdateGUI;
end;

procedure TForm9.Button6Click(Sender: TObject);
var
  SearchText: string;
  JObj: TJSONObject;
begin
  SearchText := InputBox('SEARCHES parameter', 'Search by first name or last name', '');
  RESTRequest1.ClearBody;
  RESTRequest1.Resource := 'people/searches';
  JObj := TJSONObject.Create;
  try
    JObj.AddPair('TEXT', SearchText);
    RESTRequest1.AddBody(JObj.ToString, ctAPPLICATION_JSON);
  finally
    JObj.Free;
  end;
  RESTRequest1.Method := TRESTRequestMEthod.rmPOST;
  RESTRequest1.Execute;
  UpdateGUI;
end;

procedure TForm9.UpdateGUI;
begin
  Memo1.Lines.Clear;
  Memo2.Lines.Clear;
  if Assigned(RESTRequest1.Response.JSONValue) then
    Memo1.Lines.Text := RESTRequest1.Response.JSONValue.ToString;
  if Assigned(RESTRequest1.Response.Headers) then
    Memo2.Lines.Assign(RESTRequest1.Response.Headers);
  Caption := RESTRequest1.Response.StatusCode.ToString + ' ' +
    RESTRequest1.Response.StatusText;
end;

end.
