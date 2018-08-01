object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'JSON: generate, modify and parse'
  ClientHeight = 444
  ClientWidth = 478
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    478
    444)
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 8
    Top = 63
    Width = 462
    Height = 373
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object btnGenerateJSON: TButton
    Left = 8
    Top = 8
    Width = 150
    Height = 49
    Caption = '1.Generate JSON and write to the Memo'
    TabOrder = 1
    WordWrap = True
    OnClick = btnGenerateJSONClick
  end
  object btnModifyJSON: TButton
    Left = 164
    Top = 8
    Width = 150
    Height = 49
    Caption = '2.Add another car the JSON in the Memo'
    TabOrder = 2
    WordWrap = True
    OnClick = btnModifyJSONClick
  end
  object btnParseJSON: TButton
    Left = 320
    Top = 8
    Width = 150
    Height = 49
    Caption = '3.Parse JSON in the Memo'
    TabOrder = 3
    WordWrap = True
    OnClick = btnParseJSONClick
  end
end
