unit MainFormU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Xml.xmldom, Xml.XMLIntf,
  Xml.Win.msxmldom, Xml.XMLDoc, Xml.adomxmldom, Xml.omnixmldom;

type
  TMainForm = class(TForm)
    btnGenerateXML: TButton;
    btnParseXML: TButton;
    Memo1: TMemo;
    XMLDocument1: TXMLDocument;
    btnModifyXML: TButton;
    btnTransform: TButton;
    procedure btnGenerateXMLClick(Sender: TObject);
    procedure btnParseXMLClick(Sender: TObject);
    procedure btnModifyXMLClick(Sender: TObject);
    procedure btnTransformClick(Sender: TObject);
  private
    procedure SetXML(const Value: String);
    function GetXML: String;
  public
    property Xml: String read GetXML write SetXML;
  end;

var
  MainForm: TMainForm;

implementation

uses
  System.IOUtils, Winapi.ShellAPI;

{$R *.dfm}

type
  TCarInfo = (Manufacturer = 1, Name = 2, Currency = 3, Price = 4);

var
  Cars: array [1 .. 4] of array [Manufacturer .. Price] of string = (
    (
      'Ferrari',
      '360 Modena',
      'EUR',
      '250,000'
    ),
    (
      'Ford',
      'Mustang',
      'USD',
      '80,000'
    ),
    (
      'Lamborghini',
      'Countach',
      'EUR',
      '300,000'
    ),
    (
      'Chevrolet',
      'Corvette',
      'USD',
      '100,000'
    )
  );

procedure TMainForm.btnGenerateXMLClick(Sender: TObject);
var
  RootNode, Car, CarPrice: IXMLNode;
  i: Integer;
  s: String;
begin
  XMLDocument1.Active := True;
  try
    XMLDocument1.Version := '1.0';
    RootNode := XMLDocument1.AddChild('cars');
    for i := Low(Cars) to High(Cars) do
    begin
      Car := XMLDocument1.CreateNode('car');
      Car.AddChild('manufacturer').Text := Cars[i][TCarInfo.Manufacturer];
      Car.AddChild('name').Text := Cars[i][TCarInfo.Name];
      CarPrice := Car.AddChild('price');
      CarPrice.Attributes['currency'] := Cars[i][TCarInfo.Currency];
      CarPrice.Text := Cars[i][TCarInfo.Price];
      RootNode.ChildNodes.Add(Car);
    end;
    XMLDocument1.SaveToXML(s);
    Xml := s;
  finally
    XMLDocument1.Active := False;
  end;
end;

procedure TMainForm.btnModifyXMLClick(Sender: TObject);
var
  Car, CarPrice: IXMLNode;
  s: string;
begin
  XMLDocument1.LoadFromXML(Xml);
  try
    Xml := '';
    Car := XMLDocument1.CreateNode('car');
    Car.AddChild('manufacturer').Text := 'Hennessey';
    Car.AddChild('name').Text := 'Venom GT';
    CarPrice := Car.AddChild('price');
    CarPrice.Attributes['currency'] := 'USD';
    CarPrice.Text := '600,000';
    XMLDocument1.DocumentElement.ChildNodes.Add(Car);
    XMLDocument1.SaveToXML(s);
    Xml := s;
  finally
    XMLDocument1.Active := False;
  end;
end;

procedure TMainForm.btnParseXMLClick(Sender: TObject);
var
  CarsList: IDOMNodeList;
  CurrNode: IDOMNode;
  childidx, i: Integer;
  CarName, CarManufacturer, CarPrice, CarCurrencyType: string;
begin
  XMLDocument1.LoadFromXML(Xml);
  try
    Xml := '';
    CarsList := XMLDocument1.DOMDocument.getElementsByTagName('car');
    for i := 0 to CarsList.length - 1 do
    begin
      CarName := '';
      CarManufacturer := '';
      CarPrice := '';
      CarCurrencyType := '';
      for childidx := 0 to CarsList[i].ChildNodes.length - 1 do
      begin
        CurrNode := CarsList[i].ChildNodes[childidx];
        if CurrNode.nodeName.Equals('name') then
          CarName := CurrNode.firstChild.nodeValue;
        if CurrNode.nodeName.Equals('manufacturer') then
          CarManufacturer := CurrNode.firstChild.nodeValue;
        if CurrNode.nodeName.Equals('price') then
        begin
          CarPrice := CurrNode.firstChild.nodeValue;
          CarCurrencyType := CurrNode.Attributes.getNamedItem('currency')
            .nodeValue;
        end;
      end;
      Xml := Xml + 'Name = ' + CarName + sLineBreak + 'Manufacturer = ' +
        CarManufacturer + sLineBreak + 'Price = ' + CarPrice + CarCurrencyType +
        sLineBreak + '-----' + sLineBreak;
    end;
  finally
    XMLDocument1.Active := False;
  end;
end;

function Transform(XMLData: string; XSLT: string): String;
var
  LXML, LXSL: IXMLDocument;
  LOutput: WideString;
begin
  LXML := LoadXMLData(XMLData);
  LXSL := LoadXMLData(XSLT);
  LXML.DocumentElement.TransformNode(LXSL.DocumentElement, LOutput);
  Result := String(LOutput);
end;

procedure TMainForm.btnTransformClick(Sender: TObject);
var
  LXML, LXSL: string;
  LOutput: string;
begin
  LXML := TFile.ReadAllText('..\..\..\cars.xml');
  LXSL := TFile.ReadAllText('..\..\..\cars.xslt');
  LOutput := Transform(LXML, LXSL);
  TFile.WriteAllText('..\..\..\cars.html', LOutput);
  ShellExecute(0, PChar('open'),
    PChar('file:///' + TPath.GetFullPath('..\..\..\cars.html')), nil,
    nil, SW_SHOW);
end;

function TMainForm.GetXML: String;
begin
  Result := Memo1.Lines.Text;
end;

procedure TMainForm.SetXML(const Value: String);
begin
  Memo1.Lines.Text := Value;
end;

end.
