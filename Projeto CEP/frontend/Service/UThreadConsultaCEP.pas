unit UThreadConsultaCEP;

interface
 uses
  uRetornoCep, System.Classes, System.SyncObjs;

type

 TOrigemDados = record
     BaseURL  : String;
     Resource : String;
 end;

 TCallBack = reference to procedure(Param1 : TRetornoCEP);

 TThreadConsultaCEP = class(TThread)
 private
   FCep             : String;
   FProcessaRetorno : TCallBack;
   FApiInterna      : TOrigemDados;
   FApiExterna      : TOrigemDados;
   FConsultaFaixa   : Boolean;
   FCriticalSection : TCriticalSection;

   procedure TratandoExcecao (Sender : TObject);

   function GetCEP(aOrigemDados : TOrigemDados) : TRetornoCEP;
   procedure PostCEP(aRetornoCEP : TRetornoCEP);

  { private declarations }
 protected
   procedure Execute; override;


  { protected declarations }
 public
   constructor Create(aCep,aBaseLocalURL: String;
                      aProcessaRetorno : TCallBack;
                      aConsultaFaixa : Boolean = False;
                      aCriticalSection : TCriticalSection = nil); reintroduce;

  { public declarations }

 published
  { published declarations }
 end;

implementation
    uses
    RESTRequest4D,
    System.JSON,
    System.SysUtils,
    REST.Json,
    IpPeerClient,
    REST.Client,
    REST.Exception;

{ TThreadConsultaCEP }


constructor TThreadConsultaCEP.Create(aCep, aBaseLocalURL: String;
  aProcessaRetorno: TCallBack; aConsultaFaixa: Boolean;
  aCriticalSection: TCriticalSection);
begin
     inherited Create(True);
     FreeOnTerminate  := True;
     FCep             := aCep;
     FProcessaRetorno := aProcessaRetorno;
     OnTerminate      := TratandoExcecao;

     //Definindo origem dos dados
     FApiInterna.BaseURL  := aBaseLocalURL;
     FApiInterna.Resource :=  '/cep/'+FCep;

     FApiExterna.BaseURL  := 'https://viacep.com.br/ws';
     FApiExterna.Resource := '/'+FCep+'/json';

     FConsultaFaixa := aConsultaFaixa;

     FCriticalSection := aCriticalSection;
end;

procedure TThreadConsultaCEP.Execute;
var
   lRetornoCEP      : TRetornoCEP;
begin
     inherited;
     try
        lRetornoCEP := nil;

        //Consulta por faixa não busca local
        if not(FConsultaFaixa) then
        begin
             lRetornoCEP := GetCEP(FApiInterna);
        end;

        //Não encontrou na api interna  ou é consulta por faixa
        //então verifico na api externa
        if (FConsultaFaixa or lRetornoCEP.Cep.IsEmpty) then
        begin
             FreeAndNil(lRetornoCEP);

             if FConsultaFaixa then
             begin
                  FCriticalSection.Enter;
             end;

             //Procura na api externa
             lRetornoCEP := GetCEP(FApiExterna);

             if FConsultaFaixa then
             begin
                  Sleep(3000);
                  FCriticalSection.Leave;
             end;

             if not(lRetornoCEP.Cep.IsEmpty) then
             begin
                  PostCEP(lRetornoCEP);
             end;
        end;

     finally
        if Assigned(FProcessaRetorno) and Assigned(lRetornoCEP) then
        begin
             Synchronize(procedure
                         begin
                              FProcessaRetorno(lRetornoCEP);
                         end);

        end;

        if Assigned (lRetornoCEP) then
        begin
             FreeAndNil(lRetornoCEP);
        end;
     end;
end;

function TThreadConsultaCEP.GetCEP(aOrigemDados : TOrigemDados): TRetornoCEP;
var
   lResponse    : IResponse;
   lJsonRetorno : TJSONValue;
   lCidade      : String;
   lErro        : String;
