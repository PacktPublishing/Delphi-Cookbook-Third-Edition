unit MainFormU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IPPeerClient, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Datasnap.DBClient, REST.Response.Adapter, Vcl.StdCtrls, Vcl.Mask,
  Vcl.DBCtrls,
  System.Rtti,
  System.Bindings.Outputs, Vcl.Bind.Editors, Data.Bind.EngExt, Vcl.Bind.DBEngExt,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtCtrls;

type
  TForm9 = class(TForm)
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    Button1: TButton;
    RESTRequest2: TRESTRequest;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    RESTResponseDataSetAdapter2: TRESTResponseDataSetAdapter;
    RESTResponse2: TRESTResponse;
    Edit1: TEdit;
    Button2: TButton;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    DataSource2: TDataSource;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    Label5: TLabel;
    DBEdit5: TDBEdit;
    BindingsList1: TBindingsList;
    LinkControlToField1: TLinkControlToField;
    FDMemTable1: TFDMemTable;
    FDMemTable1FIRST_NAME: TStringField;
    FDMemTable1LAST_NAME: TStringField;
    FDMemTable1WORK_PHONE_NUMBER: TStringField;
    FDMemTable1EMAIL: TStringField;
    FDMemTable2: TFDMemTable;
    FDMemTable2ID: TStringField;
    FDMemTable2FIRST_NAME: TStringField;
    FDMemTable2LAST_NAME: TStringField;
    FDMemTable2WORK_PHONE_NUMBER: TStringField;
    FDMemTable2MOBILE_PHONE_NUMBER: TStringField;
    FDMemTable2EMAIL: TStringField;
    Memo1: TMemo;
    Button3: TButton;
    RESTUpd: TRESTRequest;
    FDMemTable1MOBILE_PHONE_NUMBER: TStringField;
    Button4: TButton;
    Button5: TButton;
    FDMemTable1ID: TIntegerField;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FDMemTable1AfterScroll(DataSet: TDataSet);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure RESTRequest1HTTPProtocolError(Sender: TCustomRESTRequest);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form9: TForm9;

implementation

uses
  MVCFramework.DataSet.Utils, REST.Types, System.JSON;

{$R *.dfm}


procedure TForm9.Button1Click(Sender: TObject);
begin
  ShowMessage('This will send an asynchronous request');
  FDMemTable1.Close;
  RESTRequest1.ExecuteAsync(
    procedure
    begin
      FDMemTable1.Active := True;
      FDMemTable1.AppendFromJSONArrayString(RESTRequest1.Response.JSONValue.ToString);
    end);
end;

procedure TForm9.Button2Click(Sender: TObject);
begin
  ShowMessage('This will send an synchronous request');
  RESTRequest2.Execute;
end;

procedure TForm9.Button3Click(Sender: TObject);
begin
  if FDMemTable1.State <> dsedit then
    FDMemTable1.Edit;
  RESTUpd.ClearBody;
  RESTUpd.Resource := 'people/{id}';
  RESTUpd.Method := TRESTRequestMethod.rmPUT;
  RESTUpd.AddParameter('id', FDMemTable1ID.AsString, TRESTRequestParameterKind.pkURLSEGMENT);
  RESTUpd.AddBody(FDMemTable1.AsJSONObject, ctAPPLICATION_JSON);
  RESTUpd.Execute;
  FDMemTable1.Post;
end;

procedure TForm9.Button4Click(Sender: TObject);
begin
  RESTUpd.ClearBody;
  RESTUpd.Resource := 'people/{id}';
  RESTUpd.Method := TRESTRequestMethod.rmDELETE;
  RESTUpd.AddParameter('id', FDMemTable1ID.AsString, TRESTRequestParameterKind.pkURLSEGMENT);
  RESTUpd.Execute;
  FDMemTable1.Delete;
end;

procedure TForm9.Button5Click(Sender: TObject);
begin
  RESTUpd.ClearBody;
  RESTUpd.Resource := 'people';
  RESTUpd.Method := TRESTRequestMethod.rmPOST;
  RESTUpd.AddBody(FDMemTable1.AsJSONObject, ctAPPLICATION_JSON);
  RESTUpd.Execute;
  FDMemTable1.Post;
end;

procedure TForm9.FDMemTable1AfterScroll(DataSet: TDataSet);
begin
  Memo1.Lines.Text := FDMemTable1.AsJSONObject;
end;

procedure TForm9.RESTRequest1HTTPProtocolError(Sender: TCustomRESTRequest);
begin
  ShowMessage(Sender.Response.StatusText);
end;

end.
