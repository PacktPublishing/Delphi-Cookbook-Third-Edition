unit MainFormU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.NetEncoding, Vcl.StdCtrls,
  Vcl.ExtCtrls;

type
  TMainForm = class(TForm)
    GroupBox1: TGroupBox;
    btnGetPhoto: TButton;
    Image1: TImage;
    EditPersonID: TEdit;
    GroupBox2: TGroupBox;
    btnGetPeople: TButton;
    EditSearch: TEdit;
    lbPeople: TListBox;
    procedure btnGetPhotoClick(Sender: TObject);
    procedure btnGetPeopleClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses
  System.Net.HttpClient, Vcl.Imaging.pngimage, PersonBO, MVCFramework.Serializer.JSON,
  System.Generics.Collections, System.JSON, MVCFramework.Serializer.Intf;

{$R *.dfm}

procedure TMainForm.btnGetPeopleClick(Sender: TObject);
var
  LHTTP: THTTPClient;
  LResponse: IHTTPResponse;
  LURLFormat, LQuery: string;
  LPeople: TObjectList<TPerson>;
  LJArr: TJSONArray;
  LPerson: TPerson;
  LSerializer: IMVCSerializer;
begin
  LHTTP := THTTPClient.Create;
  try
    LURLFormat := 'http://localhost:8080/people/searches?query=%s';
    // encode the parameter
    LQuery := TNetEncoding.URL.Encode(EditSearch.Text);
    // send the HTTP request
    LResponse := LHTTP.Get(Format(LURLFormat, [LQuery]));
    // check for errors
    if LResponse.StatusCode <> 200 then
    begin
      ShowMessage(LResponse.StatusText);
      Exit;
    end;

    // load data into the TListBox
    LPeople := TObjectList<TPerson>.Create(true);
    try
      LJArr := TJSONObject.ParseJSONValue(LResponse.ContentAsString)
        as TJSONArray;

      // convert the json array into list of TPerson using the
      // class Mapper contained in ObjectMappers.pas (from the
      // DelphiMVCFramework project)
      LSerializer := TMVCJSONSerializer.Create;
      LSerializer.DeserializeCollection(LJArr.ToJSON, LPeople, TPerson );

      // finally load the object list into the TListBox
      lbPeople.Items.BeginUpdate;
      try
        lbPeople.Clear;
        for LPerson in LPeople do
        begin
          lbPeople.Items.Add(LPerson.ToString + ' (' + LPerson.EMAIL + ')');
        end;
      finally
        lbPeople.Items.EndUpdate;
      end;
    finally
      LPeople.Free;
    end;
  finally
    LHTTP.Free;
  end;
end;

procedure TMainForm.btnGetPhotoClick(Sender: TObject);
var
  LHTTP: THTTPClient;
  LResponse: IHTTPResponse;
  LPNGStream: TMemoryStream;
  LPNGImage: TPngImage;
  LURLFormat: string;
begin
  LHTTP := THTTPClient.Create;
  try
    LURLFormat := 'http://localhost:8080/people/%s/photo';
    LResponse := LHTTP.Get(Format(LURLFormat, [EditPersonID.Text]));
    if LResponse.StatusCode <> 200 then
    begin
      ShowMessage(LResponse.StatusText);
      Exit;
    end;
    LPNGStream := TMemoryStream.Create;
    try
      if TNetEncoding.Base64.Decode(LResponse.ContentStream, LPNGStream) = 0
      then
        raise Exception.Create('Invalid Base64 stream');
      LPNGImage := TPngImage.Create;
      try
        LPNGStream.Position := 0;
        LPNGImage.LoadFromStream(LPNGStream);
        Image1.Picture.Assign(LPNGImage);
      finally
        LPNGImage.Free;
      end;
    finally
      LPNGStream.Free;
    end;
  finally
    LHTTP.Free;
  end;
end;

end.
