unit ErrorsMessageFormU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TErrorsMessageForm = class(TForm)
    Memo1: TMemo;
    Label1: TLabel;
  private
    FErrors: TArray<String>;
    procedure SetErrors(const Value: TArray<String>);
    { Private declarations }
  public
    { Public declarations }
    property Errors: TArray<String> read FErrors write SetErrors;
  end;

var
  ErrorsMessageForm: TErrorsMessageForm;

implementation

{$R *.dfm}
{ TErrorsMessageForm }

procedure TErrorsMessageForm.SetErrors(const Value: TArray<String>);
var
  LError: String;
begin
  FErrors := Value;
  Memo1.Lines.Clear;
  for LError in Value do
  begin
    Memo1.Lines.Add(LError);
  end;
end;

end.
