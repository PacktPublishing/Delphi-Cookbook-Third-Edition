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
    Timer1: TTimer;
    procedure Timer1Timer(Sender: TObject);
  private
    function SendCmd(PCMD: string): string;
    procedure UpdateLightBulb(const ACMD: String; const AStatus: String);
  end;

var
  MainForm: TMainForm;

implementation

uses
  System.StrUtils, IdException, System.Threading;

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

procedure TMainForm.Timer1Timer(Sender: TObject);
begin
  TTask.Run(
    procedure
    var
      LStatus: string;
    begin
      LStatus := SendCmd('R');
      UpdateLightBulb('R', LStatus);
      LStatus := SendCmd('L');
      UpdateLightBulb('L', LStatus);
    end);
end;

procedure TMainForm.UpdateLightBulb(const ACMD, AStatus: String);
begin
  TThread.Synchronize(nil,
    procedure
    begin
      if ACMD = 'R' then
        lightBulb1Switch.IsChecked := AStatus = '1'
      else if ACMD = 'L' then
        lightBulb2Switch.IsChecked := AStatus = '1'
    end);
end;

end.
