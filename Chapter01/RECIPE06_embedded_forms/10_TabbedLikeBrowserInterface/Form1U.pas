unit Form1U;

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
  EmbeddableFormU,
  Vcl.StdCtrls;

type
  TForm1 = class(TEmbeddableForm)
    Button1: TButton;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  inherited;
  Close;
end;

end.
