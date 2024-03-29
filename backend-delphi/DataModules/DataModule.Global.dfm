object DataModule1: TDataModule1
  OnCreate = DataModuleCreate
  Height = 3000
  Width = 4000
  PixelsPerInch = 240
  object Conn: TFDConnection
    Params.Strings = (
      'DriverID=SQLite')
    LoginPrompt = False
    BeforeConnect = ConnBeforeConnect
    Left = 424
    Top = 344
  end
end
