unit UPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask,
  UCEP;

type
  TFPrincipal = class(TForm)
    BtnPesquisar: TButton;
    MEdtCEP: TMaskEdit;
    Label1: TLabel;
    EdtCEP: TEdit;
    Label2: TLabel;
    EdtUF: TEdit;
    Label3: TLabel;
    EdtCidade: TEdit;
    Label4: TLabel;
    EdtBairro: TEdit;
    Label5: TLabel;
    EdtLogradouro: TEdit;
    Label6: TLabel;
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

uses UConsultaCEP, UCEPDAO, UDM;

procedure TFPrincipal.BtnPesquisarClick(Sender: TObject);
var
  ConsultaCEP: TConsultaCEP;
  Retorno: TRetornoCEP;
  CEPDAO: TCEPDAO;
  CEP: TCEP;
begin
  try
    CEPDAO:= TCEPDAO.Create(DM.FDConnection, DM.FDTransaction);

    CEP:= CEPDAO.BuscarPorCEP(MEdtCEP.Text);

    if CEP.CEP <> '' then
    begin
      PreencherCampos(CEP);
      Exit;
    end;


    ConsultaCEP:= TConsultaCEP.Create();

    Retorno:= ConsultaCEP.Consultar(MEdtCEP.Text);

    if (Assigned(Retorno)) and Retorno.Sucesso then
    begin
      PreencherCampos(Retorno.CEP);
    end
    else
    begin
      //Não encontrou
      //CORRIGIR
      ShowMessage('CEP não encontrado');
    end;
  finally
    CEPDAO.Free;
    CEP.Free;
    ConsultaCEP.Free;
    Retorno.Free;
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
