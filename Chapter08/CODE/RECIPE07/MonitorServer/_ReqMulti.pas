{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{       Web server application components               }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

// Parse a multipart form data request which may contain
// uploaded files.  use ReqMulti to register this parser.

{$HPPEMIT LINKUNIT}
unit ReqMulti;

interface

uses System.SysUtils, System.Classes, System.Masks, System.Contnrs, Web.HTTPApp,
  ReqFiles, HTTPParse;

type

{ TMultipartContentParser }

  TMultipartContentParser = class(TAbstractContentParser)
  private
    FContentFields: TStrings;
    FFiles: TWebRequestFiles;
    FContentBuffer: AnsiString;
  protected
    function GetContentFields: TStrings; override;
    function GetFiles: TAbstractWebRequestFiles; override;

    procedure ExtractContentTypeFields(Strings: TStrings);
    procedure ParseMultiPartContent;
    procedure ParseMultiPart(Part: Pointer; Size: Integer);
    procedure BufferContent;
    procedure ParseMultipartHeaders(Parser: THTTPParser; AContent: Pointer;
      AContentLength: Integer);
    procedure ExtractMultipartContentFields;
  public
    destructor Destroy; override;
    class function CanParse(AWebRequest: TWebRequest): Boolean; override;
  end;

implementation

uses Web.WebConst, WebComp, Web.BrkrConst, Winapi.Windows, System.AnsiStrings;

const
  sMultiPartFormData = AnsiString('multipart/form-data');

function IsMultipartForm(ARequest: TWebRequest): Boolean;
begin
  Result := System.AnsiStrings.AnsiStrComp(PAnsiChar(Copy(ARequest.ContentType, 1, Length(sMultiPartFormData))),
    PAnsiChar(sMultiPartFormData)) = 0;
end;

{ TMultipartContentParser }

destructor TMultipartContentParser.Destroy;
begin
  FContentFields.Free;
  FFiles.Free;
  inherited Destroy;
end;

procedure TMultipartContentParser.BufferContent;
var
  L, R: Integer;
  P: PAnsiChar;
begin
  if (WebRequest.ContentLength > 0) and (FContentBuffer = '') then
  begin
    FContentBuffer := WebRequest.RawContent;
    if Length(WebRequest.Content) < WebRequest.ContentLength then
    begin
      L := Length(FContentBuffer);
      SetLength(FContentBuffer, WebRequest.ContentLength);
      P := PAnsiChar(FContentBuffer) + L;
      while L < WebRequest.ContentLength do
      begin
        R := WebRequest.ReadClient(P^, WebRequest.ContentLength - L);
        if R <= 0 then break;
        Inc(L, R);
        Inc(P, R);
      end;
    end;
  end;
end;

procedure TMultipartContentParser.ExtractMultipartContentFields;
begin
  if WebRequest.ContentLength > 0 then
  begin
    BufferContent;
    ParseMultiPartContent;
  end;
end;

procedure TMultipartContentParser.ExtractContentTypeFields(Strings: TStrings);
var
  S: AnsiString;
begin
  S := WebRequest.ContentType;
  ExtractHeaderFields([';'], [' '], S, Strings, True, True);
end;


procedure TMultipartContentParser.ParseMultiPartContent;
type
  TMultipartBoundaries = array of Integer;

  function FindBoundaries(const Boundary: AnsiString): TMultipartBoundaries;
  var
    P1: Integer;
    C1: AnsiChar;
    I: Integer;
    Boundaries: TMultipartBoundaries;
    Count: Integer;
    SaveChar: array of AnsiChar;
  begin
    Count := 0;
    P1 := Pos(Boundary, FContentBuffer);
    while P1 > 0 do
    begin
      C1 := FContentBuffer[P1];
      FContentBuffer[P1] := #0;
      Inc(Count);
      SetLength(SaveChar, Count);
      SetLength(Boundaries, Count);
      SaveChar[Count-1] := C1;
      Boundaries[Count-1] := P1;
      P1 := Pos(Boundary, FContentBuffer);
    end;
    for I := Low(Boundaries) to High(Boundaries) do
    begin
      FContentBuffer[Boundaries[I]] := SaveChar[I];
    end;
    Result := Boundaries;
  end;
var
  ContentTypeFields: TStrings;
  Boundaries: TMultipartBoundaries;
  Boundary: AnsiString;
  I: Integer;
  P: Integer;
begin
  SetLength(Boundaries, 0);
  ContentTypeFields := TStringList.Create;
  try
    ExtractContentTypeFields(ContentTypeFields);
    Boundary := AnsiString(ContentTypeFields.Values['boundary']);
    if Boundary <> '' then
      Boundary := AnsiString('--') + Boundary;
  finally
    ContentTypeFields.Free;
  end;
  if Boundary = '' then
    Exit;
  Boundaries := FindBoundaries(Boundary);
  for I := Low(Boundaries) to High(Boundaries)-1 do
  begin
    P := Boundaries[I] + Length(Boundary) + 2;
    ParseMultiPart(Pointer(@FContentBuffer[P]),
      Boundaries[I+1] - P);
  end;
end;

procedure TMultipartContentParser.ParseMultipartHeaders(Parser: THTTPParser;
  AContent: Pointer; AContentLength: Integer);
var
  PartContentType: AnsiString;
  PartFileName: AnsiString;
  PartName: AnsiString;
  ContentDisposition: AnsiString;

  procedure SkipLine;
  begin
    Parser.CopyToEOL;
    Parser.SkipEOL;
  end;

  function TrimLeft(const S: AnsiString): AnsiString;
  var
    I, L: Integer;
  begin
    L := Length(S);
    I := 1;
    while (I <= L) and (S[I] <= ' ') do Inc(I);
    Result := Copy(S, I, Maxint);
  end;

  procedure ParseContentType;
  begin
    with Parser do
    begin
      NextToken;
      if Token = ':' then NextToken;
      if PartContentType = '' then
        PartContentType := TrimLeft(CopyToEOL)
      else CopyToEOL;
      NextToken;
    end;
  end;

  procedure ExtractContentDispositionFields;
  var
    S: AnsiString;
    Strings: TSTrings;
  begin
    S := ContentDisposition;
    Strings := TStringList.Create;
    try
      ExtractHeaderFields([';'], [' '], S, Strings, True, True);
      PartName := AnsiString(Strings.Values['name']);
      PartFileName := AnsiString(Strings.Values['filename']);
    finally
      Strings.Free;
    end;
  end;

  procedure ParseContentDisposition;
  begin
    with Parser do
    begin
      NextToken;
      if Token = ':' then NextToken;
      if ContentDisposition = '' then
        ContentDisposition := TrimLeft(CopyToEOL)
      else CopyToEOL;
      NextToken;
      ExtractContentDispositionFields;
    end;
  end;

var
  Temp: AnsiString;
begin
  while Parser.Token <> toEOF do with Parser do
  begin
    case Token of
      toContentType: ParseContentType;
      toContentDisposition: ParseContentDisposition;
      toEOL: Break; // At content
    else
      SkipLine;
    end;
  end;
  if PartName <> '' then
  begin
    if PartFileName <> '' then
    begin
      // Note.  Filename is not added as content field
      // FContentFields.Add(PartName + '=' + PartFileName);
      if FFiles = nil then
        FFiles := TWebRequestFiles.Create;
      FFiles.Add(PartName, PartFileName, PartContentType,
        AContent, AContentLength-2); // Exclude the cr/lf pair
    end
    else if PartContentType = '' then
    begin
      Temp := '';
      if AContentLength > 0 then
      begin
        Assert(AContentLength >= 2);
        SetString(Temp, PAnsiChar(AContent), AContentLength-2);  // Exclude cr/lf
      end;
      FContentFields.Add(string(PartName + AnsiChar('=') + Temp));
    end
  end;
end;

procedure TMultipartContentParser.ParseMultiPart(Part: Pointer; Size: Integer);
var
  P: PAnsiChar;
  S: TStream;
  L: Integer;
  Parser: THTTPParser;
begin
  P := System.AnsiStrings.AnsiStrPos(PAnsiChar(Part), #13#10#13#10);
  if P <> nil then
  begin
    L := P-Part+4;
    S := TWebRequestFileStream.Create(Part, L);
    try
      Parser := THTTPParser.Create(S);
      try
        ParseMultiPartHeaders(Parser, PAnsiChar(Part) + L, Size-L);
      finally
        Parser.Free;
      end;
    finally
      S.Free;
    end;
  end;
end;

function TMultipartContentParser.GetContentFields: TStrings;
begin
  if FContentFields = nil then
  begin
    FContentFields := TStringList.Create;
    if IsMultiPartForm(WebRequest) then
      ExtractMultipartContentFields
    else
      WebRequest.ExtractContentFields(FContentFields);
  end;
  Result := FContentFields;
end;

function TMultipartContentParser.GetFiles: TAbstractWebRequestFiles;
begin
  GetContentFields;
  if FFiles = nil then
    FFiles := TWebRequestFiles.Create;
  Result := FFiles;
end;

class function TMultipartContentParser.CanParse(
  AWebRequest: TWebRequest): Boolean;
begin
  Result := IsMultipartForm(AWebRequest);
end;

initialization
  RegisterContentParser(TMultipartContentParser);
end.
