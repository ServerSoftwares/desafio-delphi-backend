namespace api_desafio_delphi.Models
{
    public class TCEP
    {
        public string CEP { get; set; }
        public string UF { get; set; }
        public string Cidade { get; set; }
        public string Bairro { get; set; }
        public string Logradouro { get; set; }

        public TCEP(string xCEP, string xUF, string xCidade, string xBairro, string xLogradouro) { 
            CEP= xCEP;
            UF= xUF;
            Cidade= xCidade;
            Bairro= xBairro;
            Logradouro= xLogradouro;
        }

    }
}