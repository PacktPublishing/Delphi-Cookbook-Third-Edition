unit MainRegExForm;

interface

uses
  Vcl.Forms, Vcl.StdCtrls, Vcl.CheckLst, Vcl.Controls,
  System.Classes, System.RegularExpressions;

type
  TRegExForm = class(TForm)
    Button1: TButton;
    edtRegEx: TEdit;
    Memo1: TMemo;
    Memo2: TMemo;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    CheckListBox1: TCheckListBox;
    ListBox1: TListBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    function InString: String;
    function InRegEx: String;
    function GetOptions: TRegExOptions;
  public
    { Public declarations }
  end;

var
  RegExForm: TRegExForm;

implementation

{$R *.dfm}


uses
  System.SysUtils;

procedure TRegExForm.Button1Click(Sender: TObject);
begin
  Memo2.Text := BoolToStr(TRegEx.IsMatch(InString, InRegEx, GetOptions), true);
end;

procedure TRegExForm.Button3Click(Sender: TObject);
var
  matchcollection: TMatchCollection;
  m: TMatch;
begin
  Memo2.Clear;
  matchcollection := TRegEx.Matches(InString, InRegEx, GetOptions);
  for m in matchcollection do
    Memo2.Lines.Add(m.Value);
end;

procedure TRegExForm.Button4Click(Sender: TObject);
var
  ss: TArray<string>;
  s: string;
begin
  Memo2.Clear;
  ss := TRegEx.Split(InString, InRegEx, GetOptions);
  for s in ss do
    Memo2.Lines.Add(s);
end;

procedure TRegExForm.Button5Click(Sender: TObject);
var
  reg: TRegEx;
begin
  reg := TRegEx.Create(InRegEx, GetOptions);
  Memo2.Text := reg.Replace(InString, 'XXX');
end;

function TRegExForm.GetOptions: TRegExOptions;
var
  i: Integer;
begin
  Result := [];
  for i := 0 to CheckListBox1.Items.Count - 1 do
    if CheckListBox1.Checked[i] then
      Include(Result, TRegExOption(i));
end;

function TRegExForm.InRegEx: String;
begin
  Result := edtRegEx.Text;
end;

function TRegExForm.InString: String;
begin
  Result := Memo1.Text;
end;

procedure TRegExForm.ListBox1DblClick(Sender: TObject);
begin
  edtRegEx.Text := ListBox1.Items[ListBox1.ItemIndex];
end;

end.
