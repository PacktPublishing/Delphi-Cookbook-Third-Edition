unit MainFormU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdHTTP;

type
  TMainForm = class(TForm)
    IdHTTP1: TIdHTTP;
    btnSubmit: TButton;
    edtFirstName: TEdit;
    edtLastName: TEdit;
    edtWorkPhone: TEdit;
    edtMobilePhone: TEdit;
    edtEmail: TEdit;
    procedure btnSubmitClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}


procedure TMainForm.btnSubmitClick(Sender: TObject);
var
  POSTData: TStringList;
begin
  POSTData := TStringList.Create;
  try
    POSTData.Values['FIRST_NAME'] := edtFirstName.Text;
    POSTData.Values['LAST_NAME'] := edtLastName.Text;
    POSTData.Values['WORK_PHONE_NUMBER'] := edtWorkPhone.Text;
    POSTData.Values['MOBILE_PHONE_NUMBER'] := edtMobilePhone.Text;
    POSTData.Values['EMAIL'] := edtEmail.Text;
    IdHTTP1.Post('http://localhost:8080/saveperson', POSTData);
    if IdHTTP1.ResponseCode <> 200 then
    begin
      ShowMessage('Error occurred' + sLineBreak + IdHTTP1.ResponseText);
    end;
  finally
    POSTData.Free;
  end;
end;

end.
