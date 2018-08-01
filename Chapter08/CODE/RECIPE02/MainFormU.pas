unit MainFormU;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.MobilePreview, FMX.ListView.Types, FMX.ListView, System.Actions,
  FMX.ActnList,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.Controls.Presentation;

type
  TMainForm = class(TForm)
    Header: TToolBar;
    Footer: TToolBar;
    HeaderLabel: TLabel;
    ListView1: TListView;
    ActionList1: TActionList;
    acNew: TAction;
    acDelete: TAction;
    btnDelete: TButton;
    btnNew: TButton;
    procedure FormCreate(Sender: TObject);
    procedure acNewExecute(Sender: TObject);
    procedure acDeleteExecute(Sender: TObject);
    procedure ActionList1Update(Action: TBasicAction; var Handled: Boolean);
    procedure FormSaveState(Sender: TObject);
  private
    FDataFileName: String;
    procedure LoadFromFile;
    procedure SaveToFile;
    procedure AddItem(const TODO: String);
    { Private declarations }
  public

  end;

var
  MainForm: TMainForm;

implementation

uses
  System.IOUtils
{$IF CompilerVersion >= 24}
    , FMX.DialogService
{$ENDIF}
    ;

{$R *.fmx}

procedure TMainForm.acDeleteExecute(Sender: TObject);
begin
  if Assigned(ListView1.Selected) then
    ListView1.Items.Delete(ListView1.Selected.Index);
end;

procedure TMainForm.acNewExecute(Sender: TObject);
begin
{$IF CompilerVersion >= 24}
  // "Berlin" (or better) specific code
  TDialogService.InputQuery('TODO', ['Write your new TODO'], [''],
    procedure(const AResult: TModalResult; const AValues: array of string)
    var
      LValue: string;
    begin
      LValue := AValues[0];
      if (AResult = mrOk) and (LValue.Trim.Length > 0) then
        AddItem(LValue);
    end);
{$ELSE}
  InputQuery('TODO', 'Write your new TODO', '',
    procedure(const AResult: TModalResult; const AValue: string)
    var
      LValue: string;
    begin
      LValue := AValue;
      if (AResult = mrOk) and (LValue.Trim.Length > 0) then
        AddItem(LValue);
    end);
{$ENDIF}
end;

procedure TMainForm.ActionList1Update(Action: TBasicAction;
var Handled: Boolean);
begin
  acDelete.Visible := Assigned(ListView1.Selected);
end;

procedure TMainForm.AddItem(const TODO: String);
var
  LItem: TListViewItem;
begin
  LItem := ListView1.Items.Add;
  LItem.Text := TODO;
  ListView1.ItemIndex := LItem.Index;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FDataFileName := TPath.Combine(TPath.GetDocumentsPath, 'datafile.txt');
  LoadFromFile;
end;

procedure TMainForm.FormSaveState(Sender: TObject);
begin
  SaveToFile;
end;

procedure TMainForm.LoadFromFile;
var
  LFileReader: TStreamReader;
begin
  ListView1.Items.Clear;
  if TFile.Exists(FDataFileName) then
  begin
    LFileReader := TFile.OpenText(FDataFileName);
    try
      while not LFileReader.EndOfStream do
      begin
        AddItem(LFileReader.ReadLine);
      end;
    finally
      LFileReader.Close;
    end;
    ListView1.ItemIndex := -1;
  end;
end;

procedure TMainForm.SaveToFile;
var
  LItem: TListViewItem;
  LFileWriter: TStreamWriter;
begin
  LFileWriter := TFile.CreateText(FDataFileName);
  try
    for LItem in ListView1.Items do
    begin
      LFileWriter.WriteLine(LItem.Text);
    end;
  finally
    LFileWriter.Close;
  end;
end;

end.
