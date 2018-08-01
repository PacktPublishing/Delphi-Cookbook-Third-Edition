unit MainForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Rtti, System.Classes,
  System.Variants, FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.Ani,
  FMX.Objects, FMX.Effects, FMX.Filter.Effects;

type
  TDualListForm = class(TForm)
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    ShadowEffect1: TShadowEffect;
    ShadowEffect2: TShadowEffect;
    ShadowEffect3: TShadowEffect;
    LeftRect: TRectangle;
    RightRect: TRectangle;
    ShadowEffect4: TShadowEffect;
    procedure Image1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    FLeftLimit: Single;
    FRightLimit: Single;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DualListForm: TDualListForm;

implementation

{$R *.fmx}

procedure TDualListForm.FormCreate(Sender: TObject);
begin
  FLeftLimit := LeftRect.ParentedRect.CenterPoint.X - Image1.Width / 2;
  FRightLimit := RightRect.ParentedRect.CenterPoint.X - Image1.Width / 2;
end;

procedure TDualListForm.Image1Click(Sender: TObject);
var
  LImage: TImage;
begin
  LImage := (Sender as TImage);

  if LImage.Tag = 0 then
  begin
    LImage.Tag := 1;
    TAnimator.AnimateFloat(LImage, 'Position.X', FRightLimit, 0.8,
      TAnimationType.Out, TInterpolationType.Elastic)
  end
  else
  begin
    LImage.Tag := 0;
    TAnimator.AnimateFloat(LImage, 'Position.X', FLeftLimit, 0.8,
      TAnimationType.Out, TInterpolationType.Elastic);
  end;

  TAnimator.AnimateFloatDelay(LImage, 'Scale.X', 1.2, 0.2, 0.2);
  TAnimator.AnimateFloatDelay(LImage, 'Scale.Y', 1.2, 0.2, 0.2);

  TAnimator.AnimateFloatDelay(LImage, 'Scale.X', 1, 0.2, 1);
  TAnimator.AnimateFloatDelay(LImage, 'Scale.Y', 1, 0.2, 1);
end;

end.
