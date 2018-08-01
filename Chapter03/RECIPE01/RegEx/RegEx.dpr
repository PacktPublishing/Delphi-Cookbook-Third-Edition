program RegEx;

uses
  Vcl.Forms,
  MainFormU in 'MainFormU.pas' {RegExForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TRegExForm, RegExForm);
  Application.Run;
end.
