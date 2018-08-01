unit MainFormU;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Graphics, FMX.Forms, FMX.Dialogs, FMX.TabControl,
  System.Actions, FMX.ActnList, FMX.StdCtrls, FMX.MobilePreview,
  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Stan.ExprFuncs,
  FireDAC.FMXUI.Wait, FireDAC.Comp.UI, FireDAC.Phys.SQLite, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FMX.ListView.Types, FMX.ListView, Data.Bind.Components, Data.Bind.DBScope,
  System.Rtti, System.Bindings.Outputs,
  FMX.Bind.Editors, Data.Bind.EngExt, FMX.Bind.DBEngExt, FMX.Layouts, FMX.Memo,
  FMX.Bind.Navigator,
  FireDAC.Phys.SQLiteDef, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ScrollBox, FMX.Controls.Presentation;

type
  TMainForm = class(TForm)
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    TopToolBar: TToolBar;
    ToolBarLabel: TLabel;
    TopToolBar1: TToolBar;
    ToolBarLabel1: TLabel;
    btnBack: TButton;
    ActionList1: TActionList;
    ChangeTabAction1: TChangeTabAction;
    ChangeTabAction2: TChangeTabAction;
    BottomToolBar: TToolBar;
    btnNext: TSpeedButton;
    Connection: TFDConnection;
    qryTODOs: TFDQuery;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    ListView1: TListView;
    bsTODO: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    qryTODOsID: TFDAutoIncField;
    qryTODOsDESCRIPTION: TStringField;
    qryTODOsDONE: TIntegerField;
    Label1: TLabel;
    memToDoText: TMemo;
    lblCompleted: TLabel;
    LinkControlToField2: TLinkControlToField;
    swtCompleted: TSwitch;
    LinkControlToField1: TLinkControlToField;
    LinkPropertyToFieldText: TLinkPropertyToField;
    Button1: TButton;
    Button2: TButton;
    LiveBindingsBindNavigateDelete1: TFMXBindNavigateDelete;
    acNew: TAction;
    Layout1: TLayout;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure ConnectionBeforeConnect(Sender: TObject);
    procedure ConnectionAfterConnect(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure acNewExecute(Sender: TObject);
    procedure ListView1ItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure ChangeTabAction1Update(Sender: TObject);
    procedure acNewUpdate(Sender: TObject);
    procedure ActionList1Update(Action: TBasicAction; var Handled: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses
  System.IOUtils;

{$R *.fmx}

procedure TMainForm.acNewExecute(Sender: TObject);
begin
  qryTODOs.Append;
  qryTODOsDONE.Value := 0;
  ChangeTabAction1.ExecuteTarget(Self);
end;

procedure TMainForm.acNewUpdate(Sender: TObject);
begin
  acNew.Enabled := TabControl1.ActiveTab = TabItem1;
end;

procedure TMainForm.ActionList1Update(Action: TBasicAction;
  var Handled: Boolean);
begin
  if qryTODOs.State = dsInsert then
    ToolBarLabel1.Text := 'New TODO'
  else
    ToolBarLabel1.Text := 'TODO details';
end;

procedure TMainForm.ChangeTabAction1Update(Sender: TObject);
begin
  ChangeTabAction1.Enabled := not bsTODO.DataSet.Eof;
end;

procedure TMainForm.ConnectionAfterConnect(Sender: TObject);
begin
  Connection.ExecSQL('CREATE TABLE IF NOT EXISTS TODOS( ' +
    ' ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, ' +
    ' DESCRIPTION    CHAR(50) NOT NULL, ' +
    ' DONE           INTEGER  NOT NULL  ' + ')');
  qryTODOs.Active := True;
end;

procedure TMainForm.ConnectionBeforeConnect(Sender: TObject);
begin
{$IF DEFINED(IOS) or DEFINED(ANDROID)}
  Connection.Params.Values['Database'] := TPath.GetDocumentsPath + PathDelim +
    'todos.sdb';
{$ENDIF}
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if not(qryTODOs.State = dsBrowse) then
    qryTODOs.Post;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  Connection.Connected := True;
  { This defines the default active tab at runtime }
  TabControl1.ActiveTab := TabItem1;
{$IFDEF ANDROID}
  { This hides the toolbar back button on Android }
  btnBack.Visible := False;
{$ENDIF}
end;

procedure TMainForm.FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkHardwareBack then
  begin
    if TabControl1.ActiveTab = TabItem2 then
    begin
      ChangeTabAction1.Tab := TabItem1;
      ChangeTabAction1.ExecuteTarget(Self);
      ChangeTabAction1.Tab := TabItem2;
      Key := 0;
    end;
  end;
end;

procedure TMainForm.ListView1ItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
  ChangeTabAction1.ExecuteTarget(Self);
end;

end.
