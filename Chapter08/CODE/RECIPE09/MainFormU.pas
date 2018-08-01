unit MainFormU;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.PhoneDialer,
  FMX.Platform, FMX.Edit, FMX.Layouts, FMX.ListBox, System.Actions,
  FMX.ActnList, FMX.StdActns, FMX.PhoneDialer.Actions,
  FMX.Controls.Presentation;

type
  TMainForm = class(TForm)
    btnCall: TButton;
    edtPhoneNumber: TEdit;
    ToolBar1: TToolBar;
    Label1: TLabel;
    lbCalls: TListBox;
    lbInfo: TListBox;
    Label2: TLabel;
    procedure btnCallClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FPhoneDialerService: IFMXPhoneDialerService;
    procedure CallStateChanged(const ACallID: string; const AState: TCallState);
    function CallStateAsString(AState: TCallState): String;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

procedure TMainForm.btnCallClick(Sender: TObject);
begin
  if not edtPhoneNumber.Text.IsEmpty then
    FPhoneDialerService.Call(edtPhoneNumber.Text)
  else
  begin
    ShowMessage('No number to call, please type a phone number.');
    edtPhoneNumber.SetFocus;
  end;
end;

function TMainForm.CallStateAsString(AState: TCallState): String;
begin
  case AState of
    TCallState.None:
      Result := 'None';
    TCallState.Connected:
      Result := 'Connected';
    TCallState.Incoming:
      Result := 'Incoming';
    TCallState.Dialing:
      Result := 'Dialing';
    TCallState.Disconnected:
      Result := 'Disconnected';
  else
    Result := '<unknown>';
  end;
end;

procedure TMainForm.CallStateChanged(const ACallID: string;
  const AState: TCallState);
begin
  lbCalls.Items.Add(Format('%-16s %s', [ACallID, CallStateAsString(AState)]));
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  lbInfo.Clear;
  if TPlatformServices.Current.SupportsPlatformService(IFMXPhoneDialerService,
    IInterface(FPhoneDialerService)) then
  begin
    FPhoneDialerService.OnCallStateChanged := CallStateChanged;
    lbInfo.ItemHeight := lbInfo.ClientHeight / 4;
    lbInfo.Items.Add('Carrier Name: ' + FPhoneDialerService.GetCarrier.
      GetCarrierName);
    lbInfo.Items.Add('ISO Country Code: ' +
      FPhoneDialerService.GetCarrier.GetIsoCountryCode);
    lbInfo.Items.Add('Network Code: ' + FPhoneDialerService.GetCarrier.
      GetMobileCountryCode);
    lbInfo.Items.Add('Mobile Network: ' + FPhoneDialerService.GetCarrier.
      GetMobileNetwork);
    btnCall.Enabled := True;
  end
  else
    lbInfo.Items.Add('No Phone Dialer Service');
end;

end.
