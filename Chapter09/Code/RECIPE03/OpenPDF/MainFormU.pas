unit MainFormU;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.Controls,
  FMX.Controls.Presentation;

type
  TMainForm = class(TForm)
    Header: TToolBar;
    Footer: TToolBar;
    HeaderLabel: TLabel;
    btnOpenPDF: TButton;
    procedure btnOpenPDFClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses
  System.IOUtils, xPlat.OpenPDF;

{$R *.fmx}


procedure TMainForm.btnOpenPDFClick(Sender: TObject);
begin
  OpenPDF('samplefile.pdf');
end;

end.
