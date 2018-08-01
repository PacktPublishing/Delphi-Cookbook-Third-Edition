unit WebModuleU;

interface

uses System.SysUtils, System.Classes, Web.HTTPApp, MVCFramework;

type
  TwmMain = class(TWebModule)
    procedure WebModule1DefaultHandlerAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModuleCreate(Sender: TObject);
  private
    FMVC: TMVCEngine;
  public
    { Public declarations }
  end;

var
  WebModuleClass: TComponentClass = TwmMain;

implementation

{$R *.dfm}

uses SmsControllerU;

procedure TwmMain.WebModule1DefaultHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  Response.Content :=
    '<html><heading/><body>Web Server Application</body></html>';
end;

procedure TwmMain.WebModuleCreate(Sender: TObject);
begin
  FMVC := TMVCEngine.Create(Self);
  FMVC.AddController(TSmsController);
end;

end.
