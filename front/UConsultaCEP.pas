unit UConsultaCEP;

interface

uses
  REST.Types, REST.Client, REST.Authenticator.Basic, Data.Bind.Components, Data.Bind.ObjectScope,
  System.SysUtils, System.JSON,
  UCEP;

type
  TRetornoCEP = class
  private
    FCEP: TCEP;
    FSucesso: Boolean;
    FMensagem: string;
    procedure SetCEP(const ACEP: TCEP);
    function GetCEP: TCEP;
    procedure SetSucesso(const ASucesso: Boolean);
    function GetSucesso: Boolean;
    procedure SetMensagem(const AMensagem: string);
    function GetMensagem: string;
  public
    constructor Create();
    property CEP: TCEP read GetCEP write SetCEP;
    property Sucesso: Boolean read GetSucesso write SetSucesso;
    property Mensagem: string read GetMensagem write SetMensagem;
  end;

  TConsultaCEP = class
  private

  public
    function Consultar(Cep: string): TRetornoCEP;
  end;

implementation



{ TConsultaCEP }

function TConsultaCEP.Consultar(Cep: string): TRetornoCEP;
var
  Retorno: TRetornoCEP;
  RESTClient: TRESTClient;
  RESTRequest: TRESTRequest;
  RESTResponse: TRESTResponse;
  Response: TJSONObject;
begin
  Retorno:= TRetornoCEP.Create;
  try
    try
      RESTClient:= TRESTClient.Create('https://localhost:32768/api/');
      RESTRequest:= TRESTRequest.Create(nil);
      RESTResponse:= TRESTResponse.Create(nil);

      RESTRequest.Client:= RESTClient;
      RESTRequest.Response:= RESTResponse;

      RESTClient.AcceptCharset := 'application/json';
      RESTClient.ContentType := 'application/json;charset=utf-8';

      RESTRequest.ResetToDefaults;
      RESTRequest.AcceptCharset := 'application/json';
      RESTRequest.Method := rmGET;
      RESTRequest.ConnectTimeout:= 5 * 1000;

      RESTRequest.Params.Clear;
      RESTRequest.Params.Add;
      RESTRequest.Params[0].ContentType := ctAPPLICATION_JSON;
      RESTRequest.Params[0].Kind := pkHTTPHEADER;
      RESTRequest.Params[0].name := 'Content-Type';
      RESTRequest.Params[0].Options := [poDoNotEncode];
      RESTRequest.Params[0].Value := 'application/json';

      RESTRequest.ResourceSuffix := 'cep/consultar?cep=' + Cep;

      RESTResponse.ResetToDefaults;

      RESTRequest.Execute;

      Response:= (RESTResponse.JSONValue as System.JSON.TJSONObject);

      if RESTRequest.Response.Status.SuccessOK_200 then
      begin
        Retorno.Sucesso:= True;
        Retorno.Mensagem:= Response.Values['message'].Value;

        Response:= (Response.Values['data'] as System.JSON.TJSONObject);

        Retorno.CEP:= TCEP.Create;
        Retorno.CEP.CEP:= Response.Values['cep'].Value;
        Retorno.CEP.UF:= Response.Values['uf'].Value;
        Retorno.CEP.Cidade:= Response.Values['cidade'].Value;
        Retorno.CEP.Bairro:= Response.Values['bairro'].Value;
        Retorno.CEP.Logradouro:= Response.Values['logradouro'].Value;
      end
      else
      begin
        Retorno.Sucesso:= False;
        Retorno.Mensagem:= Response.Values['message'].Value;
      end;

      Result:= Retorno;
    except
      on E: Exception do
      begin
        Retorno.Sucesso:= False;
        Retorno.Mensagem:= 'FALHA: '+E.Message;
        Result:= Retorno;
      end;
    end;
  finally
    RESTResponse.Free;
    RESTRequest.Free;
    RESTClient.Free;
  end;
end;

{ TRetornoCEP }

constructor TRetornoCEP.Create;
begin

end;

function TRetornoCEP.GetCEP: TCEP;
begin
  Result:= FCEP;
end;

function TRetornoCEP.GetMensagem: string;
begin
  Result:= FMensagem;
end;

function TRetornoCEP.GetSucesso: Boolean;
begin
  Result:= FSucesso;
end;

procedure TRetornoCEP.SetCEP(const ACEP: TCEP);
begin
  FCEP:= ACEP;
end;

procedure TRetornoCEP.SetMensagem(const AMensagem: string);
begin
  FMensagem:= AMensagem;
end;

procedure TRetornoCEP.SetSucesso(const ASucesso: Boolean);
begin
 FSucesso:= ASucesso;
end;

end.
