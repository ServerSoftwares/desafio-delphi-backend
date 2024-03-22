using System.Data;

using FirebirdSql.Data.FirebirdClient;

namespace api_desafio_delphi.DAO
{
    public static class DAO
    {
        /// <summary>
        /// 
        /// </summary>
        /// <param name="cmd"></param>
        /// <returns></returns>
        public static long ExecuteReturnId(FbCommand cmd)
        {
            long Id = 0;

            FbConnection conn = Connection.getConnection();
            conn.Open();
            FbTransaction t = conn.BeginTransaction();

            try
            {
                cmd.Connection = conn;
                cmd.Transaction = t;
                //cmd.ExecuteNonQuery();
                Id = (long)cmd.ExecuteScalar();
                t.Commit();
            }
            catch (Exception ex)
            {
                t.Rollback();
                throw ex;
            }
            finally
            {
                if (!(conn.State == ConnectionState.Closed))
                    conn.Close();
            }

            return Id;
        }

        /// <summary>
        /// executar um comando
        /// </summary>
        /// <param name="cmd">comando para ser executado</param>
        /// <returns>se sucesso</returns>
        public static Boolean Execute(FbCommand cmd)
        {
            FbConnection conn = Connection.getConnection();
            conn.Open();
            FbTransaction t = conn.BeginTransaction();

            try
            {
                cmd.Connection = conn;
                cmd.Transaction = t;
                cmd.ExecuteNonQuery();
                t.Commit();
            }
            catch (Exception ex)
            {
                t.Rollback();
                throw ex;
            }
            finally
            {
                if (!(conn.State == ConnectionState.Closed))
                    conn.Close();
            }

            return true;
        }

        /// <summary>
        /// executar um comando dentro de uma transacao
        /// </summary>
        /// <param name="cmd">comando para executar</param>
        /// <param name="t">transacao a qual sera executado</param>
        /// <returns>se sucesso</returns>
        public static Boolean Execute(FbCommand cmd, FbTransaction t)
        {
            FbConnection conn = Connection.getConnection();
            conn.Open();

            try
            {
                cmd.Connection = conn;
                cmd.Transaction = t;
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                t.Rollback();
                throw ex;
            }
            finally
            {
                if (!(conn.State == ConnectionState.Closed))
                    conn.Close();
            }

            return true;
        }

        /// <summary>
        /// executar uma lista de comandos
        /// </summary>
        /// <param name="cmds">lista de comandos para executar</param>
        /// <returns>se sucesso</returns>
        public static Boolean Execute(List<FbCommand> cmds)
        {
            FbConnection conn = Connection.getConnection();
            conn.Open();
            FbTransaction t = conn.BeginTransaction();

            try
            {
                foreach (FbCommand cmd in cmds)
                {
                    cmd.Connection = conn;
                    cmd.Transaction = t;
                    cmd.ExecuteNonQuery();
                }
                t.Commit();
            }
            catch (FbException ex)
            {
                t.Rollback();
                throw ex;
            }
            catch (Exception ex)
            {
                t.Rollback();
                throw ex;
            }
            finally
            {
                if (!(conn.State == ConnectionState.Closed))
                    conn.Close();
            }

            return true;
        }

        /// <summary>
        /// executar uma lista de comandos dentro de uma transacao
        /// </summary>
        /// <param name="cmds">lista de comandos para executar</param>
        /// <param name="t">transacao a qual sera executado</param>
        /// <returns>se sucesso</returns>
        public static Boolean Execute(List<FbCommand> cmds, FbTransaction t)
        {
            FbConnection conn = Connection.getConnection();
            conn.Open();

            try
            {
                foreach (FbCommand cmd in cmds)
                {
                    cmd.Connection = conn;
                    cmd.Transaction = t;
                    cmd.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {
                t.Rollback();
                throw ex;
            }
            finally
            {
                if (!(conn.State == ConnectionState.Closed))
                    conn.Close();
            }

            return true;
        }

        /// <summary>
        /// executar selects
        /// </summary>
        /// <param name="query">consulta</param>
        /// <returns>um dataset com a consulta</returns>
        public static DataSet Open(String query)
        {
            FbConnection conn = Connection.getConnection();
            conn.Open();
            DataSet dataSet = new DataSet();

            try
            {
                FbDataAdapter adapter = new FbDataAdapter(query, conn);

                adapter.Fill(dataSet);

                return dataSet;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                if (!(conn.State == ConnectionState.Closed))
                {
                    conn.Close();
                    dataSet.Dispose();
                }
            }
        }

        /// <summary>
        /// executar selects
        /// </summary>
        /// <param name="cmd">comando a ser executado</param>
        /// <returns>retorna um reader com o select</returns>
        public static FbDataReader ReturnRecord(FbCommand cmd)
        {
            FbConnection conn = Connection.getConnection();
            conn.Open();

            try
            {
                cmd.Connection = conn;
                return cmd.ExecuteReader();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}