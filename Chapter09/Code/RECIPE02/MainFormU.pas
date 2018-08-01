unit MainFormU;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation;

type
  TMainForm = class(TForm)
    Header: TToolBar;
    Footer: TToolBar;
    HeaderLabel: TLabel;
    btnWithInterface: TButton;
    btnWithSingleton: TButton;
    procedure btnWithInterfaceClick(Sender: TObject);
    procedure btnWithSingletonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}


uses UIDeviceSDK, Macapi.helpers;

procedure TMainForm.btnWithInterfaceClick(Sender: TObject);
var
  device: UIDevice;
begin
  device := TUIDevice.Create;
  ShowMessage(NSStrToStr(device.model));
end;

procedure TMainForm.btnWithSingletonClick(Sender: TObject);
var
  Model: string;
begin
  Model := NSStrToStr(TUIDevice.Wrap(TUIDevice.OCClass.currentDevice).model);
  ShowMessage(Model);
end;

end.
