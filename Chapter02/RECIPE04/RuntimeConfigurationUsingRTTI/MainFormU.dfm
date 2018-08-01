object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'Configure calculation at runtime using RTTI'
  ClientHeight = 142
  ClientWidth = 439
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 24
    Width = 30
    Height = 13
    Caption = 'PRICE'
    FocusControl = DBEdit1
  end
  object Label2: TLabel
    Left = 116
    Top = 27
    Width = 51
    Height = 13
    Caption = 'QUANTITY'
    FocusControl = DBEdit2
  end
  object Label3: TLabel
    Left = 181
    Top = 27
    Width = 52
    Height = 13
    Caption = 'DISCOUNT'
    FocusControl = DBEdit3
  end
  object Label4: TLabel
    Left = 268
    Top = 27
    Width = 32
    Height = 13
    Caption = 'TOTAL'
    FocusControl = DBEdit4
  end
  object Label5: TLabel
    Left = 0
    Top = 123
    Width = 439
    Height = 19
    Align = alBottom
    Caption = 'Label5'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    WordWrap = True
    ExplicitWidth = 46
  end
  object DBEdit1: TDBEdit
    Left = 16
    Top = 43
    Width = 89
    Height = 21
    DataField = 'PRICE'
    DataSource = DataSource1
    TabOrder = 0
  end
  object DBEdit2: TDBEdit
    Left = 116
    Top = 43
    Width = 51
    Height = 21
    DataField = 'QUANTITY'
    DataSource = DataSource1
    TabOrder = 1
  end
  object DBEdit3: TDBEdit
    Left = 181
    Top = 43
    Width = 52
    Height = 21
    DataField = 'DISCOUNT'
    DataSource = DataSource1
    TabOrder = 2
  end
  object DBEdit4: TDBEdit
    Left = 268
    Top = 43
    Width = 134
    Height = 21
    DataField = 'TOTAL'
    DataSource = DataSource1
    ReadOnly = True
    TabOrder = 3
  end
  object ClientDataSet1: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    OnCalcFields = ClientDataSet1CalcFields
    Left = 240
    Top = 88
    Data = {
      5E0000009619E0BD0100000018000000030000000000030000005E0005505249
      4345080004000000010007535542545950450200490006004D6F6E6579000851
      55414E54495459040001000000000008444953434F554E540800040000000000
      0000}
    object ClientDataSet1PRICE: TCurrencyField
      FieldName = 'PRICE'
    end
    object ClientDataSet1QUANTITY: TIntegerField
      FieldName = 'QUANTITY'
    end
    object ClientDataSet1DISCOUNT: TFloatField
      FieldName = 'DISCOUNT'
    end
    object ClientDataSet1TOTAL: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'TOTAL'
      Calculated = True
    end
  end
  object DataSource1: TDataSource
    DataSet = ClientDataSet1
    Left = 320
    Top = 88
  end
end
