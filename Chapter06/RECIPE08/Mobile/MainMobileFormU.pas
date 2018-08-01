unit MainMobileFormU;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  IPPeerClient, IPPeerServer, System.Tether.Manager, System.Tether.AppProfile,
  FMX.Layouts, FMX.Effects, FMX.Controls.Presentation;

type
  TMainForm = class(TForm)
    Header: TToolBar;
    Footer: TToolBar;
    HeaderLabel: TLabel;
    TetheringManager1: TTetheringManager;
    TetheringAppProfile1: TTetheringAppProfile;
    GridPanelLayout1: TGridPanelLayout;
    Panel1: TPanel;
    btnLeft: TButton;
    btnNext: TButton;
    btnConnect: TButton;
    lblMinutes: TLabel;
    ShadowEffect1: TShadowEffect;
    ShadowEffect2: TShadowEffect;
    procedure btnLeftClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure btnConnectClick(Sender: TObject);
    procedure TetheringManager1EndAutoConnect(Sender: TObject);
    procedure TetheringManager1PairedToRemote(const Sender: TObject;
      const AManagerInfo: TTetheringManagerInfo);
    procedure TetheringAppProfile1Resources0ResourceReceived
      (const Sender: TObject; const AResource: TRemoteResource);
    procedure TetheringAppProfile1Disconnect(const Sender: TObject;
      const AProfileInfo: TTetheringProfileInfo);
  private
    procedure SendCmd(const ACommand: String);
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

procedure TMainForm.btnConnectClick(Sender: TObject);
begin
  TetheringManager1.AutoConnect(2000);
end;

procedure TMainForm.btnLeftClick(Sender: TObject);
begin
  SendCmd('prev');
end;

procedure TMainForm.btnNextClick(Sender: TObject);
begin
  SendCmd('next');
end;

procedure TMainForm.SendCmd(const ACommand: String);
begin
  if TetheringManager1.RemoteProfiles.Count = 0 then
  begin
    lblMinutes.Text := 'Not connected!';
  end
  else if TetheringManager1.RemoteProfiles.Count = 1 then
  begin
    TetheringAppProfile1.SendString(TetheringManager1.RemoteProfiles[0], 'cmd',
      ACommand);
  end
  else
  begin
    lblMinutes.Text := 'More than one Presenter active!';
  end;
end;

procedure TMainForm.TetheringAppProfile1Disconnect(const Sender: TObject;
  const AProfileInfo: TTetheringProfileInfo);
begin
  btnConnect.Enabled := True;
  btnConnect.Text := 'Connect';
end;

procedure TMainForm.TetheringAppProfile1Resources0ResourceReceived
  (const Sender: TObject; const AResource: TRemoteResource);
begin
  lblMinutes.Text := AResource.Value.AsString + sLineBreak + ' minutes left';
end;

procedure TMainForm.TetheringManager1EndAutoConnect(Sender: TObject);
begin
  btnConnect.Enabled := False;
end;

procedure TMainForm.TetheringManager1PairedToRemote(const Sender: TObject;
  const AManagerInfo: TTetheringManagerInfo);
begin
  btnConnect.Text := 'Connected to: ' + AManagerInfo.ConnectionString;
end;

end.
