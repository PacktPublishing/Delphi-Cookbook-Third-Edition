unit SampleControllerU;

interface

uses
  MVCFramework, MVCFramework.Commons;

type

  [MVCPath('/')]
  [MVCDoc('Just a sample controller')]
  TSampleController = class(TMVCController)
  public
    [MVCPath('/users')]
    [MVCHTTPMethods([httpGET])]
    [MVCDoc('Returns the users list')]
    procedure GetUsers;

    [MVCPath('/users')]
    [MVCHTTPMethods([httpPOST])]
    [MVCConsumes('application/json')]
    [MVCDoc('Creates a new user')]
    procedure CreateUser;
  end;

implementation

uses System.JSON;

{ TSampleController }

procedure TSampleController.CreateUser;
begin
  // just a fake, we don't create any user.
  // simply echo the body request as body response
  if Context.Request.ThereIsRequestBody then
  begin
    Context.Response.StatusCode := HTTP_STATUS.Created;
    Render(Context.Request.Body)
  end
  else
    raise EMVCException.Create(HTTP_STATUS.BadRequest, 'Expected JSON body');
end;

procedure TSampleController.GetUsers;
var
  LJObj: TJSONObject;
  LJArray: TJSONArray;
begin
  LJArray := TJSONArray.Create;

  LJObj := TJSONObject.Create;
  LJObj.AddPair('first_name', 'Daniele').AddPair('last_name', 'Spinetti')
    .AddPair('email', 'd.spinetti@bittime.it');
  LJArray.AddElement(LJObj);

  LJObj := TJSONObject.Create;
  LJObj.AddPair('first_name', 'Peter').AddPair('last_name', 'Parker')
    .AddPair('email', 'pparker@dailybugle.com');
  LJArray.AddElement(LJObj);

  LJObj := TJSONObject.Create;
  LJObj.AddPair('first_name', 'Bruce').AddPair('last_name', 'Banner')
    .AddPair('email', 'bbanner@angermanagement.com');
  LJArray.AddElement(LJObj);

  Render(LJArray);
end;

end.
