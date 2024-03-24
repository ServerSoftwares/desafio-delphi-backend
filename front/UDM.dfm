object DM: TDM
  Height = 321
  Width = 249
  object FDConnection: TFDConnection
    Params.Strings = (
      
        'Database=C:\Projetos\Estudo\desafio-delphi-backend\front\DBDESAF' +
        'IO_LOCAL.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'Server=127.0.0.1'
      'Port=3050'
      'CharacterSet=WIN1252'
      'DriverID=FB')
    ResourceOptions.AssignedValues = [rvAutoReconnect]
    ResourceOptions.AutoReconnect = True
    LoginPrompt = False
    Transaction = FDTransaction
    Left = 56
    Top = 40
  end
  object FDTransaction: TFDTransaction
    Connection = FDConnection
    Left = 56
    Top = 128
  end
  object SQLCEP: TFDQuery
    Connection = FDConnection
    Transaction = FDTransaction
    Left = 56
    Top = 209
  end
end
