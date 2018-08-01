unit WebModuleU;

interface

uses System.SysUtils, System.Classes, Web.HTTPApp, MVCFramework,
  MVCFramework.Commons;

type
  TwmMain = class(TWebModule)
    procedure WebModule1DefaultHandlerAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModuleCreate(Sender: TObject);
  private
    FMVC: TMVCEngine;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  WebModuleClass: TComponentClass = TwmMain;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}
{$R *.dfm}

uses
  BooksControllerU, System.IOUtils, MVCFramework.Logger, LoggerPro,
  LoggerPro.FileAppender;

function GetLogFilePath: String;
begin
  Result := '/var/log/';
end;

procedure TwmMain.WebModule1DefaultHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  Response.Content := '<html>' +
    '<head><title>Web Server Application</title></head>' +
    '<body>Web Server Application</body>' + '</html>';
end;

procedure TwmMain.WebModuleCreate(Sender: TObject);
begin
  FMVC := TMVCEngine.Create(Self);
  FMVC.AddController(TBooksController);

  FMVC.Config['document_root'] := '..\..\www';
{$IFDEF Linux}
  FMVC.Config['document_root'] := 'www';
{$ENDIF}
  // Define a default URL for requests that don't map to a route or a file
//  FMVC.Config[TMVCConfigKey.FallbackResource] := 'index.html';
end;

initialization

SetDefaultLogger(BuildLogWriter([TLoggerProFileAppender.Create(5, 2000,
  GetLogFilePath)]));

end.
