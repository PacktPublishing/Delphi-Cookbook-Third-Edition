object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'ETL made easy: TFDBatchMove'
  ClientHeight = 404
  ClientWidth = 652
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 652
    Height = 404
    ActivePage = TabSheet3
    Align = alClient
    TabOrder = 0
    object TabSheet3: TTabSheet
      Caption = 'ETL'
      ImageIndex = 2
      object Button1: TButton
        Left = 0
        Top = 21
        Width = 644
        Height = 64
        Align = alTop
        Caption = 'Execute!'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 30
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = Button1Click
        ExplicitTop = 15
      end
      object DBGrid2: TDBGrid
        Left = 0
        Top = 110
        Width = 644
        Height = 120
        Align = alTop
        DataSource = dsCustomer
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
      object DBGrid3: TDBGrid
        Left = 0
        Top = 255
        Width = 644
        Height = 121
        Align = alClient
        DataSource = dsCustomers
        TabOrder = 2
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
      object Panel1: TPanel
        Left = 0
        Top = 85
        Width = 644
        Height = 25
        Align = alTop
        Alignment = taLeftJustify
        Caption = 'Customer Table'
        TabOrder = 3
      end
      object Panel2: TPanel
        Left = 0
        Top = 230
        Width = 644
        Height = 25
        Align = alTop
        Alignment = taLeftJustify
        Caption = 'Customers Table'
        TabOrder = 4
      end
      object ComboBox1: TComboBox
        Left = 0
        Top = 0
        Width = 644
        Height = 21
        Align = alTop
        TabOrder = 5
        Text = 'Choose operation'
        Items.Strings = (
          'CSV to Table'
          'Table to Table'
          'Table to CSV')
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Settings'
      ImageIndex = 1
      object btnResetData: TButton
        Left = 16
        Top = 16
        Width = 145
        Height = 41
        Caption = 'Reset Data'
        TabOrder = 0
        OnClick = btnResetDataClick
      end
      object btnOpenDatasets: TButton
        Left = 16
        Top = 80
        Width = 145
        Height = 41
        Caption = 'Open Datasets'
        TabOrder = 1
        OnClick = btnOpenDatasetsClick
      end
    end
  end
  object FDBatchMove: TFDBatchMove
    Mappings = <>
    LogFileAction = laCreate
    LogFileName = 'Data.log'
    LogFileEncoding = ecUTF8
    Left = 456
    Top = 216
  end
  object CustomersTable: TFDQuery
    Connection = DelphicookbookConnection
    SQL.Strings = (
      'select * from {id CUSTOMERS}')
    Left = 576
    Top = 320
  end
  object dsCustomers: TDataSource
    DataSet = CustomersTable
    Left = 448
    Top = 320
  end
  object CustomerTable: TFDQuery
    Connection = EmployeeConnection
    SQL.Strings = (
      
        'select CUST_NO as ID, CONTACT_FIRST as FIRSTNAME, CONTACT_LAST a' +
        's LASTNAME from {id CUSTOMER}')
    Left = 572
    Top = 144
  end
  object dsCustomer: TDataSource
    DataSet = CustomerTable
    Left = 500
    Top = 144
  end
  object EmployeeConnection: TFDConnection
    Params.Strings = (
      'ConnectionDef=EMPLOYEE')
    LoginPrompt = False
    Left = 330
    Top = 151
  end
  object DelphicookbookConnection: TFDConnection
    Params.Strings = (
      'ConnectionDef=DELPHICOOKBOOK')
    LoginPrompt = False
    Left = 248
    Top = 306
  end
end
