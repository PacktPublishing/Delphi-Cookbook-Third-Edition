unit MainFormClientU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, IdBaseComponent,
  IdComponent, IdUDPBase, IdUDPClient,
  IdSocketHandle, IdUDPServer, IdGlobal, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.VCLUI.Wait,
  FireDAC.Comp.UI, FireDAC.Phys.IBBase,
  FireDAC.Phys.FB, Vcl.Grids, Vcl.DBGrids, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Phys.IB,
  Vcl.ExtCtrls, Vcl.DBCtrls, FireDAC.Phys.IBDef;

type
  TMainFormClient = class(TForm)
    IdUDPServer1: TIdUDPServer;
    FDConnection1: TFDConnection;
    FDQuery1: TFDQuery;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysIBDriverLink1: TFDPhysIBDriverLink;
    Timer1: TTimer;
    DBNavigator1: TDBNavigator;
    procedure IdUDPServer1UDPRead(AThread: TIdUDPListenerThread;
      const AData: TIdBytes; ABinding: TIdSocketHandle);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainFormClient: TMainFormClient;

implementation

{$R *.dfm}

procedure TMainFormClient.IdUDPServer1UDPRead(AThread: TIdUDPListenerThread;
  const AData: TIdBytes; ABinding: TIdSocketHandle);
var
  ServerConfig: TStringList;
  i: Integer;
begin
  Timer1.Enabled := False;
  try
    Caption := 'Configuration OK...';
    ServerConfig := TStringList.Create;
    try
      ServerConfig.Text := BytesToString(AData);
      for i := 0 to ServerConfig.Count - 1 do
      begin
        FDConnection1.Params.Values[ServerConfig.Names[i]] :=
          ServerConfig.ValueFromIndex[i];
      end;
    finally
      ServerConfig.Free;
    end;
    FDConnection1.Open;
    FDQuery1.Open;
    Caption := 'Connected';
  except
    Caption := 'Wrong configuration or cannot connect';
    Timer1.Enabled := true;
  end;
end;

procedure TMainFormClient.Timer1Timer(Sender: TObject);
begin
  Caption := 'Waiting for configuration...';
  IdUDPServer1.Broadcast(ToBytes('GETCONFIG#APP001'), 8888);
end;

end.
