function CEPRepository(CEPdb) {
    function create(CEP) {

        return CEPdb.create(CEP, { logging: false })
            .then(() => {
                console.log('CEP Criado!')
                return true
            })
            .catch((error) => {
                console.log('Erro ao Criar CEP' + error)
                return false
            })

    }

    function update(CEP, cep) {

        return CEPdb.update(CEP,
            {
                logging: false,
                where: {
                    cep: cep
                }
            })
            .then(([rowsAffected]) => {
              
                if (rowsAffected == 0) {
                    console.log('CEP não encontrado e não Atualizado!')
                    return false;
                }
                console.log('CEP Atualizado!')
                return true
            })
            .catch((error) => {
                console.log('Erro ao Atualizar CEP' + error)
                return false
            })
    }

    function get(cep) {

        return CEPdb.findOne({
            logging: false,
            where: {
                cep: cep
            }
        }).then((obteve) => {
           
            if (!obteve){
                return false; 
            }
            console.log('CEP Obtido com sucesso!')
            return obteve
        })
        .catch((error) => {
            console.log('Erro ao obter CEP' + error)
            return false
        })
    }

    function deleteCEP(cep) {

        return CEPdb.destroy({
            logging: false,
            where: {
                cep: cep
            }
        })
        .then((rowsAffected) => {
            if (rowsAffected == 0) {
                console.log('CEP não encontrado e não Apagado!')
                return false;
            }
            console.log('CEP Apagado!')
            return true
        })
        .catch((error) => {
            console.log('Erro ao apagar CEP' + error)
            return false
        })
    }

    return {
        get,
        update,
        create,
        deleteCEP
    }

}
export default CEPRepository;