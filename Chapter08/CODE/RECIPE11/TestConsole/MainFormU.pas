unit MainFormU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, SmsBO, Vcl.ExtCtrls;

type
  TTestConsoleForm = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    function GetSMSObj: TSMS;
  public
    { Public declarations }
  end;

var
  TestConsoleForm: TTestConsoleForm;

implementation

{$R *.dfm}

uses
  SMS.RESTAPI.ServiceU, System.Threading;

procedure TTestConsoleForm.Button1Click(Sender: TObject);
var
  LRESTApi: ISMSRESTAPIService;
begin

  TTask.Run(
    procedure
    var
      LSMS: TSMS;
    begin
      LRESTApi := BuildSMSRESTApiService;
      LSMS := GetSMSObj;
      try
        LRESTApi.PushSMS(LSMS);
        Memo1.Lines.Add(Format('%s - SMS to %s pushed ', [DateTimeToStr(Now),
          LSMS.DESTINATION]));
      finally
        LSMS.Free;
      end;

    end);
end;

function TTestConsoleForm.GetSMSObj: TSMS;
begin
  Result := TSMS.Create;
  Result.DESTINATION := LabeledEdit1.Text;
  Result.Text := LabeledEdit2.Text;
end;

end.
