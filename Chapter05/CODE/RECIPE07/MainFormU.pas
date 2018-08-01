unit MainFormU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.Threading;

type
  TMainForm = class(TForm)
    EditValue: TEdit;
    EditResultInEuro: TEdit;
    btnConvert: TButton;
    cbSymbol: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure btnConvertClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbSymbolClick(Sender: TObject);
  private
    FConversionRate: IFuture<Currency>;
    procedure StartFuture;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses
  System.Net.HTTPClient, System.JSON, AsyncTask;

{$R *.dfm}

const
  ACCESS_KEY = '58297a8c75e21d218b1da2c610b6f62c';

procedure TMainForm.btnConvertClick(Sender: TObject);
begin
  if not Assigned(FConversionRate) then
  begin
    ShowMessage('Please, select a currency symbol');
    Exit;
  end;
  EditResultInEuro.Text := FormatCurr('€ #,###,##0.00', FConversionRate.Value *
    StrToFloat(EditValue.Text));
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  Async.Run<TStringList>(
    function: TStringList
    var
      LHTTP: THTTPClient;
      LResp: IHTTPResponse;
      LJObj: TJSONObject;
      LJRates: TJSONObject;
      I: Integer;
    begin
      LHTTP := THTTPClient.Create;
      try
        LResp := LHTTP.Get('http://data.fixer.io/api/latest?access_key=' +
          ACCESS_KEY);
        LJObj := TJSONObject.ParseJSONValue
          (LResp.ContentAsString(TEncoding.UTF8)) as TJSONObject;
        try
          LJRates := LJObj.GetValue<TJSONObject>('rates');
          Result := TStringList.Create;
          for I := 0 to LJRates.Count - 1 do
          begin
            Result.Add(LJRates.Pairs[I].JsonString.Value);
          end;
          Result.Sort;
        finally
          LJObj.Free;
        end;
      finally
        LHTTP.Free;
      end;
    end,
    procedure(const Strings: TStringList)
    begin
      cbSymbol.Items.Assign(Strings);
    end);
end;

procedure TMainForm.cbSymbolClick(Sender: TObject);
begin
  StartFuture;
end;

procedure TMainForm.StartFuture;
var
  LBaseSymbol: String;
begin
  EditResultInEuro.Clear;
  if cbSymbol.ItemIndex < 0 then
    Exit;

  LBaseSymbol := cbSymbol.Text;
  FConversionRate := TTask.Future<Currency>(
    function: Currency
    var
      LHTTP: THTTPClient;
      LResp: IHTTPResponse;
      LJObj: TJSONObject;
    begin
      LHTTP := THTTPClient.Create;
      try
        LResp := LHTTP.Get(Format('http://data.fixer.io/api/latest?access_key='
          + ACCESS_KEY + '&base=%s&symbols=EUR', [LBaseSymbol]));
        LJObj := TJSONObject.ParseJSONValue
          (LResp.ContentAsString(TEncoding.UTF8)) as TJSONObject;
        try
          Result := LJObj.GetValue<TJSONNumber>('rates.EUR').AsDouble;
        finally
          LJObj.Free;
        end;
      finally
        LHTTP.Free;
      end;
    end);
end;

end.
