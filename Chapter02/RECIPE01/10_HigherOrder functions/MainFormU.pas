unit MainFormU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TMainForm = class(TForm)
    btnMapAddStars: TButton;
    lbMap: TListBox;
    btnFilterBetween: TButton;
    lbFilter: TListBox;
    btnReduceSum: TButton;
    lbReduce: TListBox;
    Label1: TLabel;
    Label2: TLabel;
    btnReduceMin: TButton;
    btnReduceMul: TButton;
    btnReduceMax: TButton;
    Label3: TLabel;
    btnFilterOdd: TButton;
    btnFilterEven: TButton;
    btnMapCapitalize: TButton;
    procedure btnMapAddStarsClick(Sender: TObject);
    procedure btnReduceSumClick(Sender: TObject);
    procedure btnFilterBetwenClick(Sender: TObject);
    procedure btnReduceMulClick(Sender: TObject);
    procedure btnReduceMinClick(Sender: TObject);
    procedure btnReduceMaxClick(Sender: TObject);
    procedure btnFilterOddClick(Sender: TObject);
    procedure btnFilterEvenClick(Sender: TObject);
    procedure btnMapCapitalizeClick(Sender: TObject);
  private
    function GetIntArrayOfData: TArray<Integer>;
    function GetStringArrayOfData: TArray<String>;
    procedure FillList(Data: TArray<String>; AStrings: TStrings); overload;
    procedure FillList(Data: TArray<Integer>; AStrings: TStrings); overload;
  public

  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}


uses HigherOrderFunctionsU;

procedure TMainForm.btnFilterBetwenClick(Sender: TObject);
var
  InputData, OutputData: TArray<Integer>;
  FilterFunc: TFunc<Integer, boolean>;
begin
  InputData := GetIntArrayOfData;
  FilterFunc := function(Item: Integer): boolean
    begin
      Result := (Item > 2) and (Item < 8)
    end;
  OutputData := HigherOrder.Filter<Integer>(InputData, FilterFunc);
  FillList(OutputData, lbFilter.Items);
end;

procedure TMainForm.btnFilterEvenClick(Sender: TObject);
var
  InputData, OutputData: TArray<Integer>;
begin
  InputData := GetIntArrayOfData;
  OutputData := HigherOrder.Filter<Integer>(InputData,
    function(Item: Integer): boolean
    begin
      Result := Item mod 2 = 0;
    end);
  FillList(OutputData, lbFilter.Items);
end;

procedure TMainForm.btnFilterOddClick(Sender: TObject);
var
  InputData, OutputData: TArray<Integer>;
begin
  InputData := GetIntArrayOfData;
  OutputData := HigherOrder.Filter<Integer>(InputData,
    function(Item: Integer): boolean
    begin
      Result := Item mod 2 > 0;
    end);
  FillList(OutputData, lbFilter.Items);
end;

procedure TMainForm.btnMapAddStarsClick(Sender: TObject);
var
  InputData, OutputData: TArray<string>;
begin
  InputData := GetStringArrayOfData;
  OutputData := HigherOrder.Map<String>(InputData,
    function(Item: String): String
    begin
      Result := '*' + Item + '*';
    end);

  FillList(OutputData, lbMap.Items);
end;

procedure TMainForm.btnMapCapitalizeClick(Sender: TObject);
var
  InputData, OutputData: TArray<string>;
begin
  InputData := GetStringArrayOfData;
  OutputData := HigherOrder.Map<string>(InputData,
    function(Item: String): String
    begin
      Result := String(Item.Chars[0]).ToUpper + Item.Substring(1);
    end);
  FillList(OutputData, lbMap.Items);
end;

procedure TMainForm.btnReduceMaxClick(Sender: TObject);
var
  InputData: TArray<Integer>;
  OutputData: Integer;
begin
  InputData := GetIntArrayOfData;
  OutputData := HigherOrder.Reduce<Integer>(InputData,
    function(Item1, Item2: Integer): Integer
    begin
      if Item1 > Item2 then
        Exit(Item1)
      else
        Exit(Item2);
    end, 0);
  lbReduce.Items.Add('MAX: ' + OutputData.ToString);
end;

procedure TMainForm.btnReduceMinClick(Sender: TObject);
var
  InputData: TArray<Integer>;
  OutputData: Integer;
begin
  InputData := GetIntArrayOfData;
  OutputData := HigherOrder.Reduce<Integer>(InputData,
    function(Item1, Item2: Integer): Integer
    begin
      if Item1 < Item2 then
        Exit(Item1)
      else
        Exit(Item2);
    end, MaxInt);
  lbReduce.Items.Add('MIN: ' + OutputData.ToString);
end;

procedure TMainForm.btnReduceMulClick(Sender: TObject);
var
  InputData: TArray<Integer>;
  OutputData: Integer;
begin
  InputData := GetIntArrayOfData;
  OutputData := HigherOrder.Reduce<Integer>(InputData,
    function(Item1, Item2: Integer): Integer
    begin
      Result := Item1 * Item2;
    end, 1);
  lbReduce.Items.Add('MUL: ' + OutputData.ToString);
end;

procedure TMainForm.btnReduceSumClick(Sender: TObject);
var
  InputData: TArray<Integer>;
  OutputData: Integer;
begin
  InputData := GetIntArrayOfData;
  OutputData := HigherOrder.Reduce<Integer>(InputData,
    function(Item1, Item2: Integer): Integer
    begin
      Result := Item1 + Item2;
    end, 0);
  lbReduce.Items.Add('SUM: ' + OutputData.ToString);
end;

procedure TMainForm.FillList(Data: TArray<Integer>; AStrings: TStrings);
var
  I: Integer;
begin
  AStrings.Clear;
  for I in Data do
    AStrings.Add(I.ToString);
end;

function TMainForm.GetIntArrayOfData: TArray<Integer>;
begin
  SetLength(Result, 10);
  Result[0] := 1;
  Result[1] := 2;
  Result[2] := 3;
  Result[3] := 4;
  Result[4] := 5;
  Result[5] := 6;
  Result[6] := 7;
  Result[7] := 8;
  Result[8] := 9;
  Result[9] := 10;
end;

function TMainForm.GetStringArrayOfData: TArray<String>;
begin
  SetLength(Result, 10);
  Result[0] := 'daniele';
  Result[1] := 'debora';
  Result[2] := 'mattia';
  Result[3] := 'jack';
  Result[4] := 'john';
  Result[5] := 'max';
  Result[6] := 'mary';
  Result[7] := 'katrine';
  Result[8] := 'joseph';
  Result[9] := 'george';
end;

procedure TMainForm.FillList(Data: TArray<String>; AStrings: TStrings);
var
  s: string;
begin
  AStrings.Clear;
  for s in Data do
    AStrings.Add(s);
end;

end.
