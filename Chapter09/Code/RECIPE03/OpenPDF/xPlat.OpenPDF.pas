unit xPlat.OpenPDF;

interface

procedure OpenPDF(const APDFFileName: string);

implementation

uses
  System.SysUtils
    , IdURI
    , FMX.Forms
    , System.Classes
    , System.IOUtils
    , FMX.WebBrowser
    , FMX.Types
    , FMX.StdCtrls
{$IF defined(ANDROID)}
    , Androidapi.JNI.GraphicsContentViewText
    , FMX.Helpers.Android
    , Androidapi.Helpers
    , AndroidSDK.Toast
    , Androidapi.JNI.Net
    , Androidapi.JNI.App
    , Androidapi.JNI.JavaTypes
{$ENDIF}
{$IF defined(IOS)}
    , iOSapi.Foundation
    , Macapi.Helpers
    , FMX.Helpers.iOS
    , FMX.Dialogs
{$ENDIF}
    ;

{$IF defined(ANDROID)}


procedure OpenPDF(const APDFFileName: string);
var
  Intent: JIntent;
  FilePath: string;
  SharedFilePath: string;
begin
  FilePath := TPath.Combine(TPath.GetDocumentsPath, APDFFileName);
  SharedFilePath := TPath.Combine(TPath.GetSharedDocumentsPath, APDFFileName);
  if TFile.Exists(SharedFilePath) then
    TFile.Delete(SharedFilePath);
  TFile.Copy(FilePath, SharedFilePath);

  Intent := TJIntent.Create;
  Intent.setAction(TJIntent.JavaClass.ACTION_VIEW);
  Intent.setDataAndType(StrToJURI('file://' + SharedFilePath), StringToJString('application/pdf'));
  try
    TAndroidHelper.Activity.startActivity(Intent);
  except
    on E: Exception do
      ShowToast('Cannot open PDF' + sLineBreak +
        Format('[%s] %s', [E.ClassName, E.Message]),
        TToastDuration.Long);
  end;
end;
{$ENDIF}

{$IF defined(IOS)}


type
  TCloseParentFormHelper = class
  public
    procedure OnClickClose(Sender: TObject);
  end;

procedure TCloseParentFormHelper.OnClickClose(Sender: TObject);
begin
  TForm(TComponent(Sender).Owner).Close();
end;

procedure OpenPDF(const APDFFileName: string);
var
  NSU: NSUrl;
  OK: Boolean;
  frm: TForm;
  WebBrowser: TWebBrowser;
  btn: TButton;
  evnt: TCloseParentFormHelper;
begin
  frm := TForm.CreateNew(nil);
  btn := TButton.Create(frm);
  btn.Align := TAlignLayout.Top;
  btn.Text := 'Close';
  btn.Parent := frm;
  evnt := TCloseParentFormHelper.Create;
  btn.OnClick := evnt.OnClickClose;
  WebBrowser := TWebBrowser.Create(frm);
  WebBrowser.Parent := frm;
  WebBrowser.Align := TAlignLayout.Client;
  WebBrowser.Navigate('file://' + APDFFileName);
  frm.ShowModal();
end;
{$ENDIF}

end.
