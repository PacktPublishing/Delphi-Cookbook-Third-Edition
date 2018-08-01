unit MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.Classes;

type
  TVCLForm = class(TForm)
    btnCallFMX: TButton;
    ListBox1: TListBox;
    Label1: TLabel;
    procedure btnCallFMXClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  VCLForm: TVCLForm;

implementation

{$R *.dfm}


uses DLLImportU;

procedure MyCallBack(const Value: String);
begin
  VCLForm.ListBox1.Items.Add(Value);
  VCLForm.ListBox1.Update;
end;

procedure TVCLForm.btnCallFMXClick(Sender: TObject);
begin
  Execute('Called by VCL', MyCallBack);
end;

end.
