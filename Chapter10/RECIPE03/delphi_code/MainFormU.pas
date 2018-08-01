unit MainFormU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, CPort, Vcl.WinXCtrls,
  System.ImageList, Vcl.ImgList;

type
  TMainForm = class(TForm)
    ComPort1: TComPort;
    btnSetup: TButton;
    btnConnection: TButton;
    redLedLabel: TLabel;
    greenLEDLabel: TLabel;
    redLEDSwitch: TToggleSwitch;
    greenLEDSwitch: TToggleSwitch;
    procedure btnSetupClick(Sender: TObject);
    procedure btnConnectionClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ComPort1RxChar(Sender: TObject; Count: Integer);
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

procedure TMainForm.ComPort1RxChar(Sender: TObject; Count: Integer);
var
  Str: String;
begin
  // Receives messages from Arduino.
  ComPort1.ReadStr(Str, Count);

  if Str.ToUpper = 'R_ON' then
    redLEDSwitch.State := TToggleSwitchState.tssOn
  else if Str.ToUpper = 'R_OFF' then
    redLEDSwitch.State := TToggleSwitchState.tssOff
  else if Str.ToUpper = 'G_ON' then
    greenLEDSwitch.State := TToggleSwitchState.tssOn
  else if Str.ToUpper = 'G_OFF' then
    greenLEDSwitch.State := TToggleSwitchState.tssOff;

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

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  if ComPort1.Connected then
    ComPort1.Close;
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
