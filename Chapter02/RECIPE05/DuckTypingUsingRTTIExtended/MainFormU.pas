unit MainFormU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    SpeedButton1: TSpeedButton;
    Button5: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}


uses
  DuckTypeUtilsU;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Duck(Self).All.SetProperty('Caption').ToValue('On All Captions');
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Duck(Self).Where(
    function(C: TComponent): boolean
    begin
      Result := String(C.Name).StartsWith('Edit');
    end).SetProperty('Text').ToValue('Only Here on TEXT property');
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  Duck(Self).All.Apply(
    procedure(C: TComponent)
    begin
      if C is TEdit then
        TEdit(C).Color := clYellow;
    end);

  ShowMessage('And now RED with another method...');

  Duck(Self)
    .Where(TEdit)
    .Apply(
    procedure(C: TComponent)
    begin
      TEdit(C).Color := clRed;
    end);
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  Duck(Self)
    .Where(TComboBox)
    .SetProperty('Text')
    .ToValue('<Select a value>');
end;

end.
