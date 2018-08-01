unit FMXMainForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Edit, FMX.ComboEdit, FMX.ComboTrackBar, FMX.StdCtrls,
  FMX.Controls.Presentation, CommonsU;

type
  TForm1 = class(TForm)
    btnClose: TButton;
    Switch1: TSwitch;
    ComboTrackBar1: TComboTrackBar;
    procedure btnCloseClick(Sender: TObject);
    procedure Switch1Switch(Sender: TObject);
    procedure ComboTrackBar1Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    FCallback: TDLLCallback;
  end;

implementation

{$R *.fmx}

procedure TForm1.ComboTrackBar1Change(Sender: TObject);
begin
  FCallback('ComboTrackBar1 value is ' + ComboTrackBar1.Value.ToString);
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FCallback('Form is about to close');
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  FCallback('Form is about to show');
end;

procedure TForm1.Switch1Switch(Sender: TObject);
begin
  FCallback('Switch1 is ' + Switch1.IsChecked.ToString);
end;

procedure TForm1.btnCloseClick(Sender: TObject);
begin
  Close;
end;

end.