begin
     try
        lResponse := TRequest
                     .New
                     .BaseURL(aOrigemDados.BaseURL)
                     .Resource(aOrigemDados.Resource)
                     .Accept('application/json')
                     .AcceptCharset('UTF-8')
                     .Timeout(5000) //5 segundos
                     .Get;
     except on E: ERESTException do
        begin
             Result := TRetornoCEP.Create('O serviço de CEP está indisponível'+
                                            ' no momento. Tente'+
                                            ' novamente mais tarde.');
            Exit;
        end;
     end;

     lJsonRetorno := lResponse.JsonValue;
      // Na api externa retorna status 200 com erro
      // Então verifico se tem a propriedade erro
     if (lResponse.StatusCode = 200) and
         not lJsonRetorno.TryGetValue('erro',lErro) then
     begin
          //em uma API é cidade na outra é localidade
          if not lJsonRetorno.TryGetValue('cidade',lCidade) then
          begin
               lCidade := lJsonRetorno.GetValue<String>('localidade')
          end;

          Result := TRetornoCEP.Create(lJsonRetorno.GetValue<String>('cep'),
                                       lJsonRetorno.GetValue<String>('uf'),
                                       lJsonRetorno.GetValue<String>('bairro'),
                                       lCidade,
                                       lJsonRetorno.GetValue<String>('logradouro'),
                                       'CEP '+FCep + ' encontrado com sucesso.');

     end
     else
     begin
          Result := TRetornoCEP.Create('CEP '+FCep + ' não encontrado.');
     end;
end;


procedure TThreadConsultaCEP.PostCEP(aRetornoCEP: TRetornoCEP);
var
  lResponse      : IResponse;
  lJsonObjectCEP : TJsonObject;
begin
     try
        //TRequest fica responsável por liberar da memória
        lJsonObjectCEP := TJsonObject.Create;
        lJsonObjectCEP.AddPair('cep',FCep);
        lJsonObjectCEP.AddPair('uf',aRetornoCEP.UF);
        lJsonObjectCEP.AddPair('bairro',aRetornoCEP.Bairro);
        lJsonObjectCEP.AddPair('cidade',aRetornoCEP.Cidade);
        lJsonObjectCEP.AddPair('logradouro',aRetornoCEP.Logradouro);

        lResponse := TRequest
                     .New
                     .BaseURL(FApiInterna.BaseURL)
                     .Resource('/cep')
                     .Accept('application/json')
                     .AcceptCharset('UTF-8')
                     .AddBody(lJsonObjectCEP)
                     .Timeout(5000) //5 segundos
                     .Post;

        if (lResponse.StatusCode = 201) then
        begin
             aRetornoCEP.Mensagem := aRetornoCEP.Mensagem+ sLineBreak+
                                     'CEP '+FCep+
                                     ' inserido no banco de dados com sucesso!';
        end
        else
        begin
             aRetornoCEP.Mensagem := aRetornoCEP.Mensagem+ sLineBreak+
                                     'Falha ao inserir o CEP '+FCep+
                                     ' no banco de dados.';
        end;
     except on E: Exception do
        begin
             aRetornoCEP.Mensagem := aRetornoCEP.Mensagem+ sLineBreak+
                                     'Falha ao inserir o CEP '+FCep+
                                     ' no banco de dados.';
        end;
     end;

end;

procedure TThreadConsultaCEP.TratandoExcecao(Sender: TObject);
var lRetornoCEP : TRetornoCEP;
begin
     if Assigned(Tthread(sender).FatalException) then
     begin
          lRetornoCEP := TRetornoCEP.Create('O serviço de CEP está indisponível'+
                                            ' no momento. Tente'+
                                            ' novamente mais tarde.');

          if Assigned(FProcessaRetorno) and Assigned(lRetornoCEP) then
          begin
               FProcessaRetorno(lRetornoCEP);

          end;
     end;
end;

end.
