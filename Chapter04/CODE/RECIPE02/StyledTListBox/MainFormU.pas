unit MainFormU;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.ListBox,
  FMX.ListView.Types, FMX.ListView, FMX.Controls.Presentation;

type
  TForm1 = class(TForm)
    ListBox1: TListBox;
    btnNormal: TButton;
    btnHint: TButton;
    btnWarning: TButton;
    StyleBook1: TStyleBook;
    btnError: TButton;
    procedure btnNormalClick(Sender: TObject);
    procedure btnHintClick(Sender: TObject);
    procedure btnWarningClick(Sender: TObject);
    procedure btnErrorClick(Sender: TObject);
  private
    procedure AddEvent(EventType: String; EventText: String);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.AddEvent(EventType, EventText: String);
var
  LBItem: TListBoxItem;
begin
  LBItem := TListBoxItem.Create(ListBox1);
  LBItem.Parent := ListBox1;
  if EventType.Equals('normal') then
  begin
    LBItem.Text := EventText;
  end
  else
  begin
    LBItem.StyleLookup := EventType + 'listboxitem';
    LBItem.StylesData['eventtext'] := EventText;
  end;
  ListBox1.AddObject(LBItem);
end;

procedure TForm1.btnNormalClick(Sender: TObject);
begin
  AddEvent('normal', 'This is a normal event');
end;

procedure TForm1.btnHintClick(Sender: TObject);
begin
  AddEvent('hint', 'This is an HINT');
end;

procedure TForm1.btnWarningClick(Sender: TObject);
begin
  AddEvent('warning', 'WARNING! This is a WARNING!');
end;

procedure TForm1.btnErrorClick(Sender: TObject);
begin
  AddEvent('error', 'ERROR! This is an ERROR!');
end;

end.
