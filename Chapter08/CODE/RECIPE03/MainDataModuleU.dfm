object MainDM: TMainDM
  OldCreateOrder = False
  Height = 360
  Width = 504
  object Connection: TFDConnection
    Params.Strings = (
      
        'Database=C:\Delphi Cookbook\BOOK\Chapter06\CODE\RECIPE03\todos.s' +
        'db'
      'DriverID=SQLite')
    Connected = True
    LoginPrompt = False
    Left = 48
    Top = 84
  end
  object qryTODOs: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Active = True
    Connection = Connection
    SQL.Strings = (
      'SELECT * FROM TODOS')
    Left = 48
    Top = 168
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 208
    Top = 92
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'FMX'
    Left = 208
    Top = 158
  end
end
