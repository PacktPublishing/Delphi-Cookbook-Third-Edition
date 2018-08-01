// ---------------------------------------------------------------------------

// This software is Copyright (c) 2018 Embarcadero Technologies, Inc.
// You may only use this software if you are an authorized licensee
// of an Embarcadero developer tools product.
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

// ---------------------------------------------------------------------------

unit uLoginForm1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, uLoginFrame1, EventsU, EventBus.Commons;

type
  TForm1Login = class(TForm)
    EmeraldCrystalStyleBook: TStyleBook;
    LoginFrame11: TLoginFrame1;
    procedure FormCreate(Sender: TObject);
    procedure LoginFrame11AuthenticateRectBTNClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    // ensure that UI event will be execute in Main Thread
    [Subscribe(TThreadMode.Main)]
    procedure OnUserAuthentication(AEvent: TAuthenticationEvent);
  end;

var
  Form1Login: TForm1Login;

implementation

uses
  EventBus, ServicesU;

{$R *.fmx}
// Changes to the layout should be made inside of the TFrame itself. Once changes are made
// to the TFrame you can delete it from the TForm and re-add it. Set it's Align property to
// Client. Optionally, it's ClipChildren property can be set to True if there are any overlapping
// background images.

procedure TForm1Login.FormCreate(Sender: TObject);
begin
  TEventBus.GetDefault.RegisterSubscriber(Self);
end;

procedure TForm1Login.LoginFrame11AuthenticateRectBTNClick(Sender: TObject);
begin
  LoginFrame11.WaitMode(True);
  GetRESTAPIService.DoLogin(LoginFrame11.EmailEdit.Text,
    LoginFrame11.PasswordEdit.Text);
end;

procedure TForm1Login.OnUserAuthentication(AEvent: TAuthenticationEvent);
begin
  try
    LoginFrame11.WaitMode(false);
    if AEvent.Result then
      ShowMessage('Login Ok. You will be redirected to the dashboard...')
    else
      ShowMessage
        ('Login KO. It seems that you have entered invalid data, please check yuour data...')
  finally
    AEvent.Free;
  end;
end;

end.
