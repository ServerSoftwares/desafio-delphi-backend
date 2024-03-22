using FirebirdSql.Data.FirebirdClient;

namespace api_desafio_delphi.DAO
{
    public class Connection
    {
        private static readonly Connection instanciaFireBird = new Connection();

        private Connection() { }

        public static Connection getInstancia()
        {
            return instanciaFireBird;
        }

        public static FbConnection getConnection()
        {
            IConfigurationRoot configuration = new ConfigurationBuilder()
            .SetBasePath(AppDomain.CurrentDomain.BaseDirectory)
            .AddJsonFile("appsettings.json")
            .Build();

            return new FbConnection(configuration.GetConnectionString("DefaultConnection"));
        }
    }
}