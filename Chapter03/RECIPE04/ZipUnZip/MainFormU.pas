unit MainFormU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TMainForm = class(TForm)
    btnZipUnZip: TButton;
    MemoSummary: TMemo;
    procedure btnZipUnZipClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses
  System.Zip;

{$R *.dfm}

procedure TMainForm.btnZipUnZipClick(Sender: TObject);
var
  ZF: TZipFile;
  I: Integer;
begin
  MemoSummary.Clear;
  // this single statement zip recursively a folder in a zip file
  TZipFile.ZipDirectoryContents('MyFolder.zip', 'FolderToZip');

  // let's inspect the content of the zip file...
  ZF := TZipFile.Create;
  try
    // open the zip file to read information
    ZF.Open('MyFolder.zip', TZipMode.zmRead);
    // create table headers...
    MemoSummary.Lines.Add('Filename'.PadRight(15) + 'Compressed Size'.PadLeft
      (20) + 'Uncompressed Size'.PadLeft(20));
    MemoSummary.Lines.Add(''.PadRight(55, '-'));

    // loop through the compressed file and extract information
    // about name, original size and compressed size
    for I := 0 to ZF.FileCount - 1 do
    begin
      MemoSummary.Lines.Add(TEncoding.Default.GetString(ZF.FileInfo[I].FileName)
        .PadRight(15) + FormatFloat('###,###,##0',
        ZF.FileInfo[I].CompressedSize).PadLeft(20) + FormatFloat('###,###,##0',
        ZF.FileInfo[I].UncompressedSize).PadLeft(20));
    end;
  finally
    ZF.Free;
  end;
  // now actually uncompress the file into a folder
  TZipFile.ExtractZipFile('MyFolder.zip', 'UnzippedFolder');
end;

end.
