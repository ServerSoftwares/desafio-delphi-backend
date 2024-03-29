unit DataModule.Global;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.ConsoleUI.Wait, FireDAC.DApt,
  Data.DB, FireDAC.Comp.Client,DataSet.Serialize.Config, DataSet.Serialize, System.JSON,
  FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, uFormat,
  FireDAC.Phys.SQLiteWrapper.Stat,RESTRequest4D, DataSet.Serialize.Adapter.RESTRequest4D;

type
  TDataModule1 = class(TDataModule)
    Conn: TFDConnection;
    procedure DataModuleCreate(Sender: TObject);
    procedure ConnBeforeConnect(Sender: TObject);
  private
    procedure CarregarConfigDB(Connection: TFDConnection);
  public
    function ListarCeps: TJsonArray;
    function ListarCep (cep : String): TJsonArray;
    function InserirCep (cep : Integer; logradouro, bairro, localidade, uf : String): TJsonObject;
    function AtualizarCep (cep, logradouro, bairro, localidade, uf : String): TJsonObject;
    function DeletarCep (cep : String): TJsonArray;
    function AtualizaBase (cep : String): TJsonArray;
  end;

var
  DataModule1: TDataModule1;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TDataModule1 }

procedure TDataModule1.CarregarConfigDB(Connection: TFDConnection);
begin
  Connection.DriverName := 'SQLite';

  with Connection.Params do
  begin
      Clear;
      Add('DriverID=SQLite');

      Add('Database=C:\Projetos\desafio-delphi-backend\backend-delphi\DB\baseceps.db');

      Add('User_Name=');
      Add('Password=');
      Add('Port=');
      Add('Server=');
      Add('Protocol=');
      Add('LockingMode=Normal');
  end;
end;

procedure TDataModule1.ConnBeforeConnect(Sender: TObject);
begin
  CarregarConfigDB(Conn);
end;

procedure TDataModule1.DataModuleCreate(Sender: TObject);
begin
   TDataSetSerializeConfig.GetInstance.CaseNameDefinition := cndLower;
   TDataSetSerializeConfig.GetInstance.Import.DecimalSeparator := '.';

   Conn.Connected := true;
end;

function TDataModule1.InserirCep(cep: Integer; logradouro, bairro, localidade,
  uf: String): TJsonObject;
var
    qry: TFDQuery;
begin
    try
        qry := TFDQuery.Create(nil);
        qry.Connection := Conn;

        qry.SQL.Add('insert into cep (cep,logradouro,bairro,localidade,uf)values(:cep,:logradouro,:bairro,:localidade,:uf)');

        qry.ParamByName('cep').Value := cep;
        qry.ParamByName('logradouro').Value := logradouro;
        qry.ParamByName('bairro').Value := bairro;
        qry.ParamByName('localidade').Value := localidade;
        qry.ParamByName('uf').Value := uf;
        qry.ExecSQL;
        Result := qry.ToJSONObject;

    finally
        FreeAndNil(qry);
    end;
end;

function TDataModule1.AtualizarCep(cep, logradouro, bairro, localidade,
  uf: String): TJsonObject;
var
    qry: TFDQuery;
begin
    try
        qry := TFDQuery.Create(nil);
        qry.Connection := Conn;

        qry.SQL.Add('update cep set logradouro = :logradouro, bairro = :bairro, localidade = :localidade, uf = :uf where cep = :cep');

        qry.ParamByName('cep').Value := cep;
        qry.ParamByName('logradouro').Value := logradouro;
        qry.ParamByName('bairro').Value := bairro;
        qry.ParamByName('localidade').Value := localidade;
        qry.ParamByName('uf').Value := uf;
        qry.ExecSQL;
        Result := qry.ToJSONObject;

    finally
        FreeAndNil(qry);
    end;
end;

function TDataModule1.DeletarCep (cep : String): TJsonArray;
var
    qry: TFDQuery;
begin
    try
        qry := TFDQuery.Create(nil);
        qry.Connection := Conn;

        qry.SQL.Add('delete from cep where cep = :cep');
        qry.ParamByName('cep').AsString := cep;
        qry.ExecSQL;

        Result := qry.ToJSONArray;

    finally
        FreeAndNil(qry);
    end;
end;

function TDataModule1.ListarCep (cep : String): TJsonArray;
var
    qry: TFDQuery;
begin
    try
        qry := TFDQuery.Create(nil);
        qry.Connection := Conn;

        qry.SQL.Add('select * from cep where cep = :cep');
        qry.ParamByName('cep').AsString := cep;
        qry.Open;

        Result := qry.ToJSONArray;

    finally
        FreeAndNil(qry);
    end;
end;

function TDataModule1.ListarCeps: TJsonArray;
var
    qry: TFDQuery;
begin
    try
        qry := TFDQuery.Create(nil);
        qry.Connection := Conn;

        qry.SQL.Add('select * from cep');
        qry.Open;

        Result := qry.ToJSONArray;

    finally
        FreeAndNil(qry);
    end;
end;

function TDataModule1.AtualizaBase (cep : String): TJsonArray;
var
  Resp : IResponse;
  uMemTable : TFDMemTable;
  qry : TFDQuery;
begin

  try
    Resp := TRequest.New.BaseURL('viacep.com.br/ws/'+SomenteNumero(cep)+ '/json')
         .Adapters(TDataSetSerializeAdapter.New(uMemTable))
         .Accept('application/json')
         .Get;

    uMemTable := TFDMemTable.Create(nil);

    qry := TFDQuery.Create(nil);
    qry.Connection := Conn;
    qry.SQL.Add('insert into cep (cep,logradouro,bairro,localidade,uf)values(:cep,:logradouro,:bairro,:localidade,:uf)');

    if Resp.StatusCode = 200 then
    begin

        if Resp.Content.IndexOf('erro') = 0 then begin
            with uMemTable do
            begin

              qry.ParamByName('cep').Value := FieldByName('cep').AsString;
              qry.ParamByName('logradouro').Value := FieldByName('logradouro').AsString;
              qry.ParamByName('bairro').Value := FieldByName('bairro').AsString;
              qry.ParamByName('localidade').Value := FieldByName('localidade').AsString;
              qry.ParamByName('uf').Value := FieldByName('uf').AsString;
              qry.ExecSQL;

              Result := qry.ToJSONArray;
            end;

        end;
    end
    else
        raise Exception.Create(Resp.Content);
  finally
    FreeAndNil(qry);
    FreeAndNil(uMemTable);
  end;

end;

end.

