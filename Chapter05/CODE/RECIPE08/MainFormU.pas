unit MainFormU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, Vcl.StdCtrls, FireDAC.Phys.IBDef,
  FireDAC.Phys.IBBase, FireDAC.Phys.IB, System.Threading, System.SyncObjs;

type
  TMainForm = class(TForm)
    btnStart: TButton;
    FDPhysIBDriverLink1: TFDPhysIBDriverLink;
    procedure btnStartClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private const
    CONNECTION_DEF_NAME = 'employee_process';
    OUTPUT_FOLDER = 'customers_summary';

    procedure DefinePrivateConnDef;
    function MakeProc(const CustNo: Integer): TProc;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses
  System.IOUtils, FireDAC.DApt;

{$R *.dfm}
{ TForm1 }

procedure TMainForm.btnStartClick(Sender: TObject);
var
  LConn: TFDConnection;
  LQry: TFDQuery;
  LTasks: TArray<TProc>;
  i: Integer;
  LProcs: ITask;
begin
  LConn := TFDConnection.Create(nil);
  try
    LConn.ConnectionDefName := CONNECTION_DEF_NAME;
    LConn.Open;
    LQry := TFDQuery.Create(LConn);
    LQry.Connection := LConn;
    LQry.Open('SELECT * FROM CUSTOMER ORDER BY CUST_NO');
    LQry.FetchAll;
    SetLength(LTasks, LQry.RecordCount);
    i := 0;
    while not LQry.Eof do
    begin
      LTasks[i] := MakeProc(LQry.FieldByName('CUST_NO').AsInteger);
      LQry.Next;
      Inc(i);
    end;
  finally
    LConn.Free;
  end;

  TDirectory.CreateDirectory(OUTPUT_FOLDER);

  TTask.Run(
    procedure
    begin
      LProcs := TParallel.Join(LTasks);
      LProcs.Wait(INFINITE);
      TThread.Queue(nil,
        procedure
        begin
          ShowMessage('Summary files generated successfully');
          btnStart.Enabled := True;
        end);
    end);
  btnStart.Enabled := False;
end;

procedure TMainForm.DefinePrivateConnDef;
var
  LParams: TStringList;
const
  DBFILENAME =
    'C:\ProgramData\Embarcadero\InterBase\gds_db\examples\database\employee.gdb';
begin
  LParams := TStringList.Create;
  try
    LParams.Add('Database=' + DBFILENAME);
    LParams.Add('Protocol=TCPIP');
    LParams.Add('Server=localhost');
    LParams.Add('User_Name=sysdba');
    LParams.Add('Password=masterkey');
    LParams.Add('Pooled=true');
    FDManager.AddConnectionDef(CONNECTION_DEF_NAME, 'IB', LParams);
  finally
    LParams.Free;
  end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  DefinePrivateConnDef;
end;

function TMainForm.MakeProc(const CustNo: Integer): TProc;
begin
  Result := procedure
    var
      LConn: TFDConnection;
      LQry: TFDQuery;
      LOutputFile: TStreamWriter;
      LFName: string;
    begin
      LConn := TFDConnection.Create(nil);
      try
        LConn.ConnectionDefName := CONNECTION_DEF_NAME;
        LFName := TPath.Combine(OUTPUT_FOLDER, Format('customer_%.8d.txt',
          [CustNo]));

        LOutputFile := TFile.CreateText(LFName);
        try
          sleep(1000); // here's some artificial delay...
          LQry := TFDQuery.Create(LConn);
          LQry.Connection := LConn;
          LQry.Open(
            'SELECT * FROM SALES WHERE CUST_NO = ? ORDER BY ORDER_DATE, PO_NUMBER',
            [CustNo]);
          while not LQry.Eof do
          begin
            LOutputFile.WriteLine(LQry.GetRow().DumpRow(True));
            LQry.Next;
          end;
        finally
          LOutputFile.Free;
        end;
      finally
        LConn.Free;
      end;
    end;
end;

end.
