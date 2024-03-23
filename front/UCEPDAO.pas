unit UCEPDAO;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Dialogs,

  UCEP;

type
  TCEPDAO = class
  private
    FConnection: TFDConnection;
    FTransaction: TFDTransaction;
  public
    constructor Create(AConnection: TFDConnection; ATransaction: TFDTransaction);
    procedure InserirDados(const CEP: TCEP);
    procedure ManterDados(const CEP: TCEP);
    function BuscarPorCEP(const ACEP: string): TCEP;
    function Mapear(Query: TFDQuery): TCEP;


  end;

implementation

uses UFunctions;
{ TCEPDAO }

function TCEPDAO.BuscarPorCEP(const ACEP: string): TCEP;
var
  Query: TFDQuery;
  SQL: string;
  CEP: TCEP;
begin
  Query:= TFDQuery.Create(nil);
  Query.Connection:= FConnection;
  Query.Transaction:= FTransaction;

  SQL:= 'SELECT CEP, UF, CIDADE, BAIRRO, LOGRADOURO FROM TBCEP WHERE CEP = ' + QuotedSTr(ACEP);

  TFunctions.ExecutaSQL(SQL, Query);

  CEP:= Mapear(Query);

  Result:= CEP;
end;

constructor TCEPDAO.Create(AConnection: TFDConnection; ATransaction: TFDTransaction);
begin
  FConnection := AConnection;
  FTransaction := ATransaction;
end;

procedure TCEPDAO.InserirDados(const CEP: TCEP);
var
  Query: TFDQuery;
  SQL: string;
begin
  try
    try
      Query:= TFDQuery.Create(nil);
      Query.Connection:= FConnection;
      Query.Transaction:= FTransaction;

      SQL:= 'INSERT INTO TBCEP (CEP, UF, Cidade, Bairro, Logradouro) VALUES ('
        + QuotedSTr(CEP.CEP) + ','
        + QuotedStr(CEP.UF) + ','
        + QuotedStr(CEP.Cidade) + ','
        + QuotedStr(CEP.Bairro) + ','
        + QuotedStr(CEP.Logradouro) + ')';

      TFunctions.ExecutaSQL(SQL, Query);
    except
      ShowMessage('Erro ao inserir os dados');
      raise
    end
  finally
    Query.Free;
  end;
end;

procedure TCEPDAO.ManterDados(const CEP: TCEP);
var
  Query: TFDQuery;
  SQL: string;
begin
  try
    try
      Query:= TFDQuery.Create(nil);
      Query.Connection:= FConnection;
      Query.Transaction:= FTransaction;

      SQL:= 'UPDATE OR INSERT TBCEP (CEP, UF, CIDADE, BAIRRO, LOGRADOURO) VALUES ('
        + QuotedSTr(CEP.CEP) + ','
        + QuotedSTr(CEP.UF) + ','
        + QuotedSTr(CEP.Cidade) + ','
        + QuotedSTr(CEP.Bairro) + ','
        + QuotedSTr(CEP.Logradouro) + ','
        + ') MATCHING (CEP)';

      TFunctions.ExecutaSQL(SQL, Query);
    except
      ShowMessage('Erro ao atualizar os dados');
      raise
    end
  finally
    Query.Free;
  end;
end;

function TCEPDAO.Mapear(Query: TFDQuery): TCEP;
var
  CEP: TCEP;
begin
  CEP:= TCEP.Create();

   if not Query.IsEmpty then
  begin
    CEP.CEP:= Query.FieldByName('CEP').AsString;
    CEP.UF:= Query.FieldByName('UF').AsString;
    CEP.Cidade:= Query.FieldByName('CIDADE').AsString;
    CEP.Bairro:= Query.FieldByName('BAIRRO').AsString;
    CEP.Logradouro:= Query.FieldByName('LOGRADOURO').AsString;
  end;

  Result:= CEP;
end;

end.
