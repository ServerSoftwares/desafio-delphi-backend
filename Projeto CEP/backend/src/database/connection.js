import { Sequelize, DataTypes } from 'sequelize';

function ErroConexaoBanco(error) {
    console.error('Erro ao conectar no banco de dados: ', error)
}

function SucessoConexaoBanco() {
    console.log('Conexão com o banco OK');
}

async function Connection(database, username, password, host,dialect, port) {

    const sequelize = new Sequelize(
        database,
        username,
        password,
        {
            host: host,
            dialect: dialect,
            port: port
        }
    )
    
    await sequelize.authenticate()
        .then(SucessoConexaoBanco)
        .catch(ErroConexaoBanco)
    
    return sequelize;
}

export  { Connection, DataTypes };