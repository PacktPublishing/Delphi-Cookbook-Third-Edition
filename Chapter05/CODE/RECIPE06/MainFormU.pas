unit MainFormU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils,
  System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TMainForm = class(TForm)
    mmLog: TMemo;
    btnSimple: TButton;
    btnWithException: TButton;
    btnExceptionDef: TButton;
    btnRESTRequest: TButton;
    procedure btnSimpleClick(Sender: TObject);
    procedure btnWithExceptionClick(Sender: TObject);
    procedure btnExceptionDefClick(Sender: TObject);
    procedure btnRESTRequestClick(Sender: TObject);
  private
    procedure Log(const Value: String);
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  AsyncTask,
  System.JSON,
  System.Net.HttpClient;

procedure TMainForm.btnSimpleClick(Sender: TObject);
begin
  Async.Run<Integer>(
    function: Integer
    begin
      Sleep(2000);
      Result := Random(100);
    end,
    procedure(const Value: Integer)
    begin
      Log('RESULT: ' + Value.ToString);
    end);
end;

procedure TMainForm.btnWithExceptionClick(Sender: TObject);
begin
  Async.Run<String>(
    function: String
    begin
      raise Exception.Create('This is an error message');
    end,
    procedure(const Value: String)
    begin
      // never called
    end,
    procedure(const Ex: Exception)
    begin
      Log('Exception: ' + sLineBreak + Ex.Message);
    end);
end;

procedure TMainForm.btnExceptionDefClick(Sender: TObject);
begin
  Async.Run<String>(
    function: String
    begin
      raise Exception.Create('Handled by the default Exception handler');
    end,
    procedure(const Value: String)
    begin
      // never called
    end);
end;

procedure TMainForm.btnRESTRequestClick(Sender: TObject);
begin
  Async.Run<String>(
    function: String
    var
      LHTTP: THTTPClient;
      LResp: IHTTPResponse;
    begin
      LHTTP := THTTPClient.Create;
      try
        LResp := LHTTP.Get('http://worldclockapi.com/api/json/utc/now');
        if LResp.StatusCode = 200 then
        begin
          Result := LResp.ContentAsString(TEncoding.UTF8)
        end
        else
        begin
          raise Exception.CreateFmt('Cannot get time. HTTP %d - %s',
            [LResp.StatusCode, LResp.StatusText]);
        end;
      finally
        LHTTP.Free;
      end;
    end,
    procedure(const AJSONStringResp: String)
    var
      LJSONObj: TJSONObject;
    begin
      LJSONObj := TJSONObject.ParseJSONValue(AJSONStringResp) as TJSONObject;
      try
        Log('Current Date Time: ' + LJSONObj.GetValue('currentDateTime').Value);
      finally
        LJSONObj.Free;
      end;
    end,
    procedure(const Ex: Exception)
    begin
      Log('Exception: ' + sLineBreak + Ex.Message);
    end);
end;

procedure TMainForm.Log(const Value: String);
begin
  mmLog.Lines.Add(TimeToStr(now) + ' - ' + Value);
end;

end.
