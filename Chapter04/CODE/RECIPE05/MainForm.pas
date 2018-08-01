unit MainForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Rtti, System.Classes,
  System.Variants, FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.Objects,
  FMX.Layouts,
  FMX.Memo, FMX.StdCtrls;

type
  TForm4 = class(TForm)
    Path1: TPath;
    Button1: TButton;
    Memo1: TMemo;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

{$R *.fmx}

procedure TForm4.Button1Click(Sender: TObject);
begin
  Path1.Data.Data := Memo1.Lines.Text;
end;

procedure TForm4.Button2Click(Sender: TObject);
begin
  Path1.Data.Clear;
  Path1.Data.MoveTo(PointF(0, 0));
  Path1.Data.LineTo(PointF(100, 100));
  Path1.Data.LineTo(PointF(0, 200));
  Path1.Data.ClosePath;
  Memo1.Lines.Text := Path1.Data.Data;

end;

procedure TForm4.Button3Click(Sender: TObject);
begin
  Path1.Data.Clear;
  Path1.Data.MoveTo(PointF(0, 0));
  Path1.Data.SmoothCurveTo(PointF(100, 75), PointF(100, 100));
  Path1.Data.SmoothCurveTo(PointF(100, 100), PointF(0, 200));
  Path1.Data.ClosePath;
  Memo1.Lines.Text := Path1.Data.Data;
end;

procedure TForm4.Button4Click(Sender: TObject);
begin
  Path1.Data.Data := 'M0,0 C50,0 50,100 100,100';
  Memo1.Lines.Text := Path1.Data.Data;
end;

procedure TForm4.Button5Click(Sender: TObject);
var
  v: string;
begin
  v := InputBox('Text to Path', 'Write a text', 'Daniele');
  Path1.Data.Clear;
  Path1.Canvas.TextToPath(Path1.Data, RectF(0, 0, 100, 50), v, false,
    TTextAlign.taLeading);
  Memo1.Lines.Text := Path1.Data.Data;
  Memo1.Repaint;

end;

procedure TForm4.Button6Click(Sender: TObject);
begin
//  Image1.Canvas.DrawBitmap(Path1.Canvas.Bitmap, RectF(0,0,100,100), RectF(0,0,100,100), 1);
end;

end.
