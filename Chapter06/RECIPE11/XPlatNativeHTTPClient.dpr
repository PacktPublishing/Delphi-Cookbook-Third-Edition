program XPlatNativeHTTPClient;

uses
  System.StartUpCopy,
  FMX.Forms,
  MainFormU in 'MainFormU.pas' {MainForm},
  HTTPLayerDMU in 'HTTPLayerDMU.pas' {HTTPDM: TDataModule},
  AsyncTask in '..\..\..\Chapter05\CODE\RECIPE05\AsyncTask.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
