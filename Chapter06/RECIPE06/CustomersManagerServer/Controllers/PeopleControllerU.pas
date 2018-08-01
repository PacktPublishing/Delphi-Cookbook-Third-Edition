unit PeopleControllerU;

interface

uses
  MVCFramework, PeopleModuleU, MVCFramework.Commons;

type

  [MVCPath('/people')]
  TPeopleController = class(TMVCController)
  private
    FPeopleModule: TPeopleModule;
  protected
    procedure OnAfterAction(Context: TWebContext;
      const AActionNAme: string); override;
    procedure OnBeforeAction(Context: TWebContext; const AActionNAme: string;
      var Handled: Boolean); override;
  public
    [MVCPath]
    [MVCHTTPMethod([httpGET])]
    procedure GetPeople;

    [MVCPath('/($id)')]
    [MVCHTTPMethod([httpGET])]
    procedure GetPersonByID;

    [MVCPath]
    [MVCHTTPMethod([httpPOST])]
    [MVCConsumes('application/json')]
    procedure CreatePerson;

    [MVCPath('/($id)')]
    [MVCHTTPMethod([httpPUT])]
    [MVCConsumes('application/json')]
    procedure UpdatePerson;

    [MVCPath('/($id)')]
    [MVCHTTPMethod([httpDELETE])]
    procedure DeletePerson;

    [MVCPath('/searches')]
    [MVCHTTPMethod([httpPOST])]
    [MVCConsumes('application/json')]
    procedure SearchPeople;
  end;

implementation

uses
  PersonBO, SysUtils, Data.DBXJSON, System.Math, System.JSON,
  MVCFramework.SystemJSONUtils;

{ TPeopleController }

procedure TPeopleController.CreatePerson;
var
  Person: TPerson;
begin
  Person := Context.Request.BodyAs<TPerson>;
  try
    FPeopleModule.CreatePerson(Person);
    Context.Response.Location := '/people/' + Person.ID.ToString;
    Render(201, 'Person created');
  finally
    Person.Free;
  end;
end;

procedure TPeopleController.UpdatePerson;
var
  Person: TPerson;
begin
  Person := Context.Request.BodyAs<TPerson>;
  try
    Person.ID := Context.Request.ParamsAsInteger['id'];
    FPeopleModule.UpdatePerson(Person);
    Render(200, 'Person updated');
  finally
    Person.Free;
  end;
end;

procedure TPeopleController.DeletePerson;
begin
  FPeopleModule.DeletePerson(Context.Request.ParamsAsInteger['id']);
  Render(204, 'Person deleted');
end;

procedure TPeopleController.GetPersonByID;
var
  Person: TPerson;
begin
  Person := FPeopleModule.GetPersonByID(Context.Request.ParamsAsInteger['id']);
  if Assigned(Person) then
    Render(Person)
  else
    Render(404, 'Person not found');
end;

procedure TPeopleController.GetPeople;
begin
  Render<TPerson>(FPeopleModule.GetPeople);
end;

procedure TPeopleController.OnAfterAction(Context: TWebContext;
  const AActionNAme: string);
begin
  inherited;
  FPeopleModule.Free;
end;

procedure TPeopleController.OnBeforeAction(Context: TWebContext;
  const AActionNAme: string; var Handled: Boolean);
begin
  inherited;
  FPeopleModule := TPeopleModule.Create(nil);
end;

procedure TPeopleController.SearchPeople;
var
  Filters: TJSONObject;
  SearchText: string;
  CurrPage: Integer;
begin
  Filters := TSystemJSON.StringAsJSONObject(Context.Request.Body);
  if not Assigned(Filters) then
    raise Exception.Create('Invalid search parameters');
  SearchText := TSystemJSON.GetStringDef(Filters, 'TEXT');
  if (not TryStrToInt(Context.Request.Params['page'], CurrPage)) or
    (CurrPage < 1) then
    CurrPage := 1;
  Render<TPerson>(FPeopleModule.FindPeople(SearchText, CurrPage));
  Context.Response.CustomHeaders.Values['dmvc-next-people-page'] :=
    Format('/people/searches?page=%d', [CurrPage + 1]);
  if CurrPage > 1 then
    Context.Response.CustomHeaders.Values['dmvc-prev-people-page'] :=
      Format('/people/searches?page=%d', [CurrPage - 1]);
end;

end.
