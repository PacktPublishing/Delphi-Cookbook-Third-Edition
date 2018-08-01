//---------------------------------------------------------------------------

// This software is Copyright (c) 2018 Embarcadero Technologies, Inc.
// You may only use this software if you are an authorized licensee
// of an Embarcadero developer tools product.
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------

program LoginProject;

uses
  System.StartUpCopy,
  FMX.Forms,
  uLoginForm1 in 'uLoginForm1.pas' {Form1Login},
  uLoginFrame1 in 'uLoginFrame1.pas' {LoginFrame1: TFrame},
  ServicesU in 'ServicesU.pas',
  EventsU in 'EventsU.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1Login, Form1Login);
  Application.Run;
end.
