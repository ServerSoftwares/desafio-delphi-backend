program Proj_desafio_backend;

uses
  Vcl.Forms,
  UPrincipal in 'UPrincipal.pas' {FPrincipal},
  UConsultaCEP in 'UConsultaCEP.pas',
  UCEP in 'UCEP.pas',
  UCEPDAO in 'UCEPDAO.pas',
  UDM in 'UDM.pas' {DM: TDataModule},
  UFunctions in 'UFunctions.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFPrincipal, FPrincipal);
  Application.CreateForm(TDM, DM);
  Application.Run;
end.
