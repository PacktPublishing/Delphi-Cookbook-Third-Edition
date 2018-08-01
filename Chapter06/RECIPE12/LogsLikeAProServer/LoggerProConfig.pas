unit LoggerProConfig;

interface

uses
  LoggerPro;

const
  LOG_TAG = 'PHONEBOOK_SERVER';

function Log: ILogWriter;

implementation

uses
  LoggerPro.FileAppender,
  LoggerPro.EMailAppender,
  LoggerPro.OutputDebugStringAppender,
  LoggerPro.UDPSyslogAppender,
  System.SysUtils,
  idSMTP, System.IOUtils,
  IdIOHandlerStack, IdSSL,
  IdSSLOpenSSL, IdExplicitTLSClientServerBase;

var
  _Log: ILogWriter;

function Log: ILogWriter;
begin
  Result := _Log;
end;

function GetSMTP: TidSMTP;
begin
  Result := TidSMTP.Create(nil);
  try
    Result.IOHandler := TIdSSLIOHandlerSocketOpenSSL.Create(Result);
    Result.Host := 'smtp.gmail.com';
    Result.Port := 25;
    Result.UseTLS := TIdUseTLS.utUseImplicitTLS;
    Result.AuthType := satDefault;
    Result.Username := 'daniele.spinetti@bittime.it';
    if not TFile.Exists('config.txt') then
      raise Exception.Create
        ('Create a "config.txt" file containing the password');
    Result.Password := TFile.ReadAllText('config.txt'); // '<yourpassword>';
  except
    Result.Free;
    raise;
  end;
end;

procedure SetupLogger;
const

{$IFDEF DEBUG}
  LOG_LEVEL = TLogType.Debug;

{$ELSE}
  LOG_LEVEL = TLogType.Warning;

{$ENDIF}
var
  lEmailAppender: ILogAppender;
begin
  lEmailAppender := TLoggerProEMailAppender.Create(GetSMTP,
    'LoggerPro<daniele.spinetti@bittime.it>', 'd.spinetti@bittime.it');
  lEmailAppender.SetLogLevel(TLogType.Error);
  _Log := BuildLogWriter([TLoggerProFileAppender.Create, lEmailAppender,
    TLoggerProOutputDebugStringAppender.Create,
    TLoggerProUDPSyslogAppender.Create('127.0.0.1', 514 // UDPClientPort.Value
    , 'COMPUTER', 'd.spinetti', 'PhoneBookServer', '0.0.1', '', True, False)], nil, LOG_LEVEL);
end;

initialization

SetupLogger;

end.
