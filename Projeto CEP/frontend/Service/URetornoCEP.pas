unit URetornoCEP;

interface

type
 TRetornoCEP = class
  private
   FLogradouro: String;
   FBairro: String;
   FUf: String;
   FCep: String;
   FCidade: String;
   FMensagem: String;
   procedure SetBairro(const Value: String);
   procedure SetCep(Value: String);
   procedure SetCidade(const Value: String);
   procedure SetLogradouro(const Value: String);
   procedure SetUF(const Value: String);
   procedure SetMensagem(const Value: String);

   procedure MascaraCEP(var aCep : String);

   { private declarations }
  protected
   { protected declarations }
  public
   property Cep: String read FCep write SetCep;
   property UF: String read FUF write SetUF;
   property Bairro: String read FBairro write SetBairro;
   property Cidade: String read FCidade write SetCidade;
   property Logradouro: String read FLogradouro write SetLogradouro;

   property Mensagem : String read FMensagem write SetMensagem;

   constructor create(aCep,aUF, aBairro, aCidade, aLogradouro,aMensagem: String);overload;
   constructor create(aMensagemErro : String);overload;
   { public declarations }

  published
   { published declarations }
  end;

implementation

{ TRetornoCEP }

constructor TRetornoCEP.create(aCep, aUF, aBairro, aCidade,
  aLogradouro,aMensagem: String);
begin
     Cep       := aCep;
     UF        := aUF;
     Bairro    := aBairro;
     Cidade    := aCidade;
     Logradouro:= aLogradouro;
     Mensagem  := aMensagem;
end;

constructor TRetornoCEP.create(aMensagemErro: String);
begin
     Cep       := '';
     UF        := '';
     Bairro    := '';
     Cidade    := '';
     Logradouro:= '';
     Mensagem  := aMensagemErro;
end;

procedure TRetornoCEP.MascaraCEP(var aCep: String);
begin
     if ((length(aCep) = 8) and not(pos('-',aCep)>0)) then
     begin
          Insert('-', aCep, 6);
     end;
end;

procedure TRetornoCEP.SetBairro(const Value: String);
begin
     FBairro := Value;
end;

procedure TRetornoCEP.SetCep(Value: String);
begin
     MascaraCEP(Value);
     FCep := Value;
end;

procedure TRetornoCEP.SetCidade(const Value: String);
begin
     FCidade := Value;
end;

procedure TRetornoCEP.SetLogradouro(const Value: String);
begin
     FLogradouro := Value;
end;

procedure TRetornoCEP.SetMensagem(const Value: String);
begin
     FMensagem := Value;
end;

procedure TRetornoCEP.SetUF(const Value: String);
begin
     FUF := Value;
end;

end.
