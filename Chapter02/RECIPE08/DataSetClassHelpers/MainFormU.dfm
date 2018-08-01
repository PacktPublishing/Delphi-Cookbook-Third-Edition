object ClassHelpersForm: TClassHelpersForm
  Left = 0
  Top = 0
  Caption = 'Class Helper for TDataSet'
  ClientHeight = 328
  ClientWidth = 436
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    436
    328)
  PixelsPerInch = 96
  TextHeight = 13
  object btnSaveToCSV: TButton
    Left = 8
    Top = 8
    Width = 137
    Height = 41
    Caption = 'SaveToCSV'
    TabOrder = 0
    OnClick = btnSaveToCSVClick
  end
  object ListBox1: TListBox
    Left = 8
    Top = 55
    Width = 417
    Height = 265
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object btnIterate: TButton
    Left = 151
    Top = 8
    Width = 137
    Height = 41
    Caption = 'Iterate on DataSet'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = btnIterateClick
  end
  object FDMemTable1: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 200
    Top = 88
  end
  object FDStanStorageXMLLink1: TFDStanStorageXMLLink
    Left = 200
    Top = 160
  end
end
