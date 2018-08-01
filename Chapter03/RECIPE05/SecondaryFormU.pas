unit SecondaryFormU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TSecondaryForm = class(TForm)
    lblText: TLabel;
    btnOpenForm: TButton;
    Panel1: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnOpenFormClick(Sender: TObject);
  private
    FRegID: Integer;
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses MyMessageManagerU, System.Messaging;

procedure TSecondaryForm.btnOpenFormClick(Sender: TObject);
begin
  TSecondaryForm.Create(Application).Show;
end;

procedure TSecondaryForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  MessageManager.Unsubscribe(TStringMessage, FRegID, False);
  Action := TCloseAction.caFree;
end;

procedure TSecondaryForm.FormCreate(Sender: TObject);
begin
  FRegID := MessageManager.SubscribeToMessage(TStringMessage,
    procedure(const Sender: TObject; const AMessage: TMessage)
    begin
      lblText.Caption := TStringMessage(AMessage).Value;
    end);
end;

end.
