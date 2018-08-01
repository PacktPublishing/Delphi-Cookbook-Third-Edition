unit MainFormU;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Graphics, FMX.Forms, FMX.Dialogs, FMX.TabControl,
  System.Actions,
  FMX.ActnList,
  FMX.Objects, FMX.StdCtrls, FMX.ListView.Types, FMX.ListView, System.Rtti,
  System.Bindings.Outputs, FMX.Bind.Editors, Data.Bind.EngExt,
  FMX.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope, FMX.Edit,
  FMX.Bind.Navigator, FMX.Layouts, FMX.Menus, FMX.Effects, FMX.Ani,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.Controls.Presentation;

type
  TMainForm = class(TForm)
    ActionList1: TActionList;
    PreviousTabAction1: TPreviousTabAction;
    TitleAction: TControlAction;
    NextTabAction1: TNextTabAction;
    TopToolBar: TToolBar;
    btnBack: TSpeedButton;
    ToolBarLabel: TLabel;
    btnNext: TSpeedButton;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    BottomToolBar: TToolBar;
    ListViewPeople: TListView;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    EditFirstName: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    EditLastName: TEdit;
    Label3: TLabel;
    EditWorkNumber: TEdit;
    Label4: TLabel;
    EditMobileNumber: TEdit;
    Label5: TLabel;
    EditEmail: TEdit;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    LinkControlToField3: TLinkControlToField;
    LinkControlToField4: TLinkControlToField;
    LinkControlToField5: TLinkControlToField;
    acRefreshData: TAction;
    Button3: TButton;
    acSavePerson: TAction;
    LiveBindingsBindNavigateCancel1: TFMXBindNavigateCancel;
    AniIndicator1: TAniIndicator;
    acDeletePerson: TAction;
    GridLayout1: TGridLayout;
    Button1: TButton;
    Button2: TButton;
    Layout1: TLayout;
    Button4: TButton;
    Button5: TButton;
    acNewPerson: TAction;
    acWaiting: TControlAction;
    ppMessage: TPopup;
    Rectangle1: TRectangle;
    ShadowEffect1: TShadowEffect;
    lblMessage: TLabel;
    ppError: TPopup;
    Rectangle2: TRectangle;
    ShadowEffect2: TShadowEffect;
    lblError: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure PreviousTabAction1Update(Sender: TObject);
    procedure TitleActionUpdate(Sender: TObject);
    procedure NextTabAction1Update(Sender: TObject);
    procedure acRefreshDataExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure acSavePersonExecute(Sender: TObject);
    procedure acSavePersonUpdate(Sender: TObject);
    procedure acDeletePersonExecute(Sender: TObject);
    procedure acNewPersonExecute(Sender: TObject);
    procedure ListViewPeopleItemClick(const Sender: TObject;
      const AItem: TListViewItem);
  private
    FBackgroundOperationRunning: Boolean;
    procedure DoStartWait(AWaitMessage: String = 'Please wait...');
    procedure DoEndWait;
    procedure ShowError(const AMessage: String);
    procedure SetBackgroundOperationRunning(const Value: Boolean);
    property BackgroundOperationRunning: Boolean
      read FBackgroundOperationRunning write SetBackgroundOperationRunning;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

uses FMX.Platform, MainDMU;

procedure TMainForm.TitleActionUpdate(Sender: TObject);
begin
  if Sender is TCustomAction then
  begin
    if TabControl1.ActiveTab <> nil then
      TCustomAction(Sender).Text := TabControl1.ActiveTab.Text
    else
      TCustomAction(Sender).Text := '';
  end;
end;

procedure TMainForm.acDeletePersonExecute(Sender: TObject);
begin
  DoStartWait;
  dmMain.DeletePerson(
    procedure
    begin
      DoEndWait;
      PreviousTabAction1.ExecuteTarget(Self);
    end,
    procedure(StatusCode: Integer; StatusText: String)
    begin
      DoEndWait;
      ShowError(Format('Error [%d]: %s', [StatusCode, StatusText]));
    end);
end;

procedure TMainForm.acNewPersonExecute(Sender: TObject);
begin
  dmMain.dsPeople.Append;
  NextTabAction1.ExecuteTarget(Self);
end;

procedure TMainForm.acRefreshDataExecute(Sender: TObject);
begin
  DoStartWait('Please wait while retrieving the people list');
  dmMain.LoadAll(
    procedure
    begin
      DoEndWait;
    end,
    procedure(StatusCode: Integer; StatusText: String)
    begin
      DoEndWait;
      ShowError(Format('Error [%d]: %s', [StatusCode, StatusText]));
    end);
end;

procedure TMainForm.acSavePersonExecute(Sender: TObject);
begin
  DoStartWait('Saving changes');
  dmMain.SavePerson(
    procedure
    begin
      DoEndWait;
      PreviousTabAction1.ExecuteTarget(Self);
    end,
    procedure(StatusCode: Integer; StatusText: String)
    begin
      DoEndWait;
      ShowError(Format('Error [%d]: %s', [StatusCode, StatusText]));
    end);
end;

procedure TMainForm.acSavePersonUpdate(Sender: TObject);
begin
  (Sender as TCustomAction).Enabled := dmMain.CanSave;
end;

procedure TMainForm.DoEndWait;
begin
  BackgroundOperationRunning := False;
end;

procedure TMainForm.DoStartWait(AWaitMessage: String);
begin
  lblMessage.Text := AWaitMessage;
  BackgroundOperationRunning := True;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  { This defines the default active tab at runtime }
  TabControl1.First(TTabTransition.None);
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  acRefreshData.Execute;
end;

procedure TMainForm.ListViewPeopleItemClick(const Sender: TObject;
const AItem: TListViewItem);
begin
  NextTabAction1.ExecuteTarget(Self);
end;

procedure TMainForm.NextTabAction1Update(Sender: TObject);
begin
  if Sender is TCustomAction then
    TCustomAction(Sender).Visible := TabControl1.ActiveTab = TabItem1;
end;

procedure TMainForm.PreviousTabAction1Update(Sender: TObject);
begin
{$IFDEF ANDROID}
  if Sender is TCustomAction then
    TCustomAction(Sender).Visible := False;
{$ENDIF}
end;

procedure TMainForm.SetBackgroundOperationRunning(const Value: Boolean);
begin
  FBackgroundOperationRunning := Value;
  acRefreshData.Enabled := not FBackgroundOperationRunning;
  AniIndicator1.Visible := FBackgroundOperationRunning;
  TabItem1.Enabled := not FBackgroundOperationRunning;
  ppMessage.IsOpen := FBackgroundOperationRunning;
end;

procedure TMainForm.ShowError(const AMessage: String);
begin
  lblError.Text := AMessage;
  ppError.IsOpen := True;
end;

end.
