unit AsyncTask;

interface

uses
  System.SysUtils, System.Threading;

type
  TAsyncBackgroundTask<T> = reference to function: T;
  TAsyncSuccessCallback<T> = reference to procedure(const TaskResult: T);
  TAsyncErrorCallback = reference to procedure(const E: Exception);
  TAsyncDefaultErrorCallback = reference to procedure(const E: Exception;
    const ExptAddress: Pointer);

  Async = class sealed
  public
    class function Run<T>(Task: TAsyncBackgroundTask<T>;
      Success: TAsyncSuccessCallback<T>;
      Error: TAsyncErrorCallback = nil): ITask;
  end;

var
  DefaultTaskErrorHandler: TAsyncDefaultErrorCallback = nil;

implementation

uses
  System.Classes;

{ Async }

class function Async.Run<T>(Task: TAsyncBackgroundTask<T>;
  Success: TAsyncSuccessCallback<T>; Error: TAsyncErrorCallback): ITask;
var
  LRes: T;
begin
  Result := TTask.Run(
    procedure
    var
      Ex: Pointer;
      ExceptionAddress: Pointer;
    begin
      Ex := nil;
      try
        LRes := Task();
        if Assigned(Success) then
        begin
          TThread.Queue(nil,
            procedure
            begin
              Success(LRes);
            end);
        end;
      except
        Ex := AcquireExceptionObject;
        ExceptionAddress := ExceptAddr;
        TThread.Queue(nil,
          procedure
          var
            LCurrException: Exception;
          begin
            LCurrException := Exception(Ex);
            try
              if Assigned(Error) then
                Error(LCurrException)
              else
                DefaultTaskErrorHandler(LCurrException, ExceptionAddress);
            finally
              FreeAndNil(LCurrException);
            end;
          end);
      end;
    end);
end;

initialization

DefaultTaskErrorHandler :=
    procedure(const E: Exception; const ExceptionAddress: Pointer)
  begin
    ShowException(E, ExceptionAddress);
  end;

end.
