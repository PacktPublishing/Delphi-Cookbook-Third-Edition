unit ServerModuleU;

interface

uses
  System.SysUtils, System.Classes, IdBaseComponent, IdComponent,
  IdCustomTCPServer, IdTCPServer, IdContext;

type
  TServerModule = class(TDataModule)
    IdTCPServer1: TIdTCPServer;
    procedure IdTCPServer1Execute(AContext: TIdContext);
    procedure IdTCPServer1Connect(AContext: TIdContext);
  private
    { Private declarations }
  public
    procedure Start;
    procedure Stop;
  end;

implementation

uses
  IdIOHandlerSocket, System.StrUtils;

{%CLASSGROUP 'System.Classes.TPersistent'}
{$R *.dfm}

procedure TServerModule.IdTCPServer1Connect(AContext: TIdContext);
var
  lHandler: TIdIOHandlerSocket;
begin
  lHandler := AContext.Connection.Socket;
  lHandler.WriteLn('WELCOME TO THE BEST TCPSERVER EVER');
end;

procedure TServerModule.IdTCPServer1Execute(AContext: TIdContext);
var
  lHandler: TIdIOHandlerSocket;
  lCmd: string;
  lResp: string;
begin
  lHandler := AContext.Connection.Socket;
  lCmd := lHandler.ReadLn;
  lCmd := lCmd.ToLower;
  if lCmd = 'quit' then
  begin
    lResp := 'quit';
  end
  else
    lResp := System.StrUtils.ReverseString(lCmd);

  lHandler.WriteLn('RECEIVED: ' + lCmd);
  if lResp = 'quit' then
    AContext.Connection.Disconnect
  else
    lHandler.WriteLn(lResp);
end;

procedure TServerModule.Start;
begin
  IdTCPServer1.Active := True;
end;

procedure TServerModule.Stop;
begin
  IdTCPServer1.Active := False;
end;

end.
