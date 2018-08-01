unit MainFormU;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.ScrollBox, FMX.Memo, FMX.Controls.Presentation,
  FMX.StdCtrls, FMX.Layouts, HTTPLayerDMU, FMX.Edit;

type
  TMainForm = class(TForm)
    GridPanelLayout1: TGridPanelLayout;
    btnGet: TButton;
    btnPost: TButton;
    Layout1: TLayout;
    mmResponse: TMemo;
    EditGithubUser: TEdit;
    btnGithub: TButton;
    procedure btnGetClick(Sender: TObject);
    procedure btnPostClick(Sender: TObject);
    procedure btnGithubClick(Sender: TObject);
  private
    { Private declarations }
    procedure UpdateGUI(const Value: THTTPDM.TResponseData);
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses
  System.JSON.Writers, System.JSON.Builders, REST.Types, System.Threading,
  AsyncTask, FMX.Ani, System.Net.HttpClient,
  System.Net.URLClient;

{$R *.fmx}

procedure TMainForm.btnGetClick(Sender: TObject);
const
  URL = 'https://192.168.1.103/people/users';
begin
  (Sender as TControl).Enabled := False;
  Async.Run<THTTPDM.TResponseData>(
    function: THTTPDM.TResponseData
    var
      LHTTPReq: THTTPDM;
      LResp: IHTTPResponse;
    begin
      LHTTPReq := THTTPDM.Create(nil);
      try
        LResp := LHTTPReq.Get(URL);
        if LResp.StatusCode <> 200 then
        begin
          raise Exception.CreateFmt('Error %d: %s', [LResp.StatusCode,
            LResp.StatusText]);
        end;
        Result.ReadedBytes := LHTTPReq.ReadCount;
        Result.Certificate := LHTTPReq.Certificate;
      finally
        LHTTPReq.Free;
      end;
      Result.Response := LResp;
    end,
    procedure(const Value: THTTPDM.TResponseData)
    begin
      UpdateGUI(Value);
      (Sender as TControl).Enabled := True;
    end);

end;

procedure TMainForm.btnGithubClick(Sender: TObject);
const
  URL = 'https://api.github.com/users/%s';
var
  LGithubuser: String;
begin
  LGithubuser := EditGithubUser.Text;
  (Sender as TControl).Enabled := False;
  Async.Run<THTTPDM.TResponseData>(
    function: THTTPDM.TResponseData
    var
      LHTTPReq: THTTPDM;
      LResp: IHTTPResponse;
    begin
      LHTTPReq := THTTPDM.Create(nil);
      try
        LResp := LHTTPReq.Get(Format(URL, [LGithubuser]));
        if LResp.StatusCode <> 200 then
        begin
          raise Exception.CreateFmt('Error %d: %s', [LResp.StatusCode,
            LResp.StatusText]);
        end;
        Result.ReadedBytes := LHTTPReq.ReadCount;
        Result.Certificate := LHTTPReq.Certificate;
      finally
        LHTTPReq.Free;
      end;
      Result.Response := LResp;
    end,
    procedure(const Value: THTTPDM.TResponseData)
    begin
      UpdateGUI(Value);
      (Sender as TControl).Enabled := True;
    end);

end;

procedure TMainForm.btnPostClick(Sender: TObject);
const
  URL = 'https://192.168.1.103/people/users';
begin
  (Sender as TControl).Enabled := False;
  Async.Run<THTTPDM.TResponseData>(
    function: THTTPDM.TResponseData
    var
      LJSONStream: TStringStream;
      LJSONWriter: TJsonWriter;
      LStreamWriter: TStreamWriter;
      LJSONObjectBuilder: TJSONObjectBuilder;
      LHeaders: TNetHeaders;
      LHTTPReq: THTTPDM;
      LResp: IHTTPResponse;
    begin
      LHTTPReq := THTTPDM.Create(nil);
      try
        LJSONStream := TStringStream.Create;
        try
          LStreamWriter := TStreamWriter.Create(LJSONStream);
          try
            LJSONWriter := TJsonTextWriter.Create(LStreamWriter);
            try
              LJSONObjectBuilder := TJSONObjectBuilder.Create(LJSONWriter);
              try
                LJSONObjectBuilder.BeginObject.Add('first_name', 'Daniele')
                  .Add('last_name', 'Teti').Add('email', 'd.teti@bittime.it')
                  .EndObject;
                LJSONWriter.Flush;
                LJSONStream.Position := 0;
                LHeaders := [TNetHeader.Create('content-type',
                  CONTENTTYPE_APPLICATION_JSON)];
                LResp := LHTTPReq.Post(URL, LJSONStream, LHeaders);
                if LResp.StatusCode <> 201 then
                begin
                  raise Exception.CreateFmt('Error %d: %s', [LResp.StatusCode,
                    LResp.StatusText]);
                end;
              finally
                LJSONObjectBuilder.Free;
              end;
            finally
              LJSONWriter.Free;
            end;
          finally
            LStreamWriter.Free;
          end;
        finally
          LJSONStream.Free;
        end;
        Result.ReadedBytes := LHTTPReq.ReadCount;
        Result.Certificate := LHTTPReq.Certificate;
      finally
        LHTTPReq.Free;
      end;
      Result.Response := LResp;
    end,
    procedure(const Value: THTTPDM.TResponseData)
    begin
      UpdateGUI(Value);
      (Sender as TControl).Enabled := True;
    end);
end;

procedure TMainForm.UpdateGUI(const Value: THTTPDM.TResponseData);
begin
  mmResponse.Lines.Clear;
  if not Value.Certificate.Subject.IsEmpty then
  begin
    mmResponse.Lines.Add('** Certificate Validity: from ' +
      DateToStr(Value.Certificate.Start) + ' to ' +
      DateToStr(Value.Certificate.Expiry));
    mmResponse.Lines.Add(sLineBreak + '** Certificate Subject: ' +
      Value.Certificate.Subject.Replace(sLineBreak, ', '));
  end
  else
  begin
    mmResponse.Lines.Add(sLineBreak + '** Certificate is not self-signed');
  end;
  mmResponse.Lines.Add(sLineBreak + '** Total bytes read: ' +
    Value.ReadedBytes.ToString);
  mmResponse.Lines.Add(sLineBreak + '** Headers: ' + sLineBreak +
    String.Join(sLineBreak, Value.HeadersAsStrings));
  mmResponse.Lines.Add(sLineBreak + '** Content charset: ' + sLineBreak +
    Value.Response.ContentCharSet);
  mmResponse.Lines.Add(sLineBreak + '** Response Status: ' + sLineBreak +
    Value.Response.StatusCode.ToString + ': ' + Value.Response.StatusText);
  mmResponse.Lines.Add(sLineBreak + '** Response body: ' + sLineBreak +
    Value.Response.ContentAsString);
end;

end.
