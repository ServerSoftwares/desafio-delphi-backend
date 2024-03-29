program AppConsultaCep;

uses
  Vcl.Forms,
  frmConsultaCep in 'frmConsultaCep.pas' {formConsultaCep},
  classe.RetornoCEP in 'classes\classe.RetornoCEP.pas',
  classe.ConsultaCEP in 'classes\classe.ConsultaCEP.pas',
  uFormat in 'units\uFormat.pas',
  uLoading in 'units\uLoading.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TformConsultaCep, formConsultaCep);
  Application.Run;
end.
