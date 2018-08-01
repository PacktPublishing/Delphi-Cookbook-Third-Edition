object dmMain: TdmMain
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 214
  Width = 347
  object RESTClient: TRESTClient
    Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    BaseURL = 'http://localhost:8080/'
    Params = <>
    HandleRedirects = True
    RaiseExceptionOn500 = False
    Left = 56
    Top = 48
  end
  object RESTRequest: TRESTRequest
    Client = RESTClient
    Params = <>
    Resource = 'people'
    SynchronizedEvents = False
    Left = 56
    Top = 112
  end
  object dsPeople: TFDMemTable
    OnCalcFields = dsPeopleCalcFields
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    StoreDefs = True
    Left = 160
    Top = 48
    object dsPeopleID: TIntegerField
      FieldName = 'ID'
    end
    object dsPeopleFIRST_NAME: TStringField
      DisplayWidth = 50
      FieldName = 'FIRST_NAME'
      Size = 255
    end
    object dsPeopleLAST_NAME: TStringField
      DisplayWidth = 50
      FieldName = 'LAST_NAME'
      Size = 255
    end
    object dsPeopleWORK_PHONE_NUMBER: TStringField
      DisplayWidth = 50
      FieldName = 'WORK_PHONE_NUMBER'
      Size = 255
    end
    object dsPeopleMOBILE_PHONE_NUMBER: TStringField
      FieldName = 'MOBILE_PHONE_NUMBER'
      Size = 50
    end
    object dsPeopleEMAIL: TStringField
      DisplayWidth = 50
      FieldName = 'EMAIL'
      Size = 255
    end
    object dsPeopleFULL_NAME: TStringField
      FieldKind = fkCalculated
      FieldName = 'FULL_NAME'
      Calculated = True
    end
  end
end
