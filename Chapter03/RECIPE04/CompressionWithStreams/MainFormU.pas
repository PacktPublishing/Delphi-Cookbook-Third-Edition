unit MainFormU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TMainForm = class(TForm)
    btnCompress: TButton;
    btnDeCompress: TButton;
    procedure btnCompressClick(Sender: TObject);
    procedure btnDeCompressClick(Sender: TObject);
  private
    procedure Decompress(const ASrc, ADest: TStream);
    procedure Compress(const ASrc, ADest: TStream);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses
  System.ZLib;

{$R *.dfm}

procedure TMainForm.btnDeCompressClick(Sender: TObject);
var
  LInput: TFileStream;
  LOutput: TFileStream;
begin
  LInput := TFileStream.Create('..\..\file1.zip', fmOpenRead);
  try
    LOutput := TFileStream.Create('..\..\file1.created.txt',
      fmCreate or fmOpenWrite);
    try
      Decompress(LInput, LOutput);
    finally
      LOutput.Free;
    end;
  finally
    LInput.Free;
  end;
end;

procedure TMainForm.Compress(const ASrc, ADest: TStream);
var
  LCompressor: TZCompressionStream;
begin
  LCompressor := TZCompressionStream.Create(ADest);
  try
    LCompressor.CopyFrom(ASrc, 0);
  finally
    LCompressor.Free;
  end;
end;

procedure TMainForm.Decompress(const ASrc, ADest: TStream);
var
  LDecompressor: TZDecompressionStream;
begin
  LDecompressor := TZDecompressionStream.Create(ASrc);
  try
    ADest.CopyFrom(LDecompressor, 0);
  finally
    LDecompressor.Free;
  end;
end;

procedure TMainForm.btnCompressClick(Sender: TObject);
var
  LInput: TFileStream;
  LOutput: TFileStream;
begin
  LInput := TFileStream.Create('..\..\file1.txt', fmOpenRead);
  try
    LOutput := TFileStream.Create('..\..\file1.zip', fmCreate or fmOpenWrite);
    try
      Compress(LInput, LOutput);
    finally
      LOutput.Free;
    end;
  finally
    LInput.Free;
  end;
end;

end.
