unit MainFormU;

interface

uses
	Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
	System.Classes, Vcl.Graphics,
	Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Threading, FireDAC.Stan.Intf,
	FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
	FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
	FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys,
	FireDAC.Phys.IB, FireDAC.Phys.IBDef, FireDAC.VCLUI.Wait, Vcl.StdCtrls,
	Vcl.ExtCtrls, Data.DB, FireDAC.Comp.Client, FireDAC.Comp.DataSet,
	System.Generics.Collections;

type
	IStockInfo = interface
		['{6FAB5F5A-C5DF-45ED-B74B-AF0977514A13}']
		function GetName: String;
		function GetPercentage: Single;
		function GetValue: Currency;
		function ToString: String;
	end;

	TStockInfo = class(TInterfacedObject, IStockInfo)
	private
		FName: string;
		FPercentage: Single;
		FValue: Currency;
	protected
		function GetName: String;
		function GetPercentage: Single;
		function GetValue: Currency;
	public
		function ToString: String; override;
		constructor Create(Name: String; Percentage: Single;
			Value: Currency);
	end;

	TStockMonitor = class
	private
		FStockSymbol: string;
		FFuture: IFuture<IStockInfo>;
		procedure StartFuture;
		function GetStockInfo(const Row: String): IStockInfo;

	const
		YAHOO_URL = 'http://finance.yahoo.com/d/quotes.csv?s=%s&f=snl1p2';

	public
		constructor Create(StockSymbol: String);
		function GetFuture: IFuture<IStockInfo>;
		function GetStockSymbol: String;
	end;

	TForm1 = class(TForm)
		mmNames: TMemo;
		Timer1: TTimer;
		Panel1: TPanel;
		Button3: TButton;
		lbResults: TListBox;
		edtStock: TEdit;
		procedure Button1Click(Sender: TObject);
		procedure Button2Click(Sender: TObject);
		procedure FormCreate(Sender: TObject);
		procedure FormClose(Sender: TObject; var Action: TCloseAction);
		procedure Button3Click(Sender: TObject);
		procedure Timer1Timer(Sender: TObject);
	private
		FValue: IFuture<Integer>;
		FQuotes: TObjectDictionary<String, TStockMonitor>;

	public
		{ Public declarations }
	end;

var
	Form1: TForm1;

implementation

uses
	System.Net.HttpClient;

{$R *.dfm}


procedure TForm1.Button1Click(Sender: TObject);
begin
	FValue := TTask.Future<Integer>(
		function: Integer
		begin
			Sleep(Random(2000) + 1000);
			Result := Random(100);
		end);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
	if FValue.Wait(1) then
		Caption := FValue.Value.ToString;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
	I: Integer;
begin
	if FQuotes.Count > 0 then
	begin

	end
	else
	begin
		lbResults.Clear;
		for I := 0 to mmNames.Lines.Count - 1 do
		begin
			if not mmNames.Lines[I].Trim.IsEmpty then
			begin
				FQuotes.Add(mmNames.Lines[I], TStockMonitor.Create(mmNames.Lines[I]));
				lbResults.Items.Add('Wait...');
			end
		end;
	end;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
	FQuotes.Free;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
	FQuotes := TObjectDictionary<String, TStockMonitor>.Create([doOwnsValues]);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
	Pair: TPair<String, TStockMonitor>;
	LIdx: Integer;
begin
	for Pair in FQuotes do
	begin
		if Pair.Value.GetFuture.Wait(1) then
		begin
			LIdx := mmNames.Lines.IndexOf(Pair.Key);
			if LIdx > -1 then
				lbResults.Items[LIdx] :=
					Pair.Value.GetFuture.Value.ToString + ' - YOUR VALUE = $' +
					FormatCurr('###,##0.00', Pair.Value.GetFuture.Value.GetValue *
					StrToInt(edtStock.Text));
		end;
	end;
end;

{ TStockInfo }

constructor TStockMonitor.Create(StockSymbol: String);
begin
	inherited Create;
	FStockSymbol := StockSymbol;
	StartFuture;
end;

function TStockMonitor.GetFuture: IFuture<IStockInfo>;
begin
	Result := FFuture;
end;

function TStockMonitor.GetStockInfo(const Row: String): IStockInfo;
var
	LPieces: TArray<String>;
	LName: string;
	LPerc: Single;
	LValue: Single;
	LFormatSettings: TFormatSettings;
begin
	LFormatSettings.DecimalSeparator := '.';
	LPieces := Row.Split([','], '"', '"', 4, TStringSplitOptions.None);
	LName := LPieces[1].DeQuotedString('"');
	LPerc := StrToCurr(LPieces[3].Trim.DeQuotedString('"').Replace('%', ''),
		LFormatSettings);
	LValue := StrToFloat(LPieces[2], LFormatSettings);
	Result := TStockInfo.Create(
		LName,
		LPerc,
		LValue
		);
end;

function TStockMonitor.GetStockSymbol: String;
begin
	Result := FStockSymbol;
end;

procedure TStockMonitor.StartFuture;
begin
	FFuture := TTask.Future<IStockInfo>(
		function: IStockInfo
		var
			LHTTPClient: THTTPClient;
			LResp: IHTTPResponse;
			LRow: string;
		begin
			LHTTPClient := THTTPClient.Create;
			try
				LResp := LHTTPClient.Get(Format(YAHOO_URL, [FStockSymbol]));
				if LResp.StatusCode = 200 then
				begin
					LRow := LResp.ContentAsString(TEncoding.ANSI);
					Result := GetStockInfo(LRow);
				end
				else
				begin
					// Result := ;
				end;
			finally
				LHTTPClient.Free;
			end;
		end);
end;

{ TStockInfo }

constructor TStockInfo.Create(Name: String; Percentage: Single;
Value: Currency);
begin
	inherited Create;
	FName := Name;
	FPercentage := Percentage;
	FValue := Value;
end;

function TStockInfo.GetName: String;
begin
	Result := FName;
end;

function TStockInfo.GetPercentage: Single;
begin
	Result := FPercentage;
end;

function TStockInfo.GetValue: Currency;
begin
	Result := FValue;
end;

function TStockInfo.ToString: String;
begin
	Result :=
		Format('%s $%2.2f [%2.2f%%]', [FName, FValue, FPercentage]);
end;

end.
