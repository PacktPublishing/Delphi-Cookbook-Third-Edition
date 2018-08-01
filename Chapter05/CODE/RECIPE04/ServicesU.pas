unit ServicesU;

interface

type

  IRESTAPIService = interface
    ['{53017C06-D7F7-4F2D-9FEA-43ED543E9BC6}']
    procedure DoLogin(const AUsername: String; const APassword: String);
  end;

  TRESTAPIService = class(TInterfacedObject, IRESTAPIService)
  public
    procedure DoLogin(const AUsername: String; const APassword: String);
  end;

function GetRESTAPIService: IRESTAPIService;

implementation

uses
  System.Threading, System.Classes, EventsU, EventBus, System.SysUtils;

function GetRESTAPIService: IRESTAPIService;
begin
  Result := TRESTAPIService.Create;
end;

{ TRESTAPIService }

procedure TRESTAPIService.DoLogin(const AUsername, APassword: String);
begin
  TTask.Run(
    procedure
    var
      LResult: boolean;
      LAuthEvent: TAuthenticationEvent;
    begin
      // simulate a long operation like HTTP request
      TThread.Sleep(3000);
      LResult := AUsername = APassword;
      LAuthEvent := TAuthenticationEvent.Create(LResult);
      TEventBus.GetDefault.Post(LAuthEvent);
    end);
end;

end.
