unit MainFormServerU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IdSocketHandle, IdBaseComponent,
  IdComponent, IdUDPBase, IdUDPServer,
  Vcl.StdCtrls, IdGlobal;

type
  TMainForm = class(TForm)
    IdUDPServer1: TIdUDPServer;
    MemoConfigApp1: TMemo;
    MemoConfigApp2: TMemo;
    MemoLog: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure IdUDPServer1UDPRead(AThread: TIdUDPListenerThread;
      const AData: TIdBytes; ABinding: TIdSocketHandle);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.IdUDPServer1UDPRead(AThread: TIdUDPListenerThread;
  const AData: TIdBytes; ABinding: TIdSocketHandle);
var
  ClientCommand, ClientConfig: string;
  CommandPieces: TArray<string>;
begin
  ClientCommand := BytesToString(AData);
  MemoLog.Lines.Add(ClientCommand);
  CommandPieces := ClientCommand.Split(['#']);
  if (Length(CommandPieces) = 2) and (CommandPieces[0] = 'GETCONFIG') then
  begin
    if CommandPieces[1] = 'APP001' then
    begin
      ClientConfig := MemoConfigApp1.Lines.Text;
    end;
    if CommandPieces[1] = 'APP002' then
    begin
      ClientConfig := MemoConfigApp2.Lines.Text;
    end;
    ABinding.Broadcast(ToBytes(ClientConfig), 9999, ABinding.PeerIP);
  end;
end;

end.
