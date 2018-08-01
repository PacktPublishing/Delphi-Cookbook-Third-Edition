unit MainFormU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TMainForm = class(TForm)
    Memo1: TMemo;
    Panel1: TPanel;
    btnRegister: TButton;
    btnUnRegister: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnUnRegisterClick(Sender: TObject);
    procedure btnRegisterClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}


uses
  System.Win.registry, Winapi.shlobj, System.IOUtils;

procedure UnregisterFileType(FileExt: String; OnlyForCurrentUser: boolean = true);
var
  R: TRegistry;
begin
  R := TRegistry.Create;
  try
    if OnlyForCurrentUser then
      R.RootKey := HKEY_CURRENT_USER
    else
      R.RootKey := HKEY_LOCAL_MACHINE;

    R.DeleteKey('\Software\Classes\.' + FileExt);
    R.DeleteKey('\Software\Classes\' + FileExt + 'File');
  finally
    R.Free;
  end;
  SHChangeNotify(SHCNE_ASSOCCHANGED, SHCNF_IDLIST, 0, 0);
end;

procedure RegisterFileType(FileExt: String; FileTypeDescription: String;
  ICONResourceFileFullPath: String;
  ApplicationFullPath: String;
  OnlyForCurrentUser: boolean = true);
var
  R: TRegistry;
begin
  R := TRegistry.Create;
  try
    if OnlyForCurrentUser then
      R.RootKey := HKEY_CURRENT_USER
    else
      R.RootKey := HKEY_LOCAL_MACHINE;

    // The following code doesn’t raise exceptions if the
    // registry key cannot be created or opened for sake of
    // simplicity. Your production code should check all the IFs

    if R.OpenKey('\Software\Classes\.' + FileExt, true) then
    begin
      R.WriteString('', FileExt + 'File');
      if R.OpenKey('\Software\Classes\' + FileExt + 'File', true) then
      begin
        R.WriteString('', FileTypeDescription);
        if R.OpenKey('\Software\Classes\' + FileExt + 'File\DefaultIcon', true) then
        begin
          R.WriteString('', ICONResourceFileFullPath);
          if R.OpenKey('\Software\Classes\' + FileExt + 'File\shell\open\command', true) then
            R.WriteString('', ApplicationFullPath + ' "%1"');
        end;
      end;
    end;
  finally
    R.Free;
  end;
  SHChangeNotify(SHCNE_ASSOCCHANGED, SHCNF_IDLIST, 0, 0);
end;

procedure TMainForm.btnRegisterClick(Sender: TObject);
begin
  RegisterFileType(
    'secret',
    'This file is a secret',
    Application.ExeName,
    Application.ExeName,
    true);
  ShowMessage('File type registred');
end;

procedure TMainForm.btnUnRegisterClick(Sender: TObject);
begin
  UnregisterFileType('secret', true);
  ShowMessage('File type unregistered');
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  if TFile.Exists(ParamStr(1)) then
    Memo1.Lines.LoadFromFile(ParamStr(1))
  else
  begin
    Memo1.Lines.Text := 'No valid secret file type';
  end;
end;

end.
