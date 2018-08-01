unit MainFormU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls;

type
  TMainForm = class(TForm)
    btnProgress: TButton;
    tdProgress: TTaskDialog;
    btnConfirm: TButton;
    tdConfirm: TTaskDialog;
    btnSimple: TButton;
    tdSimple: TTaskDialog;
    btnRadio: TButton;
    tdRadioButtons: TTaskDialog;
    btnAPI: TButton;
    btnCheckWinVer: TButton;
    procedure tdProgressTimer(Sender: TObject; TickCount: Cardinal;
      var Reset: Boolean);
    procedure btnProgressClick(Sender: TObject);
    procedure tdProgressButtonClicked(Sender: TObject;
      ModalResult: TModalResult; var CanClose: Boolean);
    procedure btnConfirmClick(Sender: TObject);
    procedure btnSimpleClick(Sender: TObject);
    procedure btnRadioClick(Sender: TObject);
    procedure btnAPIClick(Sender: TObject);
    procedure btnCheckWinVerClick(Sender: TObject);
  private
    FCurrNumber, FPrimeNumbersCount: Integer;
    FFinished: Boolean;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses PrimeNumbers, System.IOUtils, Winapi.ShellAPI, Vcl.Themes,
  Winapi.CommCtrl {required by the TaskDialog API};

const
  MAX_NUMBERS = 1000;
  NUMBERS_IN_A_SINGLE_STEP = 50;

procedure TMainForm.btnProgressClick(Sender: TObject);
begin
  FCurrNumber := 1;
  FFinished := False;
  FPrimeNumbersCount := 0;
  tdProgress.ProgressBar.Position := 0;
  tdProgress.OnTimer := tdProgressTimer;
  tdProgress.Execute;
end;

procedure TMainForm.tdProgressButtonClicked(Sender: TObject;
  ModalResult: TModalResult; var CanClose: Boolean);
begin
  if not FFinished then
  begin
    tdProgress.OnTimer := nil;
    ShowMessage('Calculation aborted by user');
    CanClose := True;
  end;
end;

procedure TMainForm.tdProgressTimer(Sender: TObject; TickCount: Cardinal;
  var Reset: Boolean);
var
  I: Integer;
begin
  for I := 1 to NUMBERS_IN_A_SINGLE_STEP do
  begin
    if IsPrimeNumber(FCurrNumber) then
      Inc(FPrimeNumbersCount);
    tdProgress.ProgressBar.Position := FCurrNumber * 100 div MAX_NUMBERS;
    Inc(FCurrNumber);
  end;

  FFinished := FCurrNumber >= MAX_NUMBERS;
  if FFinished then
  begin
    tdProgress.OnTimer := nil;
    tdProgress.ProgressBar.Position := 100;
    ShowMessage('There are ' + FPrimeNumbersCount.ToString +
      ' prime numbers up to ' + MAX_NUMBERS.ToString);
  end;
end;

procedure TMainForm.btnConfirmClick(Sender: TObject);
var
  LFileName: string;
  LGSearch: String;
const
  GOOGLE_SEARCH = 99;
begin
  LFileName := 'MyCoolProgram.exe';
  tdConfirm.Buttons.Clear;
  tdConfirm.Title := 'Confirm Removal';
  tdConfirm.Caption := 'My fantastic folder';
  tdConfirm.Text :=
    Format('Are you sure that you want to remove the file named "%s"?',
    [LFileName]);
  tdConfirm.CommonButtons := [];
  with TTaskDialogButtonItem(tdConfirm.Buttons.Add) do
  begin
    Caption := 'Remove';
    CommandLinkHint := Format('Delete file %s from the folder.', [LFileName]);
    ModalResult := mrYes;
  end;
  with TTaskDialogButtonItem(tdConfirm.Buttons.Add) do
  begin
    Caption := 'Keep';
    CommandLinkHint := 'Keep the file in the folder.';
    ModalResult := mrNo;
  end;

  if TPath.GetExtension(LFileName).ToLower.Equals('.exe') then
    with TTaskDialogButtonItem(tdConfirm.Buttons.Add) do
    begin
      Caption := 'Google search';
      CommandLinkHint := 'Let''s Google tell us what this program is.';
      ModalResult := GOOGLE_SEARCH;
    end;
  tdConfirm.Flags := [tfUseCommandLinks];
  tdConfirm.MainIcon := tdiInformation;
  if tdConfirm.Execute then
  begin
    case tdConfirm.ModalResult of
      mrYes:
        ShowMessage('Deleted');
      mrNo:
        ShowMessage(LFileName + 'has been preserved');
      GOOGLE_SEARCH:
        begin
          LGSearch := Format('https://www.google.it/#q=%s', [LFileName]);
          ShellExecute(0, 'open', PChar(LGSearch), nil, nil, SW_SHOWNORMAL);
        end;
    end;
  end;
end;

procedure TMainForm.btnSimpleClick(Sender: TObject);
begin
  tdSimple.Execute;
  if tdSimple.ModalResult = mrYes then
    ShowMessage('yes')
  else
    ShowMessage('no')
end;

procedure TMainForm.btnCheckWinVerClick(Sender: TObject);
var
  LTaskDialog: TTaskDialog;
begin
  if (Win32MajorVersion >= 6) and ThemeServices.ThemesEnabled then
  begin
    LTaskDialog := TTaskDialog.Create(Self);
    try
      LTaskDialog.Caption := 'MY Fantastic Application';
      LTaskDialog.Title := 'The Cook Task Dialog!';
      LTaskDialog.Text :=
        'This is a Task Dialog, so I''m on Vista or better with themes enabled';
      LTaskDialog.CommonButtons := [tcbOk];
      LTaskDialog.Execute;
    finally
      LTaskDialog.Free;
    end
  end
  else
  begin
    ShowMessage('This is an old and boring ShowMEssage, ' +
      'here only to support old Microsoft Windows OS (XP and below)');
  end;
end;

procedure TMainForm.btnRadioClick(Sender: TObject);
begin
  tdRadioButtons.Execute;
  if tdRadioButtons.ModalResult = mrOk then
    ShowMessage('Selected radio button ' +
      tdRadioButtons.RadioButton.ID.ToString);
end;

procedure TMainForm.btnAPIClick(Sender: TObject);
var
  LTDResult: Integer;
begin
  TaskDialog(0, HInstance, PChar('The Title'),
    PChar('These are the main instructions'), PChar('This is another content'),
    TDCBF_OK_BUTTON or TDCBF_CANCEL_BUTTON, TD_INFORMATION_ICON, @LTDResult);
  case LTDResult of
    IDOK:
      begin
        ShowMessage('Clicked OK');
      end;
    IDCANCEL:
      begin
        ShowMessage('Clicked Cancel');
      end;
  end;
end;

end.
