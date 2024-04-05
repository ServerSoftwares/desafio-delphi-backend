unit UFormPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics,  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask,URetornoCEP,UConsultaCEP,
  System.Notification, Vcl.ComCtrls;

type
  TFormPrincipalCep = class(TForm)
    PanelPrincipal: TPanel;
    EditUF: TEdit;
    EditBairro: TEdit;
    EditCidade: TEdit;
    EditLogradouro: TEdit;
    LabelCEP: TLabel;
    LabelUF: TLabel;
    LabelBairro: TLabel;
    LabelCidade: TLabel;
    LabelLogradouro: TLabel;
    ButtonConsultar: TButton;
    GroupBoxConsulta: TGroupBox;
    MaskEditCEPConsulta: TMaskEdit;
    MaskEditCEP: TMaskEdit;
    GroupBoxPrincipal: TGroupBox;
    GroupBoxCEPFaixa: TGroupBox;
    ButtonConsultarFaixa: TButton;
    MaskEditCEPInicio: TMaskEdit;
    MaskEditCEPFim: TMaskEdit;
    LabelInicioFaixa: TLabel;
    LabelFimFaixa: TLabel;
    EditSegundosExecutar: TEdit;
    LabelExecutarIntervalo: TLabel;
    LabelExecutarSegundos: TLabel;
    ProgressBarConsultaFaixa: TProgressBar;
    TimerExecucaoFaixa: TTimer;
    procedure ButtonConsultarClick(Sender: TObject);
    procedure ButtonConsultarFaixaClick(Sender: TObject);
    procedure TimerExecucaoFaixaTimer(Sender: TObject);
    procedure EditSegundosExecutarExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
      FBackEndHost : String;
      procedure Consulta(aCEP :String);
      procedure AtualizaTela(aRetornoCEP :TRetornoCEP);
      procedure ExibeMensagem(aRetornoCEP :TRetornoCEP);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPrincipalCep: TFormPrincipalCep;

implementation
  uses
   System.IniFiles,
   System.IOUtils;

{$R *.dfm}

procedure TFormPrincipalCep.AtualizaTela(aRetornoCEP: TRetornoCEP);
begin
     MaskEditCEP.Text       := aRetornoCEP.Cep;
     EditUF.Text            := aRetornoCEP.UF;
     EditBairro.Text        := aRetornoCEP.Bairro;
     EditCidade.Text        := aRetornoCEP.Cidade;
     EditLogradouro.Text    := aRetornoCEP.Logradouro;
     ButtonConsultar.Caption:= 'Consultar';

     ExibeMensagem(aRetornoCEP);
end;

procedure TFormPrincipalCep.ButtonConsultarClick(Sender: TObject);
begin
     Consulta(MaskEditCEPConsulta.Text);
end;

procedure TFormPrincipalCep.ButtonConsultarFaixaClick(Sender: TObject);
begin
     TConsultaCEP.ConsultarCEPFaixa(MaskEditCEPInicio.Text,
                                    MaskEditCEPFim.Text,
                                    FBackEndHost,
                                    ExibeMensagem,
                                    ProgressBarConsultaFaixa)
end;

procedure TFormPrincipalCep.Consulta(aCEP: String);
begin
     if ButtonConsultar.Caption <> 'Consultando. Aguarde...' then
     begin
          ButtonConsultar.Caption := 'Consultando. Aguarde...';

          TConsultaCEP.ConsultarCEP(aCEP,
                                    FBackEndHost,
                                    AtualizaTela);
     end;
end;

procedure TFormPrincipalCep.EditSegundosExecutarExit(Sender: TObject);
var lSegundos  : String;
    lCEPInicio : String;
    lCEPFim    : String;
begin
     lSegundos  := EditSegundosExecutar.Text;
     lCEPInicio := StringReplace(MaskEditCEPInicio.Text,'-','',[]);
     lCEPFim    := StringReplace(MaskEditCEPFim.Text,'-','',[]);

     //So ativa o temporizador se todos os campos tem valor
     if (not(lSegundos.IsEmpty)
         and (StrToInt(lSegundos)>0)
         and not(lCEPInicio.Trim.IsEmpty)
         and not(lCEPFim.Trim.IsEmpty)) then
     begin
          TimerExecucaoFaixa.Interval:= 1000 * StrToInt(lSegundos);
          TimerExecucaoFaixa.Enabled := True;
     end
     else
     begin
          TimerExecucaoFaixa.Enabled := False;
     end;
end;

procedure TFormPrincipalCep.ExibeMensagem(aRetornoCEP: TRetornoCEP);
begin
     ShowMessage(aRetornoCEP.Mensagem);
end;

procedure TFormPrincipalCep.FormCreate(Sender: TObject);
var
   lIniFile : TIniFile;
   lDirIni  : String;
begin
     try
        lDirIni := TPath.Combine(ExtractFilePath(ParamStr(0)),'config.ini');
        lIniFile := TIniFile.Create(lDirIni);
        try
           FBackEndHost := lIniFile.ReadString('Config',
                                               'BackEndHost',
                                               'http://localhost:3000');
        finally
            FreeAndNil(lIniFile);
        end;
     except on E: Exception do
        begin
             FBackEndHost := 'http://localhost:3000';
        end;
     end;
end;

procedure TFormPrincipalCep.TimerExecucaoFaixaTimer(Sender: TObject);
begin
     if not(TConsultaCEP.ExecutandoCepFaixa) then
     begin
          ButtonConsultarFaixaClick(Sender);
     end;
end;

end.
