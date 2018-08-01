unit Form3U;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, EmbeddableFormU, Vcl.StdCtrls;

type
  TForm3 = class(TEmbeddableForm)
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TForm3.FormCreate(Sender: TObject);
begin
  inherited;
  // Generate random length captions
  Caption := Caption + ' ' + StringOfChar('*', Random(10));
end;

end.
