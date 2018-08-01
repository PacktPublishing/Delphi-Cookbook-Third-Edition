unit MainDMU;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.Phys.IBBase, FireDAC.Phys.IB, FireDAC.VCLUI.Wait, FireDAC.Comp.UI, FireDAC.Moni.Base,
  FireDAC.Moni.RemoteClient, FireDAC.Phys.IBDef;

type
  Tdm = class(TDataModule)
    Connection: TFDConnection;
    FDPhysIBDriverLink1: TFDPhysIBDriverLink;
    qryPeople: TFDQuery;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    qryPeopleID: TIntegerField;
    qryPeopleFIRST_NAME: TStringField;
    qryPeopleLAST_NAME: TStringField;
    qryPeopleWORK_PHONE_NUMBER: TStringField;
    qryPeopleMOBILE_PHONE_NUMBER: TStringField;
    qryPeopleEMAIL: TStringField;
    FDMoniRemoteClientLink1: TFDMoniRemoteClientLink;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
