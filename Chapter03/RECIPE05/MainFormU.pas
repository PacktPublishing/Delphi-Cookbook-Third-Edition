unit MainFormU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TMainForm = class(TForm)
    btnOpen: TButton;
    memText: TMemo;
    procedure btnOpenClick(Sender: TObject);
    procedure memTextChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses
  MyMessageManagerU, SecondaryFormU;

{$R *.dfm}

procedure TMainForm.btnOpenClick(Sender: TObject);
begin
  TSecondaryForm.Create(Application).Show;
end;

procedure TMainForm.memTextChange(Sender: TObject);
begin
  MessageManager.SendMessage(Self, TStringMessage.Create(memText.Lines.Text));
end;

end.
