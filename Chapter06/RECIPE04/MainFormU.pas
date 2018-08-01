unit MainFormU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.IBBase,
  FireDAC.Phys.IB, Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.DBCtrls, Generics.Collections,
  Data.DBXJSON, JSON.Serialization, PersonU;

type
  TMainForm = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Memo1: TMemo;
    btnListToJSONArray: TButton;
    btnObjToJSON: TButton;
    btnJSONtoObject: TButton;
    btnJSONArrayToList: TButton;
    procedure btnListToJSONArrayClick(Sender: TObject);
    procedure btnJSONtoObjectClick(Sender: TObject);
    procedure btnJSONArrayToListClick(Sender: TObject);
    procedure btnObjToJSONClick(Sender: TObject);
  private
    procedure SetLog(const Value: string);
    function GetLog: string;
    function GetPeople: TObjectList<TPerson>;
  public
    property Log: string read GetLog write SetLog;
  end;

var
  MainForm: TMainForm;

{$R *.dfm}

implementation

uses
  System.JSON;

procedure TMainForm.btnJSONtoObjectClick(Sender: TObject);
var
  JObj: TJSONObject;
  Person: TPerson;
begin
  JObj := TJSONObject.ParseJSONValue(Log) as TJSONObject;
  try
    Person := TJSONUtils.JsonToObject<TPerson>(JObj);
    try
      ShowMessage(Person.FirstName + ' ' + Person.LastName);
    finally
      Person.Free;
    end;
  finally
    JObj.Free;
  end;
end;

procedure TMainForm.btnListToJSONArrayClick(Sender: TObject);
var
  People: TObjectList<TPerson>;
  JArr: TJSONArray;
begin
  People := GetPeople;
  try
    JArr := TJSONUtils.ObjectsToJSONArray<TPerson>(People);
    try
      Log := JArr.ToJSON;
    finally
      JArr.Free;
    end;
  finally
    People.Free;
  end;
end;

procedure TMainForm.btnObjToJSONClick(Sender: TObject);
var
  People: TObjectList<TPerson>;
  JObj: TJSONObject;
begin
  People := GetPeople;
  try
    JObj := TJSONUtils.ObjectToJsonObject(People[0]);
    try
      Log := JObj.ToJSON;
    finally
      JObj.Free;
    end;
  finally
    People.Free
  end;
end;

procedure TMainForm.btnJSONArrayToListClick(Sender: TObject);
var
  JArr: TJSONArray;
  People: TObjectList<TPerson>;
  Person: TPerson;
  S: string;
begin
  JArr := TJSONObject.ParseJSONValue(Log) as TJSONArray;
  try
    People := TJSONUtils.JSONArrayToObjects<TPerson>(JArr);
    try
      S := '';
      for Person in People do
        S := S + sLineBreak + Person.FirstName + ' ' + Person.LastName;
    finally
      People.Free;
    end;
  finally
    JArr.Free;
  end;
  ShowMessage(S);
end;

function TMainForm.GetLog: string;
begin
  Result := Memo1.Lines.Text;
end;

function TMainForm.GetPeople: TObjectList<TPerson>;
var
  P: TPerson;
begin
  Result := TObjectList<TPerson>.Create(True);

  P := TPerson.Create;
  P.ID := 1;
  P.FirstName := 'Daniele';
  P.LastName := 'Spinetti';
  P.WorkPhone := '555-123456';
  P.MobilePhone := '(328) 7776543';
  P.EMail := 'me@spinettaro.it';
  Result.Add(P);

  P := TPerson.Create;
  P.ID := 2;
  P.FirstName := 'John';
  P.LastName := 'Doe';
  P.WorkPhone := '457-6549875';
  P.EMail := 'john@nowhere.com';
  Result.Add(P);

  P := TPerson.Create;
  P.ID := 3;
  P.FirstName := 'Jane';
  P.LastName := 'Doe';
  P.MobilePhone := '(339) 5487542';
  P.EMail := 'jane@nowhere.com';
  Result.Add(P);

  P := TPerson.Create;
  P.ID := 4;
  P.FirstName := 'Daniele';
  P.LastName := 'Teti';
  P.WorkPhone := '555-4353432';
  P.MobilePhone := '(328) 7894562';
  P.EMail := 'me@danieleteti.it';
  Result.Add(P);

end;

procedure TMainForm.SetLog(const Value: string);
begin
  Memo1.Lines.Text := Value;
end;

end.
