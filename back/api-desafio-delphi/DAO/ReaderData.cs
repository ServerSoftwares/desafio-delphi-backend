using System.Data;

namespace api_desafio_delphi.DAO
{
    public static class ReaderData
    {
        public static string ReadString(DataRow dr, string campo)
        {
            if (!DBNull.Value.Equals(dr[campo]))
            {
                string valor = dr[campo].ToString();

                return valor;
            }
            else
                return "";
        }

    }
}