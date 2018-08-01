object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'TDataSet to JSON and back'
  ClientHeight = 369
  ClientWidth = 793
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 190
    Width = 793
    Height = 3
    Cursor = crVSplit
    Align = alBottom
    ExplicitTop = 41
    ExplicitWidth = 183
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 82
    Width = 793
    Height = 108
    Align = alClient
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'ID'
        Width = 44
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FIRST_NAME'
        Width = 145
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'LAST_NAME'
        Width = 145
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'WORK_PHONE_NUMBER'
        Width = 145
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MOBILE_PHONE_NUMBER'
        Width = 145
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'EMAIL'
        Width = 145
        Visible = True
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 793
    Height = 57
    Align = alTop
    TabOrder = 1
    object Button1: TButton
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 140
      Height = 49
      Align = alLeft
      Caption = '1) Current Record As JSONObject'
      TabOrder = 0
      WordWrap = True
      OnClick = Button1Click
    end
    object Button2: TButton
      AlignWithMargins = True
      Left = 150
      Top = 4
      Width = 140
      Height = 49
      Align = alLeft
      Caption = '2) DataSet as JSONArray (from current position)'
      TabOrder = 1
      WordWrap = True
      OnClick = Button2Click
    end
    object Button3: TButton
      AlignWithMargins = True
      Left = 442
      Top = 4
      Width = 140
      Height = 49
      Align = alLeft
      Caption = '4) Load JSONObject as New Record'
      TabOrder = 2
      WordWrap = True
      OnClick = Button3Click
    end
    object Button4: TButton
      AlignWithMargins = True
      Left = 588
      Top = 4
      Width = 140
      Height = 49
      Align = alLeft
      Caption = '5) Load JSONArray as list of new records'
      TabOrder = 3
      WordWrap = True
      OnClick = Button4Click
    end
    object Button5: TButton
      AlignWithMargins = True
      Left = 296
      Top = 4
      Width = 140
      Height = 49
      Align = alLeft
      Caption = '3) Update current record with JSONObject'
      TabOrder = 4
      WordWrap = True
      OnClick = Button5Click
    end
  end
  object DBNavigator1: TDBNavigator
    Left = 0
    Top = 57
    Width = 793
    Height = 25
    DataSource = DataSource1
    Align = alTop
    TabOrder = 2
  end
  object Panel2: TPanel
    Left = 0
    Top = 193
    Width = 793
    Height = 176
    Align = alBottom
    TabOrder = 3
    object Label1: TLabel
      Left = 1
      Top = 1
      Width = 791
      Height = 13
      Align = alTop
      Caption = 'The JSON data used by the TDataSetHelper methods is in this memo'
      Layout = tlBottom
      ExplicitWidth = 327
    end
    object Memo1: TMemo
      Left = 1
      Top = 14
      Width = 791
      Height = 161
      Align = alClient
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Consolas'
      Font.Style = []
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
  object DataSource1: TDataSource
    DataSet = dm.qryPeople
    Left = 208
    Top = 120
  end
end
