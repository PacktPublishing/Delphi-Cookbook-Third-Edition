unit MainFormU;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.Edit, FMX.Objects, FMX.ListBox,
  FMX.Layouts, FMX.Controls.Presentation;

type
  TMainForm = class(TForm)
    EditSearch: TEdit;
    Image1: TImage;
    StyleBook1: TStyleBook;
    ListBox1: TListBox;
    procedure EditSearchKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
  private
    procedure DoSearch(const ASearchText: String);
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}


uses RandomUtilsU;

procedure TMainForm.DoSearch(const ASearchText: String);
var
  I: Integer;
  House: string;
  SearchText: string;
begin
  // this is a fake search...
  ListBox1.Clear;
  SearchText := ASearchText.ToUpper;
  for I := 1 to 50 do
  begin
    House := GetRndHouse;
    if House.ToUpper.Contains(SearchText) then
      ListBox1.Items.Add(House);
  end;
  if ListBox1.Count > 0 then
    ListBox1.ItemIndex := 0
  else
    ListBox1.Items.Add('<Sorry, no houses found>');
  ListBox1.SetFocus;
end;

procedure TMainForm.EditSearchKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    DoSearch(EditSearch.Text);
end;

end.
