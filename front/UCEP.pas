unit UCEP;

interface

type
  TCEP = class
  private
    FCEP: string;
    FUF: string;
    FBairro: string;
    FCidade: string;
    FLogradouro: string;
    function GetCEP: string;
    procedure SetCEP(const ACEP: string);

    function GetUF: string;
    procedure SetUF(const AUF: string);

    function GetBairro: string;
    procedure SetBairro(const ABairro: string);

    function GetCidade: string;
    procedure SetCidade(const ACidade: string);

    function GetLogradouro: string;
    procedure SetLogradouro(const ALogradouro: string);
  public
    constructor Create(); overload;
    constructor Create(ACEP, AUF, ABairro, ACidade, ALogradouro: string); overload;

    property CEP: string read GetCEP write SetCEP;
    property UF: string read GetUF write SetUF;
    property Bairro: string read GetBairro write SetBairro;
    property Cidade: string read GetCidade write SetCidade;
    property Logradouro: string read GetLogradouro write SetLogradouro;


  end;

implementation

{ TCEP }

constructor TCEP.Create(ACEP, AUF, ABairro, ACidade, ALogradouro: string);
begin
  FCEP:= ACEP;
  FUF:= AUF;
  FBairro:= ABairro;
  FCidade:= ACidade;
  FLogradouro:= ALogradouro;
end;

constructor TCEP.Create;
begin

end;

function TCEP.GetBairro: string;
begin
  Result:= FBairro;
end;

function TCEP.GetCEP: string;
begin
  Result:= FCEP;
end;

function TCEP.GetCidade: string;
begin
  Result:= FCidade;
end;

function TCEP.GetLogradouro: string;
begin
  Result:= FLogradouro;
end;

function TCEP.GetUF: string;
begin
  Result:= FUF;
end;

procedure TCEP.SetBairro(const ABairro: string);
begin
  FBairro:= ABairro;
end;

procedure TCEP.SetCEP(const ACEP: string);
begin
  FCEP:= ACEP;
end;

procedure TCEP.SetCidade(const ACidade: string);
begin
  FCidade:= ACidade;
end;

procedure TCEP.SetLogradouro(const ALogradouro: string);
begin
  FLogradouro:= ALogradouro;
end;

procedure TCEP.SetUF(const AUF: string);
begin
  FUF:= AUF;
end;

end.
