export default class CEP {

    constructor(cep, uf, bairro, cidade, logradouro) {
        this.cep = cep;
        this.uf = uf;
        this.bairro = bairro;
        this.cidade = cidade;
        this.logradouro = logradouro;
    }
    
    valida() {
        var resultado = {
            ok: true,
            mensagem: ""
        };

        if (!this.cep.trim()) {
            resultado.ok = false;
            resultado.mensagem = 'CEP não informado.';
            return resultado;
        }

        if (this.cep.trim().length !== 8) {
            resultado.ok = false;
            resultado.mensagem = 'CEP inválido. O CEP não tem 8 dígitos.';
            return resultado;
        }

        if (isNaN(this.cep)) {
            resultado.ok = false;
            resultado.mensagem = 'CEP inválido. O CEP deve conter apenas números.';
            return resultado;
        }

        return resultado;
    }
    
  
}