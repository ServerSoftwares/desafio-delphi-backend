unit UConsultaCEP;

interface
 uses UThreadConsultaCEP, Vcl.ComCtrls;

type

   TCEPValido = record
     OK : Boolean;
     Mensagem : String;
   end;

   TConsultaCep = class
   private
    { private declarations }
   class var FExecutandoCepFaixa : Boolean;

   class function CepValido(aCep : String): TCEPValido;
   class procedure RetiraMascara(var aCep: String);

   protected
    { protected declarations }
   public
    { public declarations }
   class procedure ConsultarCEP(aCep,aBaseLocalURL: String;
                               aProcessaRetorno : TCallBack);

   class procedure ConsultarCEPFaixa(aCepInicio,aCepFim,aBaseLocalURL: String;
                                     aProcessaRetorno : TCallBack;
                                     aProgressBarConsultaFaixa: TProgressBar = nil);

   class property ExecutandoCepFaixa: Boolean read FExecutandoCepFaixa;


   published
    { published declarations }
   end;

implementation

uses
  URetornoCEP, System.SysUtils,System.SyncObjs;

{ TConsultaCep }

class procedure TConsultaCep.ConsultarCEP(aCep, aBaseLocalURL: String;
  aProcessaRetorno: TCallBack);
  var lThreadConsultaCep : TThreadConsultaCep;
      lCEPValido         : TCEPValido;
      lRetornoCEP        : TRetornoCEP;
begin
     try
        lRetornoCEP := Nil;
        try
           RetiraMascara(aCep);
           lCEPValido  := CepValido(aCep);
           if not lCEPValido.OK then
           begin
                lRetornoCEP := TRetornoCEP.Create(lCEPValido.Mensagem);
                if Assigned(aProcessaRetorno) then
                begin
                     aProcessaRetorno(lRetornoCEP);
                end;
                Exit;
           end;
        finally
            FreeAndNil(lRetornoCEP);
        end;
        //A thread sera iniciada no método ConsultarCEP
        lThreadConsultaCep := TThreadConsultaCep.Create(aCep,
                                                        aBaseLocalURL,
                                                        aProcessaRetorno);
        lThreadConsultaCep.Start;

     except on E: Exception do
           begin
                if Assigned(aProcessaRetorno) then
                begin
                     lRetornoCEP := TRetornoCEP.Create('Erro ao consultar cep');
                     aProcessaRetorno(lRetornoCEP);
                     FreeAndNil(lRetornoCEP);
                end;
           end;
     end;

end;

class procedure TConsultaCep.ConsultarCEPFaixa(aCepInicio, aCepFim,
                                               aBaseLocalURL: String;
                                               aProcessaRetorno : TCallBack;
                                               aProgressBarConsultaFaixa: TProgressBar);
  var  lCepInicio        : integer;
       lCepFim           : integer;
       I                 : integer;
       lThreadConsultaCep: TThreadConsultaCep;
       lCriticalSection  : TCriticalSection;
       lRetornoCEP       : TRetornoCEP;
       lCEPValido        : TCEPValido;
       lLogArquivo       : TextFile;
       lLogArquivoPath   : string;


