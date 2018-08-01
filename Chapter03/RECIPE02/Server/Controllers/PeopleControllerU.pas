{ .$DEFINE MAKEITSLOWER }
unit PeopleControllerU;

interface

uses
  MVCFramework, MVCFramework.Commons, PeopleModuleU, PersonBO, Vcl.Imaging.pngimage;

type

  [MVCPath('/people')]
  TPeopleController = class(TMVCController)
  private
    FPeopleModule: TPeopleModule;
    function CreateImageFromPerson(APerson: TPerson): TPNGImage;
  protected
    procedure OnAfterAction(Context: TWebContext; const AActionNAme: string); override;
    procedure OnBeforeAction(Context: TWebContext; const AActionNAme: string;
      var Handled: Boolean); override;
  public
    [MVCPath]
    [MVCHTTPMethod([httpGET])]
    procedure GetPeople(CTX: TWebContext);

    [MVCPath('/searches')]
    [MVCHTTPMethod([httpPOST, httpGET])]
    [MVCConsumes('application/json')]
    procedure SearchPeople(CTX: TWebContext);

    [MVCPath('/($id)')]
    [MVCHTTPMethod([httpGET])]
    procedure GetPersonByID(CTX: TWebContext);

    [MVCPath('/($id)/photo')]
    [MVCHTTPMethod([httpGET])]
    procedure GetPersonPhotoByID(CTX: TWebContext);

    [MVCPath]
    [MVCHTTPMethod([httpPOST])]
    [MVCConsumes('application/json')]
    procedure CreatePerson(CTX: TWebContext);

    [MVCPath('/($id)')]
    [MVCHTTPMethod([httpPUT])]
    [MVCConsumes('application/json')]
    procedure UpdatePerson(CTX: TWebContext);

    [MVCPath('/($id)')]
    [MVCHTTPMethod([httpDELETE])]
    procedure DeletePerson(CTX: TWebContext);
  end;

implementation

uses
  SysUtils, MVCFramework.SystemJSONUtils, System.JSON,
  System.Types, System.Classes, Vcl.GraphUtil, Vcl.Graphics, System.UITypes, System.NetEncoding;

{ TPeopleController }

procedure TPeopleController.CreatePerson(CTX: TWebContext);
var
  Person: TPerson;
begin
  Person := CTX.Request.BodyAs<TPerson>;
  try
    FPeopleModule.CreatePerson(Person);

    // return the link to the newly created resource
    CTX.Response.Location := '/people/' + Person.ID;

    Render(HTTP_STATUS.Created, 'Person created');
  finally
    Person.Free;
  end;
end;

procedure TPeopleController.UpdatePerson(CTX: TWebContext);
var
  Person: TPerson;
begin
  Person := CTX.Request.BodyAs<TPerson>;
  try
    Person.ID := CTX.Request.Params['id'];
    FPeopleModule.UpdatePerson(Person);
    Render(HTTP_STATUS.OK, 'Person updated');
  finally
    Person.Free;
  end;
end;

procedure TPeopleController.DeletePerson(CTX: TWebContext);
begin
  FPeopleModule.DeletePerson(CTX.Request.ParamsAsInteger['id']);
  Render(HTTP_STATUS.NoContent, 'Person deleted');
end;

procedure TPeopleController.GetPersonByID(CTX: TWebContext);
var
  Person: TPerson;
begin
  Person := FPeopleModule.GetPersonByID(CTX.Request.ParamsAsInteger['id']);
  if Assigned(Person) then
    Render(Person)
  else
    Render(HTTP_STATUS.NotFound, 'Person not found');
end;

procedure TPeopleController.GetPersonPhotoByID(CTX: TWebContext);
var
  LPNGImage: TPNGImage;
  LPerson: TPerson;
  LMS: TMemoryStream;
  LBase64Stream: TMemoryStream;
