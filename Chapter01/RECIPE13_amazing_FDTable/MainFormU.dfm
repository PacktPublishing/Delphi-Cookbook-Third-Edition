object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'The amazing FDTable'
  ClientHeight = 480
  ClientWidth = 951
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 0
    Top = 25
    Width = 951
    Height = 455
    Align = alClient
    DataSource = DataSource1
    PopupMenu = PopupMenu1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnTitleClick = DBGrid1TitleClick
    Columns = <
      item
        Expanded = False
        FieldName = 'PO_NUMBER'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CUST_NO'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SALES_REP'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CustomerTotal'
        Width = 83
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ORDER_STATUS'
        Width = 82
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ORDER_DATE'
        Width = 98
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SHIP_DATE'
        Width = 93
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATE_NEEDED'
        Width = 113
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PAID'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'QTY_ORDERED'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TOTAL_VALUE'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DISCOUNT'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITEM_TYPE'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'AGED'
        Visible = True
      end>
  end
  object DBNavigator1: TDBNavigator
    Left = 0
    Top = 0
    Width = 951
    Height = 25
    DataSource = DataSource1
    Align = alTop
    TabOrder = 1
  end
  object DataSource1: TDataSource
    DataSet = SalesTable
    Left = 440
    Top = 104
  end
  object PopupMenu1: TPopupMenu
    Left = 320
    Top = 344
    object CustomerInfoMenu: TMenuItem
      Caption = 'Customer Info'
      OnClick = CustomerInfoClick
    end
  end
  object EmployeeConnection: TFDConnection
    Params.Strings = (
      'ConnectionDef=EMPLOYEE')
    Connected = True
    LoginPrompt = False
    Left = 516
    Top = 237
  end
  object SalesTable: TFDTable
    Connection = EmployeeConnection
    UpdateOptions.UpdateTableName = 'SALES'
    TableName = 'SALES'
    Left = 568
    Top = 320
  end
end
