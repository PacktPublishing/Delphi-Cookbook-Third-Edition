unit MainFormU;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  System.Rtti, Data.Bind.GenData,
  Data.Bind.EngExt, FMX.Bind.DBEngExt, FMX.Bind.Grid, System.Bindings.Outputs,
  FMX.Bind.Editors, Data.Bind.Components,
  Data.Bind.Grid, Data.Bind.ObjectScope, FMX.Layouts, FMX.Grid,
  BusinessObjectsU, System.Generics.Collections,
  FMX.Bind.GenData, FMX.ListView.Types, FMX.ListView, FMX.Bind.Navigator,
  FMX.Edit, FMX.ListBox,
  Data.Bind.Controls, FMX.Grid.Style, FMX.Controls.Presentation, FMX.ScrollBox;

type
  TMainForm = class(TForm)
    grdPeople: TGrid;
    bsPeople: TPrototypeBindSource;
    BindingsList1: TBindingsList;
    LinkGridToDataSourcebsPeople: TLinkGridToDataSource;
    grdEmails: TGrid;
    bsEmails: TPrototypeBindSource;
    BindNavigator1: TBindNavigator;
    EditFirstName: TEdit;
    EditLastName: TEdit;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    EditAge: TEdit;
    LinkControlToField3: TLinkControlToField;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    bnEmails: TBindNavigator;
    LinkGridToDataSourcebsEmails: TLinkGridToDataSource;
    procedure bsPeopleCreateAdapter(Sender: TObject;
      var ABindSourceAdapter: TBindSourceAdapter);
    procedure FormCreate(Sender: TObject);
    procedure bsEmailsCreateAdapter(Sender: TObject;
      var ABindSourceAdapter: TBindSourceAdapter);
    procedure bnEmailsBeforeAction(Sender: TObject; Button: TNavigateButton);
    procedure FormDestroy(Sender: TObject);
  private
    FPeople: TObjectList<TPerson>;
    bsPeopleAdapter: TListBindSourceAdapter<TPerson>;
    bsEmailsAdapter: TListBindSourceAdapter<TEmail>;
    procedure PeopleAfterScroll(Adapter: TBindSourceAdapter);
    procedure LoadData;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

uses RandomUtilsU;

procedure TMainForm.bnEmailsBeforeAction(Sender: TObject;
  Button: TNavigateButton);
var
  email: string;
begin
  if Button = TNavigateButton.nbInsert then
    if InputQuery('Email', 'New email address', email) then
    begin
      bsEmailsAdapter.List.Add(TEmail.Create(email));
      bsEmails.Refresh; // refresh the emails list
      bsPeople.Refresh; // refresh the email count in the people grid
      Abort; // inhibit the normal behavior
    end;
end;

procedure TMainForm.bsEmailsCreateAdapter(Sender: TObject;
  var ABindSourceAdapter: TBindSourceAdapter);
begin
  bsEmailsAdapter := TListBindSourceAdapter<TEmail>.Create(self, nil, False);
  ABindSourceAdapter := bsEmailsAdapter;
end;

procedure TMainForm.bsPeopleCreateAdapter(Sender: TObject;
  var ABindSourceAdapter: TBindSourceAdapter);
begin
  bsPeopleAdapter := TListBindSourceAdapter<TPerson>.Create(self, nil, False);
  ABindSourceAdapter := bsPeopleAdapter;
  bsPeopleAdapter.AfterScroll := PeopleAfterScroll;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  Randomize;
  FPeople := TObjectList<TPerson>.Create(True);
  LoadData;
  bsPeopleAdapter.SetList(FPeople, False);
  bsPeople.Active := True;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  FPeople.Free;
end;

procedure TMainForm.LoadData;
var
  I: Integer;
  P: TPerson;
  X: Integer;
begin
  for I := 1 to 100 do
  begin
    // create a random generated person
    P := TPerson.Create(GetRndFirstName, GetRndLastName, 10 + Random(50));

    // add some email addresses (1..3) to the person
    for X := 1 to 1 + Random(3) do
    begin
      P.Emails.Add(TEmail.Create(P.FirstName.ToLower + '.' + P.LastName.ToLower
        + '@' + GetRndCountry.Replace(' ', '').ToLower + '.com'));
    end;
    FPeople.Add(P);
  end;
end;

procedure TMainForm.PeopleAfterScroll(Adapter: TBindSourceAdapter);
begin
  bsEmailsAdapter.SetList(bsPeopleAdapter.List[bsPeopleAdapter.CurrentIndex]
    .Emails, False);
  bsEmails.Active := True;
  bsEmails.First;
end;

end.