begin
  // get the person object
  LPerson := FPeopleModule.GetPersonByID(CTX.Request.ParamsAsInteger['id']);
  if not Assigned(LPerson) then
    raise EMVCException.Create('Person not found', '', 404, 404);
  try
    LPNGImage := CreateImageFromPerson(LPerson);
    try
      // what the client asked for?
      if Context.Request.ClientPrefer('image/png') then
      begin
        ContentType := 'image/png';
        LMS := TMemoryStream.Create;
        try
          LPNGImage.SaveToStream(LMS);
        except
          FreeAndNil(LMS);
          raise;
        end;
        Render(LMS, True);
      end
      else
      begin
        // if client dont want an image/png, we'll send a text/plain
        ContentType := 'text/plain';
        LBase64Stream := TMemoryStream.Create;
        try
          LMS := TMemoryStream.Create;
          try
            LPNGImage.SaveToStream(LMS);
            LMS.Position := 0;
            TNetEncoding.Base64.Encode(LMS, LBase64Stream);
          finally
            LMS.Free;
          end;
          LBase64Stream.Position := 0;
        except
          LBase64Stream.Free;
          raise;
        end;
        Render(LBase64Stream, True);
      end;
    finally
      LPNGImage.Free;
    end;
  finally
    LPerson.Free;
  end;
end;

function TPeopleController.CreateImageFromPerson(APerson: TPerson): TPNGImage;
var
  LPNGImage: TPNGImage;
  LRect: TRect;
  LText: string;
begin
  LPNGImage := TPNGImage.CreateBlank(COLOR_RGB, 16, 200, 100);
  try
    LRect := Rect(0, 0, 200, 100);

    // draw the gradient background
    GradientFillCanvas(LPNGImage.Canvas, TColors.White, TColor($FFDDDD), LRect,
      TGradientDirection.gdHorizontal);

    // draw a small border
    LPNGImage.Canvas.Pen.Width := 1;
    LPNGImage.Canvas.Pen.Color := clNavy;
    LPNGImage.Canvas.Brush.Style := bsClear;
    LPNGImage.Canvas.Rectangle(LRect);

    // draw the text
    LText := APerson.ToString;
    LPNGImage.Canvas.Font.Size := 12;
    LPNGImage.Canvas.Font.Name := 'Verdana';
    LPNGImage.Canvas.Font.Color := clNavy;
    LRect.Top := LRect.CenterPoint.Y - LPNGImage.Canvas.TextExtent('X').cy div 2;
    LPNGImage.Canvas.TextRect(LRect, LText,
      [TTextFormats.tfCenter, TTextFormats.tfWordBreak]);

  except
    LPNGImage.Free;
    raise;
  end;
  Result := LPNGImage;
end;

procedure TPeopleController.GetPeople(CTX: TWebContext);
begin
  Render<TPerson>(FPeopleModule.GetPeople);
end;

procedure TPeopleController.OnAfterAction(Context: TWebContext; const AActionNAme: string);
begin
  inherited;
  FPeopleModule.Free;
end;

procedure TPeopleController.OnBeforeAction(Context: TWebContext; const AActionNAme: string;
  var Handled: Boolean);
begin
  inherited;
  FPeopleModule := TPeopleModule.Create(nil);
{$IFDEF MAKEITSLOWER}
  Sleep(4000 + Random(2000));
{$ENDIF}
end;

procedure TPeopleController.SearchPeople(CTX: TWebContext);
var
  LFilters: TJSONObject;
  LSearchText: string;
  LCurrPage: Integer;
begin
  case CTX.Request.HTTPMethod of
    httpPOST:
      begin
        LFilters := TJSONObject.ParseJSONValue(CTX.Request.Body) as TJSONObject;
        if not Assigned(LFilters) then
          raise Exception.Create('Invalid search parameters');
        LSearchText := TSystemJSON.GetStringDef(LFilters, 'TEXT');
      end;
    httpGET:
      begin
        if not CTX.Request.QueryStringParamExists('query') then
          raise Exception.Create('Invalid search parameters');
        LSearchText := CTX.Request.Params['query']
      end;
  else
    begin
      raise EMVCConfigException.Create('Invalid method');
    end;
  end;

  if (not TryStrToInt(CTX.Request.Params['page'], LCurrPage)) or (LCurrPage < 1) then
    LCurrPage := 1;
  ResponseStatus(HTTP_STATUS.OK);
  Render<TPerson>(FPeopleModule.FindPeople(LSearchText, LCurrPage));
  CTX.Response.CustomHeaders.Values['dmvc-next-people-page'] :=
    Format('/people/searches?page=%d', [LCurrPage + 1]);
  if LCurrPage > 1 then
    CTX.Response.CustomHeaders.Values['dmvc-prev-people-page'] :=
      Format('/people/searches?page=%d', [LCurrPage - 1]);
end;

end.
