async function CEPdb(sequelize, DataTypes) {

    const CEPdb =  sequelize.define('cep',
        {
            id: {
                field: 'id',
                type: DataTypes.INTEGER,
                allowNull: false,
                primaryKey: true,
                unique: true,
                autoIncrement :true       
            },
            cep: {
                field: 'cep',
                type: DataTypes.STRING(8),
                allowNull: false,
                unique: true
            },
            uf: {
                field: 'uf',
                type: DataTypes.STRING(2),
                allowNull: false
            },
            bairro: {
                field: 'bairro',
                type: DataTypes.STRING
            },
            cidade: {
                field: 'cidade',
                type: DataTypes.STRING
            },
            logradouro: {
                field: 'logradouro',
                type: DataTypes.STRING
            }
        },
        {
            tableName: 'cep'
        })

       await CEPdb.sync()
       

    return CEPdb
       
    
}

export default CEPdb;