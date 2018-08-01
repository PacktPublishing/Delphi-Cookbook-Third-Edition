unit MainFormU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.Menus,
  Vcl.Grids, Vcl.ExtCtrls;

type
  TMainForm = class(TForm)
    ListBox1: TListBox;
    lbl: TLabel;
    Button1: TButton;
    Label1: TLabel;
    Button2: TButton;
    Label2: TLabel;
    Button3: TButton;
    Button4: TButton;
    ListBox2: TListBox;
    ComboBox1: TComboBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    Edit1: TEdit;
    OpenDialog1: TOpenDialog;
    StringGrid1: TStringGrid;
    Bevel1: TBevel;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure StylesListRefresh;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses
  // these units are required to work with styles at runtime
  Vcl.Themes, Vcl.Styles;

{$R *.dfm}

procedure TMainForm.Button1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    if TStyleManager.IsValidStyle(OpenDialog1.FileName) then
    begin
      TStyleManager.LoadFromFile(OpenDialog1.FileName);
      StylesListRefresh;
      ShowMessage('New VCL Style has been loaded');
    end
    else
      ShowMessage('Sorry, the selected file is not a valid VCL Style!');
  end;
end;

procedure TMainForm.Button2Click(Sender: TObject);
begin
  TStyleManager.SetStyle(ListBox1.Items[ListBox1.ItemIndex]);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  StylesListRefresh;
end;

procedure TMainForm.StylesListRefresh;
var
  stylename: string;
begin
  ListBox1.Clear;
  // retrieve all the styles linked in the executable
  for stylename in TStyleManager.StyleNames do
  begin
    ListBox1.Items.Add(stylename);
  end;
end;

end.
