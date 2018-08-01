unit MainFormU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, CPort, Vcl.WinXCtrls;

type
  TMainForm = class(TForm)
    redLEDSwitch: TToggleSwitch;
    ComPort1: TComPort;
    btnSetup: TButton;
    btnConnection: TButton;
    redLedLabel: TLabel;
    greenLEDLabel: TLabel;
    greenLEDSwitch: TToggleSwitch;
    procedure btnSetupClick(Sender: TObject);
    procedure redLEDSwitchClick(Sender: TObject);
    procedure btnConnectionClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure greenLEDSwitchClick(Sender: TObject);
  private
    { Private declarations }
    procedure UpdateComponentsState;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses
  System.StrUtils;

{$R *.dfm}

procedure TMainForm.btnSetupClick(Sender: TObject);
begin
  ComPort1.ShowSetupDialog;
end;

procedure TMainForm.btnConnectionClick(Sender: TObject);
begin
  // If the port is connected.
  if ComPort1.Connected then
    ComPort1.Close // Close the port.
  else
    ComPort1.Open; // Open the port.
  UpdateComponentsState;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  UpdateComponentsState;
end;

procedure TMainForm.greenLEDSwitchClick(Sender: TObject);
begin
  case greenLEDSwitch.State of
    tssOff:
      ComPort1.WriteStr('GREEN_OFF');
    tssOn:
      ComPort1.WriteStr('GREEN_ON');
  end;

end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  if ComPort1.Connected then
    ComPort1.Close;
end;

procedure TMainForm.redLEDSwitchClick(Sender: TObject);
begin
  case redLEDSwitch.State of
    tssOff:
      ComPort1.WriteStr('RED_OFF');
    tssOn:
      ComPort1.WriteStr('RED_ON');
  end;
end;

procedure TMainForm.UpdateComponentsState;
begin
  redLEDSwitch.Enabled := ComPort1.Connected;
  greenLEDSwitch.Enabled := ComPort1.Connected;
  redLedLabel.Enabled := ComPort1.Connected;
  greenLEDLabel.Enabled := ComPort1.Connected;
  btnConnection.Caption := ifthen(ComPort1.Connected, 'Close', 'Open');
end;

end.
