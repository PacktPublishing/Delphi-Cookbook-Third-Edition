object ServerMethods1: TServerMethods1
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 155
  Width = 371
  object FDConnection1: TFDConnection
    Params.Strings = (
      
        'Database=C:\Delphi Cookbook 2nd Edition\CHAPTERS\Chapter06\CODE\' +
        'RECIPE09\DATA\SAMPLES.IB'
      'User_Name=sysdba'
      'Password=masterkey'
      'DriverID=IB')
    Left = 96
    Top = 48
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    Left = 200
    Top = 48
  end
end
