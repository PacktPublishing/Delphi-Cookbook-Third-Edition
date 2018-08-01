unit MainFormU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.RTTI, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  System.Generics.Collections, Vcl.Graphics, DuckUtilsU;

{$R *.dfm}

{ Duck }

procedure TForm1.Button5Click(Sender: TObject);
begin
  Duck.Apply(
    TArray<TObject>.Create(Button1, Button2, Edit1, Form1),
    'Caption',
    'Hello There');
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  Duck.Apply(Self, 'Enabled', False,
    function(Item: TObject): boolean
    begin
      Result := not(Item is TButton);
    end);
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
  Duck.Apply(TArray<TObject>.Create(Edit1, Edit2, Button2), 'Font.Name', 'Courier New');
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
  Duck.Apply(Self, 'Color', clRed);
end;

end.
