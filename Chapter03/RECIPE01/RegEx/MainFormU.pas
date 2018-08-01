unit MainFormU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TRegExForm = class(TForm)
    EditEMail: TEdit;
    EditTaxCodeIT: TEdit;
    EditIP: TEdit;
    btnCheckEmail: TButton;
    btnCheckItalianTaxCode: TButton;
    btnCheckIP: TButton;
    procedure btnCheckIPClick(Sender: TObject);
    procedure btnCheckEmailClick(Sender: TObject);
    procedure btnCheckItalianTaxCodeClick(Sender: TObject);
  private
    { Private declarations }
  public

  end;

var
  RegExForm: TRegExForm;

implementation

uses
  System.RegularExpressions;

{$R *.dfm}


procedure TRegExForm.btnCheckEmailClick(Sender: TObject);
begin
  // Email RegEx from http://www.regular-expressions.info/email.html
  if TRegEx.IsMatch(EditEMail.Text, '^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$', [roIgnoreCase]) then
    ShowMessage('EMail address is valid')
  else
    ShowMessage('EMail address is not valid');
end;

procedure TRegExForm.btnCheckIPClick(Sender: TObject);
begin
  if TRegEx.IsMatch(EditIP.Text, '^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$') then
    ShowMessage('IPv4 address is valid')
  else
    ShowMessage('IPv4 address is not valid');
end;

procedure TRegExForm.btnCheckItalianTaxCodeClick(Sender: TObject);
begin
  // This is a valid ITALIAN TAX CODE --> RSSMRA79S04H501V
  if TRegEx.IsMatch(EditTaxCodeIT.Text, '^[A-Z]{6}[0-9]{2}[A-Z][0-9]{2}[A-Z][0-9]{3}[A-Z]$', [roIgnoreCase]) then
    ShowMessage('This italian tax code is valid')
  else
    ShowMessage('This italian tax code is not valid');
end;

end.
