object Form9: TForm9
  Left = 0
  Top = 0
  Caption = 'REST People Manager Client'
  ClientHeight = 473
  ClientWidth = 748
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    748
    473)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 288
    Width = 50
    Height = 13
    Caption = 'First name'
    FocusControl = DBEdit1
  end
  object Label2: TLabel
    Left = 8
    Top = 344
    Width = 63
    Height = 13
    Caption = 'Mobile Phone'
    FocusControl = DBEdit2
  end
  object Label3: TLabel
    Left = 164
    Top = 344
    Width = 58
    Height = 13
    Caption = 'Work Phone'
    FocusControl = DBEdit3
  end
  object Label4: TLabel
    Left = 164
    Top = 288
    Width = 49
    Height = 13
    Caption = 'Last name'
    FocusControl = DBEdit4
  end
  object Label5: TLabel
    Left = 8
    Top = 392
    Width = 24
    Height = 13
    Caption = 'Email'
    FocusControl = DBEdit5
  end
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Get All'
    TabOrder = 0
    OnClick = Button1Click
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 39
    Width = 732
    Height = 200
    Anchors = [akLeft, akTop, akRight]
    DataSource = DataSource1
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'ID'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FIRST_NAME'
        Width = 180
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'LAST_NAME'
        Width = 180
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'WORK_PHONE_NUMBER'
        Width = 180
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'EMAIL'
        Width = 180
        Visible = True
      end>
  end
  object Edit1: TEdit
    Left = 8
    Top = 256
    Width = 89
    Height = 21
    TabOrder = 2
    Text = '2'
  end
  object Button2: TButton
    Left = 103
    Top = 254
    Width = 75
    Height = 25
    Caption = 'Get by ID'
    TabOrder = 3
    OnClick = Button2Click
  end
  object DBEdit1: TDBEdit
    Left = 8
    Top = 304
    Width = 150
    Height = 21
    DataField = 'FIRST_NAME'
    DataSource = DataSource2
    TabOrder = 4
  end
  object DBEdit2: TDBEdit
    Left = 8
    Top = 360
    Width = 150
    Height = 21
    DataField = 'MOBILE_PHONE_NUMBER'
    DataSource = DataSource2
    TabOrder = 5
  end
  object DBEdit3: TDBEdit
    Left = 164
    Top = 360
    Width = 150
    Height = 21
    DataField = 'WORK_PHONE_NUMBER'
    DataSource = DataSource2
    TabOrder = 6
  end
  object DBEdit4: TDBEdit
    Left = 164
    Top = 304
    Width = 150
    Height = 21
    DataField = 'LAST_NAME'
    DataSource = DataSource2
    TabOrder = 7
  end
  object DBEdit5: TDBEdit
    Left = 8
    Top = 408
    Width = 150
    Height = 21
    DataField = 'EMAIL'
    DataSource = DataSource2
    TabOrder = 8
  end
  object Memo1: TMemo
    Left = 332
    Top = 304
    Width = 408
    Height = 161
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      'Memo1')
    TabOrder = 9
  end
  object Button3: TButton
    Left = 332
    Top = 250
    Width = 75
    Height = 28
    Caption = 'Update'
    TabOrder = 10
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 413
    Top = 250
    Width = 75
    Height = 28
    Caption = 'Delete'
    TabOrder = 11
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 494
    Top = 250
    Width = 75
    Height = 28
    Caption = 'Post'
    TabOrder = 12
    OnClick = Button5Click
  end
  object RESTClient1: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    AcceptEncoding = 'identity'
    BaseURL = 'http://localhost:8080/'
    Params = <>
    HandleRedirects = True
    Left = 128
    Top = 16
  end
  object RESTRequest1: TRESTRequest
    Client = RESTClient1
    Params = <>
    Resource = 'people'
    SynchronizedEvents = False
    OnHTTPProtocolError = RESTRequest1HTTPProtocolError
    Left = 128
    Top = 88
  end
  object RESTRequest2: TRESTRequest
    Client = RESTClient1
    Params = <
      item
        Kind = pkURLSEGMENT
        name = 'id'
        Options = [poAutoCreated]
        Value = '2'
      end>
    Resource = 'people/{id}'
    Response = RESTResponse2
    SynchronizedEvents = False
    OnHTTPProtocolError = RESTRequest1HTTPProtocolError
    Left = 272
    Top = 248
  end
  object DataSource1: TDataSource
    DataSet = FDMemTable1
    Left = 512
    Top = 88
  end
  object RESTResponseDataSetAdapter2: TRESTResponseDataSetAdapter
    Dataset = FDMemTable2
    FieldDefs = <>
    Response = RESTResponse2
    Left = 464
    Top = 320
  end
  object RESTResponse2: TRESTResponse
    ContentType = 'application/json'
    Left = 352
    Top = 304
  end
  object DataSource2: TDataSource
    AutoEdit = False
    DataSet = FDMemTable2
    Left = 672
    Top = 328
  end
  object BindingsList1: TBindingsList
    Methods = <>
    OutputConverters = <>
    Left = 676
    Top = 5
    object LinkControlToField1: TLinkControlToField
      Category = 'Quick Bindings'
      DataSource = RESTRequest2
      FieldName = 'Params.id'
      Control = Edit1
      Track = True
    end
  end
  object FDMemTable1: TFDMemTable
    AfterScroll = FDMemTable1AfterScroll
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    StoreDefs = True
    Left = 424
    Top = 88
    object FDMemTable1ID: TIntegerField
      FieldName = 'ID'
    end
    object FDMemTable1FIRST_NAME: TStringField
      DisplayWidth = 50
      FieldName = 'FIRST_NAME'
      Size = 255
    end
    object FDMemTable1LAST_NAME: TStringField
      DisplayWidth = 50
      FieldName = 'LAST_NAME'
      Size = 255
    end
    object FDMemTable1WORK_PHONE_NUMBER: TStringField
      DisplayWidth = 50
      FieldName = 'WORK_PHONE_NUMBER'
      Size = 255
    end
    object FDMemTable1MOBILE_PHONE_NUMBER: TStringField
      FieldName = 'MOBILE_PHONE_NUMBER'
      Size = 50
    end
    object FDMemTable1EMAIL: TStringField
      DisplayWidth = 50
      FieldName = 'EMAIL'
      Size = 255
    end
  end
  object FDMemTable2: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    StoreDefs = True
    Left = 584
    Top = 320
    object FDMemTable2ID: TStringField
      FieldName = 'ID'
      Size = 255
    end
    object FDMemTable2FIRST_NAME: TStringField
      FieldName = 'FIRST_NAME'
      Size = 255
    end
    object FDMemTable2LAST_NAME: TStringField
      FieldName = 'LAST_NAME'
      Size = 255
    end
    object FDMemTable2WORK_PHONE_NUMBER: TStringField
      FieldName = 'WORK_PHONE_NUMBER'
      Size = 255
    end
    object FDMemTable2MOBILE_PHONE_NUMBER: TStringField
      FieldName = 'MOBILE_PHONE_NUMBER'
      Size = 255
    end
    object FDMemTable2EMAIL: TStringField
      FieldName = 'EMAIL'
      Size = 255
    end
  end
  object RESTUpd: TRESTRequest
    Client = RESTClient1
    Params = <>
    SynchronizedEvents = False
    OnHTTPProtocolError = RESTRequest1HTTPProtocolError
    Left = 528
    Top = 280
  end
end
