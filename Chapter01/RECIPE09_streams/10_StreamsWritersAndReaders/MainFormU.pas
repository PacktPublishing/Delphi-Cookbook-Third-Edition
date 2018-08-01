unit MainFormU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TMainForm = class(TForm)
    btnWriteFile: TButton;
    btnReadFile: TButton;
    Memo1: TMemo;
    RadioGroup1: TRadioGroup;
    Label1: TLabel;
    Label2: TLabel;
    procedure btnWriteFileClick(Sender: TObject);
    procedure btnReadFileClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    function GetCurrentEncoding: TEncoding;
    procedure SetGeneratedFileSize(const Value: Integer);
    property GeneratedFileSize: Integer write SetGeneratedFileSize;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  System.IOUtils;

procedure TMainForm.btnReadFileClick(Sender: TObject);
var
  lFileStream: TFileStream;
  lStreamReader: TStreamReader;
begin
  Memo1.Clear;
  lFileStream := TFileStream.Create('test_01', fmOpenRead);
  lStreamReader := TStreamReader.Create(lFileStream, GetCurrentEncoding);
  try
    lStreamReader.OwnStream;
    while not lStreamReader.EndOfStream do
      Memo1.Lines.Add(lStreamReader.ReadLine);

  finally
    lStreamReader.Free;
  end;
end;

procedure TMainForm.btnWriteFileClick(Sender: TObject);
var
  lStreamWriter: TStreamWriter;
  lFileStream: TFileStream;
begin
  lFileStream := TFileStream.Create('test_01', fmCreate);
  lStreamWriter := TStreamWriter.Create(lFileStream, GetCurrentEncoding);
  try
    lStreamWriter.OwnStream;
    lStreamWriter.WriteLine('ما هي الشفرة الموحدة يونيكود؟');
    lStreamWriter.WriteLine('Cos''è Unicode?');
    lStreamWriter.WriteLine('מה זה יוניקוד (Unicode)?');
    lStreamWriter.WriteLine('유니코드에 대해 ?');
    lStreamWriter.Flush;
    GeneratedFileSize := lStreamWriter.BaseStream.Size;
  finally
    lStreamWriter.Free;
  end;
  Memo1.Lines.LoadFromFile('test_01', GetCurrentEncoding);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  RadioGroup1.Items.AddObject('ASCII', TEncoding.ASCII);
  RadioGroup1.Items.AddObject('ANSI', TEncoding.ANSI);
  RadioGroup1.Items.AddObject('Default', TEncoding.Default);
  RadioGroup1.Items.AddObject('UTF8', TEncoding.UTF8);
  RadioGroup1.Items.AddObject('Unicode', TEncoding.Unicode);
  RadioGroup1.ItemIndex := 0;
  GeneratedFileSize := 0;
end;

function TMainForm.GetCurrentEncoding: TEncoding;
begin
  Result := RadioGroup1.Items.Objects[RadioGroup1.ItemIndex] as TEncoding;
end;

procedure TMainForm.SetGeneratedFileSize(const Value: Integer);
begin
  Label2.Caption := Format('Generated file size = %d bytes', [Value]);
end;

end.
