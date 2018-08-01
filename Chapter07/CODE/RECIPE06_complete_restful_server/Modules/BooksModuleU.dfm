object BookModule: TBookModule
  OldCreateOrder = True
  Height = 199
  Width = 436
  object Conn: TFDConnection
    Params.Strings = (
      'Server=192.168.1.112'
      'Database=delphicookbook'
      'User_Name=cookuser'
      'Password=cookpass'
      'DriverID=MySQL')
    ConnectedStoredUsage = [auDesignTime]
    Connected = True
    LoginPrompt = False
    Left = 120
    Top = 40
  end
  object updBooks: TFDUpdateSQL
    Connection = Conn
    InsertSQL.Strings = (
      'INSERT INTO delphicookbook.books'
      '(author, title, `year`, number_of_pages, plot)'
      
        'VALUES (:NEW_author, :NEW_title, :NEW_year, :NEW_number_of_pages' +
        ', :NEW_plot)')
    ModifySQL.Strings = (
      'UPDATE delphicookbook.books'
      
        'SET author = :NEW_author, title = :NEW_title, `year` = :NEW_year' +
        ', '
      '  number_of_pages = :NEW_number_of_pages, plot = :NEW_plot'
      'WHERE ID = :OLD_ID')
    DeleteSQL.Strings = (
      'DELETE FROM delphicookbook.books'
      'WHERE ID = :OLD_ID')
    FetchRowSQL.Strings = (
      
        'SELECT LAST_INSERT_ID() AS ID, author, title, `year` AS `year`, ' +
        'number_of_pages, '
      '  plot'
      'FROM delphicookbook.books'
      'WHERE ID = :ID')
    Left = 240
    Top = 104
  end
  object qryBooks: TFDQuery
    Connection = Conn
    UpdateObject = updBooks
    SQL.Strings = (
      'select * from books')
    Left = 120
    Top = 128
  end
end
