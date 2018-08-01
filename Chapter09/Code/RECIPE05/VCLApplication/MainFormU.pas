unit MainFormU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, IdBaseComponent,
  IdComponent, IdUDPBase, IdSocketHandle, IdStack,
  System.RegularExpressions, IdGlobal, IdUDPClient;

type
  TMainForm = class(TForm)
    IdUDPClient1: TIdUDPClient;
    btnSend: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    procedure btnSendClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FAddressesList: TIdStackLocalAddressList;
    FToIPv4Broadcast: TRegEx;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}


procedure TMainForm.btnSendClick(Sender: TObject);
var
  CurrIP, BrdcstIP: string;
  i: Integer;
begin
  for i := 0 to FAddressesList.Count - 1 do
  begin
    if FAddressesList.Addresses[i].IPVersion = Id_IPv4 then
    begin
      CurrIP := FAddressesList.Addresses[i].IPAddress;
      BrdcstIP := FToIPv4Broadcast.Replace(CurrIP, '.255');
      IdUDPClient1.Broadcast(Edit1.Text, 9999, BrdcstIP);
    end;
  end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FAddressesList := TIdStackLocalAddressList.Create;
  GStack.GetLocalAddressList(FAddressesList);
  FToIPv4Broadcast := TRegEx.Create('\.\d{1,3}$');
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  FAddressesList.Free;
end;

end.
