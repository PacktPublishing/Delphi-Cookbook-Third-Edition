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
    lightBulb1Switch: TSwitch;
    ToolBar1: TToolBar;
    lighBulb1Label: TLabel;
    Label2: TLabel;
    Memo1: TMemo;
    lightBulb2Switch: TSwitch;
    lightBulb2Label: TLabel;
    procedure lightBulb1SwitchSwitch(Sender: TObject);
    procedure lightBulb2SwitchSwitch(Sender: TObject);
  private
    function SendCmd(PCMD: string): string;
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

procedure TMainForm.lightBulb2SwitchSwitch(Sender: TObject);
var
  LCMD: String;
begin
  LCMD := 'L' + ifthen(lightBulb2Switch.IsChecked, '0', '1');
  SendCmd(LCMD);
end;

procedure TMainForm.lightBulb1SwitchSwitch(Sender: TObject);
var
  LCMD: String;
begin
  LCMD := 'R' + ifthen(lightBulb1Switch.IsChecked, '0', '1');
  SendCmd(LCMD);
end;

end.
