object MainForm: TMainForm
  Left = 598
  Top = 207
  BorderStyle = bsToolWindow
  Caption = 'Euro Converter'
  ClientHeight = 117
  ClientWidth = 362
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 13
    Width = 81
    Height = 13
    Caption = 'Currency Symbol'
  end
  object Label2: TLabel
    Left = 143
    Top = 13
    Width = 26
    Height = 13
    Caption = 'Value'
  end
  object Label3: TLabel
    Left = 143
    Top = 69
    Width = 68
    Height = 13
    Caption = 'Value in EURO'
  end
  object EditValue: TEdit
    Left = 143
    Top = 32
    Width = 121
    Height = 21
    Alignment = taRightJustify
    NumbersOnly = True
    TabOrder = 1
  end
  object EditResultInEuro: TEdit
    Left = 143
    Top = 88
    Width = 121
    Height = 21
    Alignment = taRightJustify
    NumbersOnly = True
    ReadOnly = True
    TabOrder = 3
  end
  object btnConvert: TButton
    Left = 270
    Top = 31
    Width = 74
    Height = 23
    Caption = 'Convert'
    TabOrder = 2
    OnClick = btnConvertClick
  end
  object cbSymbol: TComboBox
    Left = 16
    Top = 32
    Width = 121
    Height = 21
    Style = csDropDownList
    TabOrder = 0
    OnClick = cbSymbolClick
  end
end
