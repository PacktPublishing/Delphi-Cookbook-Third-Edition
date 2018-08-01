unit AsyncTaskTestsU;

interface

uses
  DUnitX.TestFramework;

type

  [TestFixture]
  TAsyncTaskTests = class(TObject)
  public
    [Test]
    procedure TestAsyncTask;
  end;

implementation

uses System.SyncObjs, System.SysUtils, System.Threading,
  System.Classes, System.Generics.Collections, System.Net.HttpClient;

procedure TAsyncTaskTests.TestAsyncTask;
var
  LEvent: TEvent;
  LResult: Boolean;
begin
  LResult := False;
  LEvent := TEvent.Create;
  TTask.Run(
    procedure
    var
      LHTTP: THTTPClient;
      LResp: IHTTPResponse;
    begin
      LHTTP := THTTPClient.Create;
      try
        Assert.IsTrue(False);
        LResp := LHTTP.Get
          ('http://api.timezonedb.com/v2/get-time-zone?key=YOUR_API_KEY&format=json&by=zone&zone=Italy/Rome');
        if LResp.StatusCode = 200 then
        begin
          LResult := not LResp.ContentAsString(TEncoding.UTF8).IsEmpty
        end
        else
        begin
          raise Exception.CreateFmt('Cannot get time. HTTP %d - %s',
            [LResp.StatusCode, LResp.StatusText]);
        end;
      finally
        LHTTP.Free;
        LEvent.SetEvent;
      end;
    end);
  // attend for max 5 seconds
  Assert.IsTrue(TWaitResult.wrSignaled = LEvent.WaitFor(5000),
    'Timeout request');
  Assert.IsTrue(LResult);
end;

initialization

TDUnitX.RegisterTestFixture(TAsyncTaskTests);

end.
