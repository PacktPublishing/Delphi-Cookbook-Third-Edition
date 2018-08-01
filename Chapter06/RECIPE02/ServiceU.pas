unit ServiceU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.SvcMgr, Vcl.Dialogs,
  IdHTTPWebBrokerBridge;

type
  TPhoneBook = class(TService)
    procedure ServiceCreate(Sender: TObject);
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
  private
    LServer: TIdHTTPWebBrokerBridge;
    { Private declarations }
  public
    function GetServiceController: TServiceController; override;
    { Public declarations }
  end;

var
  PhoneBook: TPhoneBook;

implementation

uses
  Web.WebReq, WebModuleU;

{$R *.DFM}


procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  PhoneBook.Controller(CtrlCode);
end;

function TPhoneBook.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TPhoneBook.ServiceCreate(Sender: TObject);
begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
end;

procedure TPhoneBook.ServiceStart(Sender: TService; var Started: Boolean);
begin
  LServer := TIdHTTPWebBrokerBridge.Create(nil);
  LServer.DefaultPort := 8080;
  LServer.Active := True;
end;

procedure TPhoneBook.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
  LServer.Free;
end;

end.
