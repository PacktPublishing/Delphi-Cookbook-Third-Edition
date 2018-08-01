unit MainFormU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.WinXCtrls, BOsU;

type
  TMainForm = class(TForm)
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    LabeledEdit4: TLabeledEdit;
    btnRegister: TButton;
    procedure btnRegisterClick(Sender: TObject);
  private
    { Private declarations }
    function GetCustomer: TCustomer;
    procedure ShowErrors(const AErrors: TArray<String>);
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses
  ValidatorU, ErrorsMessageFormU;

{$R *.dfm}

procedure TMainForm.btnRegisterClick(Sender: TObject);
var
  LCustomer: TCustomer;
  LErrors: TArray<string>;
begin
  LCustomer := GetCustomer;
  try
    LErrors := [];
    if TValidator.Validate(LCustomer, LErrors) then
      ShowMessage('Well done! You''re now registered...')
    else
      ShowErrors(LErrors);
  finally
    LCustomer.Free;
  end;
end;

function TMainForm.GetCustomer: TCustomer;
begin
  Result := TCustomer.Create;
  Result.Firstname := LabeledEdit1.Text;
  Result.Lastname := LabeledEdit2.Text;
  Result.Email := LabeledEdit3.Text;
  Result.Password := LabeledEdit4.Text;
end;

procedure TMainForm.ShowErrors(const AErrors: TArray<String>);
begin
  ErrorsMessageForm.Errors := AErrors;
  ErrorsMessageForm.ShowModal;
end;

end.
