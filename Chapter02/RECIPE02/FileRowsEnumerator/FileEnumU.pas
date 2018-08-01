unit FileEnumU;

interface

uses
  System.Classes, System.Generics.Collections;

type
  TFileEnumerable = record
  private
    FFileName: string;
  public
    constructor Create(AFileName: String);
    function GetEnumerator: TEnumerator<String>;
  end;

function EachRows(const AFileName: String): TFileEnumerable;

implementation

uses
  System.IOUtils;

type
  TFileEnumerator = class(TEnumerator<String>)
  private
    FCurrent: String;
    FFile: TStreamReader;
  protected
    constructor Create(AFileName: String);
    destructor Destroy; override;
    function DoGetCurrent: String; override;
    function DoMoveNext: Boolean; override;
  end;

constructor TFileEnumerable.Create(AFileName: String);
begin
  FFileName := AFileName;
end;

function TFileEnumerable.GetEnumerator: TEnumerator<String>;
begin
  Result := TFileEnumerator.Create(FFileName);
end;

{ TFileEnumerator }

constructor TFileEnumerator.Create(AFileName: String);
begin
  inherited Create;
  FFile := TFile.OpenText(AFileName);
end;

destructor TFileEnumerator.Destroy;
begin
  FFile.Free;
  inherited;
end;

function TFileEnumerator.DoGetCurrent: String;
begin
  Result := FCurrent;
end;

function TFileEnumerator.DoMoveNext: Boolean;
begin
  Result := not FFile.EndOfStream;
  if Result then
    FCurrent := FFile.ReadLine;

end;

function EachRows(const AFileName: String): TFileEnumerable;
begin
  Result := TFileEnumerable.Create(AFileName);
end;

end.
