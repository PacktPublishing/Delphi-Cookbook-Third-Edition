unit MainFormU;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.ComCtrls,
  Vcl.Menus,
  EmbeddableFormU, Vcl.AppEvnts;

type
  TMainForm = class(TForm)
    TabControl1: TTabControl;
    Panel1: TPanel;
    MainMenu1: TMainMenu;
    MenuProducts: TMenuItem;
    MenuOrders: TMenuItem;
    MenuSales: TMenuItem;
    MenuInvoices: TMenuItem;
    Exit1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    PopupMenu1: TPopupMenu;
    Close1: TMenuItem;
    StatusBar1: TStatusBar;
    ApplicationEvents1: TApplicationEvents;
    procedure MenuOrdersClick(Sender: TObject);
    procedure TabControl1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Close1Click(Sender: TObject);
    procedure MenuSalesClick(Sender: TObject);
    procedure ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
    procedure Exit1Click(Sender: TObject);
    procedure MenuInvoicesClick(Sender: TObject);
    procedure ApplicationEvents1Hint(Sender: TObject);
  private
    FCurrentForm: TEmbeddableForm;
    procedure ResizeTabsWidth;
    procedure AddForm(AEmbeddableForm: TEmbeddableForm);
    procedure ShowForm(AEmbeddableForm: TEmbeddableForm); overload;
    procedure ShowForm(AEmbeddableFormIndex: Integer); overload;
    function GetIndexByForm(AEmbeddableForm: TEmbeddableForm): Integer;
  public
    procedure WMEmbeddedFormClose(var Msg: TMessage); message WM_EMBEDDED_FORM_CLOSE;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}


uses
  Form1U, Form2U, Form3U,
  System.Math;

procedure TMainForm.AddForm(AEmbeddableForm: TEmbeddableForm);
begin
  AEmbeddableForm.Show(Panel1);
  TabControl1.Tabs.AddObject(AEmbeddableForm.Caption, AEmbeddableForm);
  ResizeTabsWidth;
  ShowForm(AEmbeddableForm);
end;

procedure TMainForm.ShowForm(AEmbeddableForm: TEmbeddableForm);
begin
  TabControl1.TabIndex := GetIndexByForm(AEmbeddableForm);
  AEmbeddableForm.BringToFront;
  FCurrentForm := AEmbeddableForm;
end;

procedure TMainForm.WMEmbeddedFormClose(var Msg: TMessage);
var
  ChildForm: TEmbeddableForm;
  NextFormToShow: Integer;
  Idx: Integer;
begin
  ChildForm := TObject(Pointer(Msg.WParam)) as TEmbeddableForm;
  ChildForm.ParentWantClose := True;
  Idx := GetIndexByForm(ChildForm);
  if Idx > -1 then
  begin
    ChildForm.Close;
    TabControl1.Tabs.Delete(Idx);
    if TabControl1.Tabs.Count > 0 then
    begin
      NextFormToShow := IfThen(Idx <= 1, 0, Idx - 1);
      ShowForm(NextFormToShow);
      ResizeTabsWidth;
    end
    else
      FCurrentForm := nil;
  end;
end;

procedure TMainForm.ApplicationEvents1Hint(Sender: TObject);
begin
  StatusBar1.Panels[1].Text := Application.Hint;
end;

procedure TMainForm.ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
begin
  if Assigned(FCurrentForm) then
    StatusBar1.Panels[0].Text := FCurrentForm.StatusText
  else
    StatusBar1.Panels[0].Text := Caption;

end;

procedure TMainForm.Close1Click(Sender: TObject);
begin
  Perform(WM_EMBEDDED_FORM_CLOSE, NativeUInt(TabControl1.Tabs.Objects[TabControl1.TabIndex]), 0);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  TabControl1.TabHeight := TabControl1.Height - GetSystemMetrics(SM_CXBORDER) * 4;
end;

function TMainForm.GetIndexByForm(AEmbeddableForm: TEmbeddableForm): Integer;
var
  i: Integer;
begin
  for i := 0 to TabControl1.Tabs.Count - 1 do
    if AEmbeddableForm = TabControl1.Tabs.Objects[i] then
      Exit(i);
  Result := -1;
end;

procedure TMainForm.MenuOrdersClick(Sender: TObject);
begin
  AddForm(TForm1.Create(self));
end;

procedure TMainForm.MenuSalesClick(Sender: TObject);
begin
  AddForm(TForm2.Create(self));
end;

procedure TMainForm.MenuInvoicesClick(Sender: TObject);
begin
  AddForm(TForm3.Create(self));
end;

procedure TMainForm.Exit1Click(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.ResizeTabsWidth;
var
  MaxWidth, i: Integer;
begin
  MaxWidth := 0;
  for i := 0 to TabControl1.Tabs.Count - 1 do
    MaxWidth := Max(MaxWidth, TabControl1.Canvas.TextWidth(TEmbeddableForm(TabControl1.Tabs.Objects[i]).Caption));
  TabControl1.TabWidth := Max(80, Trunc(MaxWidth * 1.2));
end;

procedure TMainForm.ShowForm(AEmbeddableFormIndex: Integer);
begin
  ShowForm(TabControl1.Tabs.Objects[AEmbeddableFormIndex] as TEmbeddableForm);
  TabControl1.TabIndex := AEmbeddableFormIndex;
end;

procedure TMainForm.TabControl1Change(Sender: TObject);
var
  f: TEmbeddableForm;
begin
  f := (TabControl1.Tabs.Objects[TabControl1.TabIndex] as TEmbeddableForm);
  ShowForm(f);
end;

end.
