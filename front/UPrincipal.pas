unit UPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask,
  UCEP, Vcl.ExtCtrls;

type
  TFPrincipal = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    BtnPesquisar: TButton;
    MEdtCEP: TMaskEdit;
    EdtBairro: TEdit;
    EdtCEP: TEdit;
    EdtCidade: TEdit;
    EdtLogradouro: TEdit;
    EdtUF: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    GroupBox1: TGroupBox;
    procedure BtnPesquisarClick(Sender: TObject);
  private
    { Private declarations }
    procedure PreencherCampos(CEP: TCEP);
  public
    { Public declarations }
  end;

var
  FPrincipal: TFPrincipal;

implementation

{$R *.dfm}

uses UConsultaCEP, UCEPDAO, UDM, UFunctions;

procedure TFPrincipal.BtnPesquisarClick(Sender: TObject);
var
  ConsultaCEP: TConsultaCEP;
  Retorno: TRetornoCEP;
  CEPDAO: TCEPDAO;
  CEP: TCEP;
begin
  if Length(Trim(MEdtCEP.Text)) <> 9 then
  begin
    ShowMessage('CEP Inv�lido. Preencha o campo corretamente no formato 99999-999');
    Exit;
  end;

  try
    CEPDAO:= TCEPDAO.Create(DM.FDConnection, DM.FDTransaction);

    CEP:= CEPDAO.BuscarPorCEP(MEdtCEP.Text);

    if CEP.CEP <> '' then
    begin
      PreencherCampos(CEP);
    end
    else
    begin
      try
        ConsultaCEP:= TConsultaCEP.Create();

        Retorno:= ConsultaCEP.Consultar(MEdtCEP.Text);

        if (Assigned(Retorno)) then
        begin
          if Retorno.Sucesso then
          begin
            if Retorno.CEP.CEP <> '' then
            begin
              PreencherCampos(Retorno.CEP);
              CEPDAO.ManterDados(Retorno.CEP);
            end
            else
              ShowMessage('CEP n�o encontrado');
          end
          else
            ShowMessage('Falha ao consultar o CEP: ' + Retorno.Mensagem)
        end
        else
        begin
          ShowMessage('Erro ao consultar o CEP');
        end;
      finally
        ConsultaCEP.Free;
        Retorno.Free;
      end;
    end;
  finally
    CEPDAO.Free;
    CEP.Free;
  end;
end;

procedure TFPrincipal.PreencherCampos(CEP: TCEP);
begin
  EdtCEP.Text:= CEP.CEP;
  EdtUF.Text:= CEP.UF;
  EdtCidade.Text:= CEP.Cidade;
  EdtBairro.Text:= CEP.Bairro;
  EdtLogradouro.Text:= CEP.Logradouro;
end;

end.
