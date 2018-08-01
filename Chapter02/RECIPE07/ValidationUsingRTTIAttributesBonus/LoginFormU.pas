unit LoginFormU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, BOsU;

type
  TLoginForm = class(TForm)
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    btnRegister: TButton;
    procedure btnRegisterClick(Sender: TObject);
  private
    { Private declarations }
    function GetLoginCustomer: TCustomer;
  public
    { Public declarations }
  end;

var
  LoginForm: TLoginForm;

implementation

uses
  ValidatorU, ErrorsMessageFormU;

{$R *.dfm}

procedure TLoginForm.btnRegisterClick(Sender: TObject);
var
  LCustomer: TCustomer;
  LErrors: TArray<string>;
begin
  LCustomer := GetLoginCustomer;
  try
    LErrors := [];
    if TValidator.Validate(LCustomer, LErrors, 'LoginContext') then
      ShowMessage('Well done! You''re now logged in...')
    else
    begin
      ErrorsMessageForm.Errors := LErrors;
      ErrorsMessageForm.ShowModal;
    end;
  finally
    LCustomer.Free;
  end;
end;

function TLoginForm.GetLoginCustomer: TCustomer;
begin
  Result := TCustomer.Create;
  Result.Email := LabeledEdit1.Text;
  Result.Password := LabeledEdit2.Text;
end;

end.
