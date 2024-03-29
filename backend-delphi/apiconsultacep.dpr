program apiconsultacep;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  Horse,
  Horse.Jhonson,
  Horse.CORS,
  Controllers.Cep in 'Controllers\Controllers.Cep.pas',
  DataModule.Global in 'DataModules\DataModule.Global.pas' {DataModule1: TDataModule},
  uFormat in 'units\uFormat.pas';

begin

  THorse.Use(Jhonson());
  THorse.Use(CORS);

  Controllers.Cep.RegistrarRotas;

  THorse.Listen(3002);

end.
