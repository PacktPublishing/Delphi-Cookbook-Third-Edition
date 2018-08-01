unit MainFormU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, IPPeerClient, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope;

type
  TMainForm = class(TForm)
    btnSubmit: TButton;
    edtFirstName: TEdit;
    edtLastName: TEdit;
    edtWorkPhone: TEdit;
    edtMobilePhone: TEdit;
    edtEmail: TEdit;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
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
begin
  RESTRequest1.AddParameter('FIRST_NAME', edtFirstName.Text);
  RESTRequest1.AddParameter('LAST_NAME', edtLastName.Text);
  RESTRequest1.AddParameter('WORK_PHONE_NUMBER', edtWorkPhone.Text);
  RESTRequest1.AddParameter('MOBILE_PHONE_NUMBER', edtMobilePhone.Text);
  RESTRequest1.AddParameter('EMAIL', edtEmail.Text);
  RESTRequest1.Execute;
end;

end.
