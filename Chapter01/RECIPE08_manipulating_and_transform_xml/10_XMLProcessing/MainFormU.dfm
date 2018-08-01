object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'XML: generate, modify and parse'
  ClientHeight = 386
  ClientWidth = 637
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    637
    386)
  PixelsPerInch = 96
  TextHeight = 13
  object btnGenerateXML: TButton
    Left = 8
    Top = 8
    Width = 150
    Height = 49
    Caption = '1.Generate XML and write to the Memo'
    TabOrder = 0
    WordWrap = True
    OnClick = btnGenerateXMLClick
  end
  object btnParseXML: TButton
    Left = 320
    Top = 8
    Width = 150
    Height = 49
    Caption = '3.Parse XML in the Memo'
    TabOrder = 1
    WordWrap = True
    OnClick = btnParseXMLClick
  end
  object Memo1: TMemo
    Left = 8
    Top = 63
    Width = 621
    Height = 315
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object btnModifyXML: TButton
    Left = 164
    Top = 8
    Width = 150
    Height = 49
    Caption = '2.Add another car the XML in the Memo'
    TabOrder = 3
    WordWrap = True
    OnClick = btnModifyXMLClick
  end
  object btnTransform: TButton
    Left = 476
    Top = 8
    Width = 150
    Height = 49
    Caption = '4. Transform XML to HTML'
    TabOrder = 4
    OnClick = btnTransformClick
  end
  object XMLDocument1: TXMLDocument
    Left = 48
    Top = 104
    DOMVendorDesc = 'Omni XML'
  end
end
