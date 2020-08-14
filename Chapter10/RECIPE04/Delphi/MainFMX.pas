unit MainFMX;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, FMX.ScrollBox, FMX.Memo;

type
  TMainForm = class(TForm)
    Switch1: TSwitch;
    ToolBar1: TToolBar;
    Label1: TLabel;
    Label2: TLabel;
    Memo1: TMemo;
    ToolBar2: TToolBar;
    procedure Switch1Switch(Sender: TObject);
  private
    { Private declarations }
    function SendCmd(PCMD: string): string;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses
  System.StrUtils, IdException;

{$R *.fmx}

function TMainForm.SendCmd(PCMD: string): string;
var
  LTCPClient: TIdTCPClient;
begin
  Result := '';
  LTCPClient := TIdTCPClient.Create(nil);
  try
    LTCPClient.Host := '192.168.1.83'; // change with your RPI ip address
    LTCPClient.Port := 8008;
    try
      LTCPClient.Connect;
      LTCPClient.SendCmd(PCMD);
    except
      on E: EIdConnClosedGracefully do
      begin
      end;
      on E: Exception do
        Memo1.Lines.Add(E.Message);
    end;
    if not LTCPClient.IOHandler.InputBufferIsEmpty then
      Result := LTCPClient.IOHandler.AllData;
  finally
    LTCPClient.Disconnect;
    LTCPClient.Free;
  end;
end;

procedure TMainForm.Switch1Switch(Sender: TObject);
var
  LCMD: String;
begin
  LCMD := 'L' + ifthen(Switch1.IsChecked, '1', '0');
  SendCmd(LCMD);
end;

end.
