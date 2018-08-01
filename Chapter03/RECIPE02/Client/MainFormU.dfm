object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'REST People Manager Client'
  ClientHeight = 477
  ClientWidth = 797
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Label5: TLabel
    Left = 8
    Top = 392
    Width = 24
    Height = 13
    Caption = 'Email'
  end
  object Label6: TLabel
    Left = 332
    Top = 285
    Width = 154
    Height = 13
    Caption = 'Current record in grid (as JSON)'
  end
  object pcMain: TPageControl
    Left = 0
    Top = 0
    Width = 797
    Height = 477
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'List of entities'
      object btnOpen: TButton
        Left = 3
        Top = 11
        Width = 89
        Height = 25
        Caption = 'Open'
        TabOrder = 0
        OnClick = btnOpenClick
      end
      object DBNavigator1: TDBNavigator
        Left = 98
        Top = 11
        Width = 240
        Height = 25
        DataSource = dsrcPeople
        TabOrder = 1
      end
      object DBGrid1: TDBGrid
        AlignWithMargins = True
        Left = 3
        Top = 42
        Width = 783
        Height = 404
        Align = alBottom
        Anchors = [akLeft, akTop, akRight, akBottom]
        DataSource = dsrcPeople
        TabOrder = 2
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'ID'
            Width = 65
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'FIRST_NAME'
            Width = 140
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'LAST_NAME'
            Width = 140
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'WORK_PHONE_NUMBER'
            Width = 130
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'MOBILE_PHONE_NUMBER'
            Width = 130
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'EMAIL'
            Width = 150
            Visible = True
          end>
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Single entity'
      ImageIndex = 1
      object Label7: TLabel
        Left = 16
        Top = 80
        Width = 50
        Height = 13
        Caption = 'First name'
        FocusControl = DBEdit6
      end
      object Label8: TLabel
        Left = 16
        Top = 136
        Width = 63
        Height = 13
        Caption = 'Mobile Phone'
        FocusControl = DBEdit7
      end
      object Label9: TLabel
        Left = 172
        Top = 136
        Width = 58
        Height = 13
        Caption = 'Work Phone'
        FocusControl = DBEdit8
      end
      object Label10: TLabel
        Left = 172
        Top = 80
        Width = 49
        Height = 13
        Caption = 'Last name'
        FocusControl = DBEdit9
      end
      object Label1: TLabel
        Left = 16
        Top = 185
        Width = 24
        Height = 13
        Caption = 'eMail'
        FocusControl = DBEdit7
      end
      object EditSearch: TEdit
        Left = 16
        Top = 19
        Width = 150
        Height = 21
        TabOrder = 0
        TextHint = 'Find a person by id...'
      end
      object Button1: TButton
        Left = 172
        Top = 17
        Width = 75
        Height = 25
        Caption = 'Get by ID'
        TabOrder = 1
        OnClick = btnGetPersonClick
      end
      object DBEdit6: TDBEdit
        Left = 16
        Top = 96
        Width = 150
        Height = 21
        DataField = 'FIRST_NAME'
        DataSource = dsrcPerson
        TabOrder = 2
      end
      object DBEdit7: TDBEdit
        Left = 16
        Top = 152
        Width = 150
        Height = 21
        DataField = 'MOBILE_PHONE_NUMBER'
        DataSource = dsrcPerson
        TabOrder = 3
      end
      object DBEdit8: TDBEdit
        Left = 172
        Top = 152
        Width = 150
        Height = 21
        DataField = 'WORK_PHONE_NUMBER'
        DataSource = dsrcPerson
        TabOrder = 4
      end
      object DBEdit9: TDBEdit
        Left = 172
        Top = 96
        Width = 150
        Height = 21
        DataField = 'LAST_NAME'
        DataSource = dsrcPerson
        TabOrder = 5
      end
      object DBEdit10: TDBEdit
        Left = 16
        Top = 200
        Width = 150
        Height = 21
        DataField = 'EMAIL'
        DataSource = dsrcPerson
        TabOrder = 6
      end
      object DBNavigator2: TDBNavigator
        Left = 16
        Top = 255
        Width = 114
        Height = 25
        DataSource = dsrcPerson
        VisibleButtons = [nbPost, nbCancel]
        TabOrder = 7
      end
    end
  end
  object dsrcPeople: TDataSource
    DataSet = dsPeople
    Left = 232
    Top = 136
  end
  object dsrcPerson: TDataSource
    DataSet = dsPerson
    Left = 232
    Top = 192
  end
  object dsPeople: TFDMemTable
    AfterOpen = dsPeopleAfterOpen
    BeforePost = dsPeopleBeforePost
    BeforeDelete = dsPeopleBeforeDelete
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    StoreDefs = True
    Left = 168
    Top = 192
    object dsPeopleID: TStringField
      FieldName = 'ID'
      Size = 255
    end
    object dsPeopleFIRST_NAME: TStringField
      DisplayLabel = 'First name'
      DisplayWidth = 50
      FieldName = 'FIRST_NAME'
      Size = 255
    end
    object dsPeopleLAST_NAME: TStringField
      DisplayLabel = 'Last name'
      DisplayWidth = 50
      FieldName = 'LAST_NAME'
      Size = 255
    end
    object dsPeopleWORK_PHONE_NUMBER: TStringField
      DisplayLabel = 'Work Phone'
      DisplayWidth = 50
      FieldName = 'WORK_PHONE_NUMBER'
      Size = 255
    end
    object dsPeopleMOBILE_PHONE_NUMBER: TStringField
      DisplayLabel = 'Mobile Phone'
      FieldName = 'MOBILE_PHONE_NUMBER'
      Size = 50
    end
    object dsPeopleEMAIL: TStringField
      DisplayLabel = 'eMail'
      DisplayWidth = 50
      FieldName = 'EMAIL'
      Size = 255
    end
  end
  object dsPerson: TFDMemTable
    BeforePost = dsPersonBeforePost
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    StoreDefs = True
    Left = 168
    Top = 136
    object dsPersonID: TStringField
      FieldName = 'ID'
      Size = 255
    end
    object dsPersonFIRST_NAME: TStringField
      FieldName = 'FIRST_NAME'
      Size = 255
    end
    object dsPersonLAST_NAME: TStringField
      FieldName = 'LAST_NAME'
      Size = 255
    end
    object dsPersonWORK_PHONE_NUMBER: TStringField
      FieldName = 'WORK_PHONE_NUMBER'
      Size = 255
    end
    object dsPersonMOBILE_PHONE_NUMBER: TStringField
      FieldName = 'MOBILE_PHONE_NUMBER'
      Size = 255
    end
    object dsPersonEMAIL: TStringField
      FieldName = 'EMAIL'
      Size = 255
    end
  end
end
