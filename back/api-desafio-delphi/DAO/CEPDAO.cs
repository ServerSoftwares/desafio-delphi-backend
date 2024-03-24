using System.Data;
using api_desafio_delphi.Models;

namespace api_desafio_delphi.DAO
{
    public class CEPDAO
    {
        public TCEP? CarregarPorCEP(string cep)
        {
            string sql
                = $"SELECT CEP, UF, CIDADE, BAIRRO, LOGRADOURO FROM TBCEP WHERE CEP = '{cep}'";

            DataTable dt = DAO.Open(sql).Tables[0];
            if (dt.Rows.Count.Equals(0))
            {
                return null;
            }
            else
            {
                DataRow dr = dt.Rows[0];
                return ExecutarMapeamento(dr);
            }
        }

        public TCEP ExecutarMapeamento(DataRow dr)
        {
            TCEP obj = new TCEP(
                ReaderData.ReadString(dr, "CEP"),
                ReaderData.ReadString(dr, "UF"),
                ReaderData.ReadString(dr, "CIDADE"),
                ReaderData.ReadString(dr, "BAIRRO"),
                ReaderData.ReadString(dr, "LOGRADOURO"));

            return obj;
        }
    }
}
