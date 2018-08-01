unit MainFormU;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.MobilePreview, FMX.Objects, FMX.ExtCtrls, FMX.ListBox, FMX.Layouts, FMX.Ani, FMX.Effects, FMX.Filter.Effects,
  System.Generics.Collections, System.Actions, FMX.ActnList, FMX.StdActns, FMX.MediaLibrary.Actions, FMX.ListView.Types,
  FMX.ListView, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.Controls.Presentation;

type
  TMainForm = class(TForm)
    Header: TToolBar;
    HeaderLabel: TLabel;
    Image1: TImage;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    btnEffects: TButton;
    EmbossEffect1: TEmbossEffect;
    RadialBlurEffect1: TRadialBlurEffect;
    ContrastEffect1: TContrastEffect;
    ColorKeyAlphaEffect1: TColorKeyAlphaEffect;
    InvertEffect1: TInvertEffect;
    ActionList1: TActionList;
    TakePhotoFromCameraAction1: TTakePhotoFromCameraAction;
    ShowShareSheetAction1: TShowShareSheetAction;
    Label1: TLabel;
    SepiaEffect1: TSepiaEffect;
    TilerEffect1: TTilerEffect;
    PixelateEffect1: TPixelateEffect;
    ToonEffect1: TToonEffect;
    PaperSketchEffect1: TPaperSketchEffect;
    PencilStrokeEffect1: TPencilStrokeEffect;
    RippleEffect1: TRippleEffect;
    WaveEffect1: TWaveEffect;
    WrapEffect1: TWrapEffect;
    InnerGlowEffect1: TInnerGlowEffect;
    TakePhotoFromLibraryAction1: TTakePhotoFromLibraryAction;
    Button4: TButton;
    lvEffects: TListView;
    procedure btnEffectsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TakePhotoFromCameraAction1DidFinishTaking(Image: TBitmap);
    procedure ShowShareSheetAction1BeforeExecute(Sender: TObject);
    procedure lvEffectsItemClick(const Sender: TObject; const AItem: TListViewItem);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TakePhotoFromLibraryAction1DidFinishTaking(Image: TBitmap);
  private
    FItemsEffectsMap: TDictionary<Integer, TFilterEffect>;
    FUndoEffectsList: TObjectStack<TFilterEffect>;
    FUndoEffectItem: TListViewItem;
    FTopWhenShown: Extended;
    procedure LoadPhoto(AImage: TBitmap);
    procedure RecalcMenuPosition;
    procedure RemoveCurrentEffect(ARemoveFromList: boolean);
    function EffectNameByClassName(const AClassName: string): string;
  end;

var
  MainForm: TMainForm;

implementation

uses
  System.RegularExpressions;

{$R *.fmx}


procedure TMainForm.btnEffectsClick(Sender: TObject);
begin
  if FUndoEffectsList.Count = 0 then
    FUndoEffectItem.Text := '<No effect to undo>'
  else
    FUndoEffectItem.Text := '[Undo ' + EffectNameByClassName(FUndoEffectsList.Peek.ClassName) + ']';
  TAnimator.AnimateFloat(lvEffects, 'Position.Y', FTopWhenShown,
    0.4, TAnimationType.Out, TInterpolationType.Back);
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  eff: TFmxObject;
  lbi: TListViewItem;
begin
  FItemsEffectsMap := TDictionary<Integer, TFilterEffect>.Create;
  FUndoEffectsList := TObjectStack<TFilterEffect>.Create(False);
  lvEffects.Position.Y := -lvEffects.Height;
  lvEffects.BeginUpdate;
  try
    FUndoEffectItem := lvEffects.Items.Add;
    FUndoEffectItem.Text := 'Undo';

    for eff in Children do
    begin
      if eff is TFilterEffect then
      begin
        lbi := lvEffects.Items.Add;
        lbi.Text := EffectNameByClassName(eff.ClassName);
        FItemsEffectsMap.Add(lbi.Index, TFilterEffect(eff));
      end;
    end;
  finally
    lvEffects.EndUpdate;
  end;
end;

procedure TMainForm.FormResize(Sender: TObject);
begin
  RecalcMenuPosition;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  RecalcMenuPosition;
end;

procedure TMainForm.lvEffectsItemClick(const Sender: TObject; const AItem: TListViewItem);
begin
  TAnimator.AnimateFloatDelay(
    lvEffects, 'Position.Y', -lvEffects.Height, 0.3, 0.1,
    TAnimationType.&In, TInterpolationType.Back);

  if AItem = FUndoEffectItem then // undo and revert to the previous one
  begin
    RemoveCurrentEffect(true);
    if FUndoEffectsList.Count > 0 then
      Image1.AddObject(FUndoEffectsList.Peek);
  end
  else
  begin // apply new effect
    RemoveCurrentEffect(False);
    FUndoEffectsList.Push(FItemsEffectsMap[AItem.Index]);
    Image1.AddObject(FUndoEffectsList.Peek);
  end;
end;

procedure TMainForm.LoadPhoto(AImage: TBitmap);
begin
  Label1.Text := '';
  RemoveCurrentEffect(False);
  FUndoEffectsList.Clear;
  Image1.Bitmap.Assign(AImage);
end;

procedure TMainForm.RecalcMenuPosition;
begin
  FTopWhenShown := ClientHeight / 2 - lvEffects.Height / 2;
  lvEffects.Height := ClientHeight / 2;
  lvEffects.Position.X := ClientWidth / 2 - lvEffects.Width / 2;
end;

procedure TMainForm.RemoveCurrentEffect(ARemoveFromList: boolean);
begin
  if FUndoEffectsList.Count = 0 then
    Exit;
  Image1.RemoveObject(FUndoEffectsList.Peek);
  if ARemoveFromList then
    FUndoEffectsList.Pop;
  //Image1.Repaint;
end;

function TMainForm.EffectNameByClassName(const AClassName: string): string;
begin
  Result := AClassName.Substring(1);
  Result := TRegEx.Replace(Result, '[A-Z]', ' $0').TrimLeft;
end;

procedure TMainForm.ShowShareSheetAction1BeforeExecute(Sender: TObject);
begin
  if FUndoEffectsList.Count > 0 then
  begin
    FUndoEffectsList.Peek.ProcessEffect(nil, Image1.Bitmap, 0);
  end;
  ShowShareSheetAction1.Bitmap.Assign(Image1.Bitmap);
end;

procedure TMainForm.TakePhotoFromCameraAction1DidFinishTaking(Image: TBitmap);
begin
  LoadPhoto(Image);
end;

procedure TMainForm.TakePhotoFromLibraryAction1DidFinishTaking(Image: TBitmap);
begin
  LoadPhoto(Image);
end;

end.
