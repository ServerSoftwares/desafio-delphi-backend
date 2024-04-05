program ProjectCEP;

uses
  Vcl.Forms,
  UFormPrincipal in 'frontend\UFormPrincipal.pas' {FormPrincipalCep},
  URetornoCEP in 'frontend\Service\URetornoCEP.pas',
  UThreadConsultaCEP in 'frontend\Service\UThreadConsultaCEP.pas',
  UConsultaCEP in 'frontend\Service\UConsultaCEP.pas';

{$R *.res}

begin
     ReportMemoryLeaksOnShutdown := True;
     Application.Initialize;
     Application.MainFormOnTaskbar := True;
     Application.CreateForm(TFormPrincipalCep, FormPrincipalCep);
     Application.Run;
end.
