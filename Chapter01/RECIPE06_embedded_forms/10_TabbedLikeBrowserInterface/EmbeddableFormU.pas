unit EmbeddableFormU;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ExtCtrls;

const
  WM_EMBEDDED_FORM_CLOSE = WM_USER + 1000;

type
  TEmbeddableForm = class(TForm)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);

  private
    FParentWantClose: boolean;
    FStatusText: String;
    procedure SetParentWantClose(const Value: boolean);
    procedure SetStatusText(const Value: String);

    { Private declarations }
  public
    procedure Show(AParent: TPanel); overload;
    property ParentWantClose: boolean read FParentWantClose write SetParentWantClose;
    property StatusText: String read FStatusText write SetStatusText;
  end;

implementation

{$R *.dfm}
{ TEmbeddableForm }

procedure TEmbeddableForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if ParentWantClose then
    Action := caFree
  else
  begin
    Action := caNone;
    (Owner as TForm).Perform(WM_EMBEDDED_FORM_CLOSE, NativeUInt(Self), 0);
  end;
end;

procedure TEmbeddableForm.FormCreate(Sender: TObject);
begin
  StatusText := ClassName + ' form, created at ' + DateTimeToStr(now);
end;

procedure TEmbeddableForm.SetParentWantClose(const Value: boolean);
begin
  FParentWantClose := Value;
end;

procedure TEmbeddableForm.SetStatusText(const Value: String);
begin
  FStatusText := Value;
end;

procedure TEmbeddableForm.Show(AParent: TPanel);
begin
  Parent := AParent;
  BorderStyle := bsNone;
  BorderIcons := [];
  Align := alClient;
  Show;
end;

end.