begin
     try
        lRetornoCEP := Nil;
        try
           if FExecutandoCepFaixa then
           begin
                lRetornoCEP := TRetornoCEP.Create('Aguarde. Executando '+
                                                  'processamento em faixa.');
                aProcessaRetorno(lRetornoCEP);
                Exit;
           end;

           RetiraMascara(aCepInicio);
           RetiraMascara(aCepFim);

           //valida cep inicio
           lCEPValido  := CepValido(aCepInicio);
           if not lCEPValido.OK then
           begin
                if Assigned(aProcessaRetorno) then
                begin
                     lRetornoCEP := TRetornoCEP.Create(lCEPValido.Mensagem);
                     aProcessaRetorno(lRetornoCEP);
                end;
                Exit;
           end;

           //valida cep fim
           lCEPValido  := CepValido(aCepFim);
           if not lCEPValido.OK then
           begin
                if Assigned(aProcessaRetorno) then
                begin
                     lRetornoCEP := TRetornoCEP.Create(lCEPValido.Mensagem);
                     aProcessaRetorno(lRetornoCEP);
                end;
                Exit;
           end;

           lCepInicio := StrToInt(aCepInicio);
           lCepFim    := StrToInt(aCepFim);

           if lCepInicio > lCepFim then
           begin
                if Assigned(aProcessaRetorno) then
                begin
                     lRetornoCEP := TRetornoCEP.Create('O CEP de inicio não pode'+
                                                       ' ser maior que o de fim.');
                     aProcessaRetorno(lRetornoCEP);
                end;
                Exit;
           end;
        finally
           FreeAndNil(lRetornoCEP);
        end;

        aProgressBarConsultaFaixa.Max := lCepFim - lCepInicio +1;
        aProgressBarConsultaFaixa.Position := 0;

        //varialvel de controle
        FExecutandoCepFaixa := True;

        //Seção critica;
        lCriticalSection := TCriticalSection.Create;

        {$REGION 'Configurando arquivo'}
        lLogArquivoPath := ExtractFilePath(ParamStr(0)) + 'log.txt';

        AssignFile(lLogArquivo, lLogArquivoPath);

        if not FileExists(lLogArquivoPath) then
        begin
             Rewrite(lLogArquivo)
        end
        else
        begin
             Append(lLogArquivo);
        end;
       {$ENDREGION}

        for I := lCepInicio to lCepFim do
        begin
             lThreadConsultaCep :=
              TThreadConsultaCep.Create(IntToStr(i),
                                        aBaseLocalURL,
                                        procedure (aRetornoCEP: TRetornoCEP)
                                        begin
                                             //Escrece o log
                                             Writeln(lLogArquivo,
                                                     FormatDateTime('dd/mm/yyyy hh:nn:ss',Now)+
                                                     ' : ' +aRetornoCEP.Mensagem+
                                                     slineBreak);

                                             with aProgressBarConsultaFaixa do
                                             begin
                                                   Position := Position+1;
                                                   if Position = max  then
                                                   begin
                                                        //Na última vez reseta as
                                                        //variaveis.
                                                        Position := 0;
                                                        FExecutandoCepFaixa := False;
                                                        FreeAndnil(lCriticalSection);
                                                        CloseFile(lLogArquivo);
                                                   end;
                                             end;
                                        end,
                                        True,
                                        lCriticalSection);
             lThreadConsultaCep.Start();
        end;

     except on E: Exception do
         begin
              aProgressBarConsultaFaixa.Position := 0;
              FExecutandoCepFaixa := False;
              FreeAndnil(lCriticalSection);
              CloseFile(lLogArquivo);

              if Assigned(aProcessaRetorno) then
              begin
                   lRetornoCEP := TRetornoCEP.Create('Erro ao carregar CEP por'+
                                                     ' faixa.');
                   aProcessaRetorno(lRetornoCEP);
                   FreeAndNil(lRetornoCEP);
              end;
         end;
     end;
end;

class function TConsultaCep.CepValido(aCep : String): TCEPValido;
begin
     try
        Result.OK:= True;

        aCep := StringReplace(aCep,' ','',[rfReplaceAll]);

        if aCep.Trim.IsEmpty then
        begin
             Result.OK:= False;
             Result.Mensagem := 'CEP não informado.';
             Exit;
        end;

        if aCep.Trim.Length <> 8 then
        begin
             Result.OK:= False;
             Result.Mensagem := 'CEP inválido. O CEP não tem 8 dígitos.';
             Exit;
        end;

        try
           StrToInt(aCep);
        except on E: EConvertError do
            begin
                 Result.OK:= False;
                 Result.Mensagem := 'CEP inválido. O CEP deve conter apenas números.';
            end;
        end;

     except on E: Exception do
        begin
             Result.OK:= False;
             Result.Mensagem := 'Erro ao validar o CEP informado.';
        end;
     end;
end;
class procedure TConsultaCep.RetiraMascara(var aCep: String);
begin
     // A máscara contém apenas "-"
     aCep := StringReplace(aCep,'-','',[]);
end;
  initialization
  TConsultaCep.FExecutandoCepFaixa := False;
end.


