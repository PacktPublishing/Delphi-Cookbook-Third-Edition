unit MainFormU;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, System.Threading, System.Actions,
  FMX.ActnList;

type
  TSMSSendingForm = class(TForm)
    btnSendNext: TButton;
    ToolBar1: TToolBar;
    Label1: TLabel;
    SendTimer: TTimer;
    ActionList1: TActionList;
    actSendSMS: TAction;
    Label2: TLabel;
    btnStartSending: TButton;
    procedure actSendSMSExecute(Sender: TObject);
    procedure btnStartSendingClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SMSSendingForm: TSMSSendingForm;

implementation

{$R *.fmx}

uses
  SMS.ServiceU;

procedure TSMSSendingForm.actSendSMSExecute(Sender: TObject);
begin
  GetSMSService.SendNextSMS;
end;

procedure TSMSSendingForm.btnStartSendingClick(Sender: TObject);
begin
  SendTimer.Enabled := not SendTimer.Enabled;
  if SendTimer.Enabled then
  begin
    Label2.Text := 'Sending Service Started...';
    Label2.FontColor := TAlphaColorRec.Red;
    btnStartSending.Text := 'Stop Sending Service';
    btnStartSending.FontColor := TAlphaColorRec.Red;
  end
  else
  begin
    Label2.Text := 'Sending Service Stopped...';
    Label2.FontColor := TAlphaColorRec.Blue;
    btnStartSending.Text := 'Start Sending Service';
    btnStartSending.FontColor := TAlphaColorRec.Blue;
  end;
end;

end.
