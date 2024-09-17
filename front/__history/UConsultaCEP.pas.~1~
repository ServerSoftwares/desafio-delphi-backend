unit UConsultaCEP;

interface

uses
  UCEP;

type
  TRetornoCEP = class
  private
    FCEP: TCEP;
    FSucesso: Boolean;
    procedure SetCEP(const ACEP: TCEP);
    function GetCEP: TCEP;
    procedure SetSucesso(const ASucesso: Boolean);
    function GetSucesso: Boolean;
  public
    constructor Create();
    property CEP: TCEP read GetCEP write SetCEP;
    property Sucesso: Boolean read GetSucesso write SetSucesso;
  end;

  TConsultaCEP = class
  private

  public
    function Consultar(Cep: string): TRetornoCEP;
  end;

implementation



{ TConsultaCEP }

function TConsultaCEP.Consultar(Cep: string): TRetornoCEP;
begin

end;

{ TRetornoCEP }

constructor TRetornoCEP.Create;
begin

end;

function TRetornoCEP.GetCEP: TCEP;
begin
  Result:= FCEP;
end;

function TRetornoCEP.GetSucesso: Boolean;
begin
  Result:= FSucesso;
end;

procedure TRetornoCEP.SetCEP(const ACEP: TCEP);
begin
  FCEP:= ACEP;
end;

procedure TRetornoCEP.SetSucesso(const ASucesso: Boolean);
begin
 FSucesso:= ASucesso;
end;

end.
