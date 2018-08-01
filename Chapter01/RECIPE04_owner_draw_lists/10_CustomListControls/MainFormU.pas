unit MainFormU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ImgList,
  System.ImageList;

type
  TMainForm = class(TForm)
    ListBox1: TListBox;
    ImageList1: TImageList;
    procedure ListBox1DrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.ListBox1DrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
var
  LBox: TListBox;
  R: TRect;
  S: string;
  TextTopPos, TextLeftPos, TextHeight: Integer;
const
  IMAGE_TEXT_SPACE = 5;
begin
  LBox := Control as TListBox;
  R := Rect;
  LBox.Canvas.FillRect(R);
  ImageList1.Draw(LBox.Canvas, R.Left, R.Top, Index);
  S := LBox.Items[Index];
  TextHeight := LBox.Canvas.TextHeight(S);
  TextLeftPos := R.Left + ImageList1.Width + IMAGE_TEXT_SPACE;
  TextTopPos := R.Top + R.Height div 2 - TextHeight div 2;
  LBox.Canvas.TextOut(TextLeftPos, TextTopPos, S);
end;

end.
