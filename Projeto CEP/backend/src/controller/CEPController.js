function CEPController(app, CEPRepository, CEPmodel) {

    /**
    * @swagger
    * /cep/{cep}:
    *   get:
    *     tags:
    *       - CEP
    *     description: Retorna informações de um CEP específico
    *     produces:
    *       - application/json
    *     parameters:
    *       - name: cep
    *         in: path
    *         description: CEP que deseja consultar
    *         required: true
    *         type: string
    *     responses:
    *       200:
    *         description: Retorna as informações do CEP
    *         schema:
    *           $ref: '#/components/CEP'
    *       404:
    *         description: CEP não encontrado
    */

    /**
    * @swagger
    * /cep:
    *   post:
    *     tags:
    *       - CEP
    *     description: Insere um novo CEP
    *     produces:
    *       - application/json
    *     parameters:
    *       - name: cep
    *         in: body
    *         description: Dados do CEP a ser inserido
    *         required: true
    *         schema:
    *           $ref: '#/components/CEP'
    *     responses:
    *       201:
    *         description: CEP inserido com sucesso
    *       400:
    *         description: Falha ao inserir o CEP
    */


    /**
    * @swagger
    * /cep/{cep}:
    *   put:
    *     tags:
    *       - CEP
    *     description: Atualiza um CEP existente
    *     produces:
    *       - application/json
    *     parameters:
    *       - name: cep
    *         in: path
    *         description: CEP a ser atualizado
    *         required: true
    *         type: string
    *       - name: cep
    *         in: body
    *         description: Novos dados do CEP
    *         required: true
    *         schema:
    *           $ref: '#/components/CEP'
    *     responses:
    *       200:
    *         description: CEP atualizado com sucesso
    *       400:
    *         description: Falha ao atualizar o CEP
    */
    /**
    * @swagger
    * /cep/{cep}:
    *   delete:
    *     tags:
    *       - CEP
    *     description: Remove um CEP existente
    *     produces:
    *       - application/json
    *     parameters:
    *       - name: cep
    *         in: path
    *         description: CEP a ser removido
    *         required: true
    *         type: string
    *     responses:
    *       204:
    *         description: CEP removido com sucesso
    *       404:
    *         description: Falha ao remover o CEP
    */


    app.get('/cep/:cep', async (req, res, next) => {
        try {
            const CEP = await CEPRepository.get(req.params.cep)

            if (!CEP) return res.sendStatus(404)

            res.json(new CEPmodel(CEP.cep,
                                  CEP.uf,
                                  CEP.bairro,
                                  CEP.cidade,
                                  CEP.logradouro));

        } catch (error) {
            next(error)
        }
    })


    app.post('/cep', async (req, res, next) => {
        try {
            const CEP = new CEPmodel(req.body.cep,
                req.body.uf,
                req.body.bairro,
                req.body.cidade,
                req.body.logradouro);

            const resultado = CEP.valida()
         
            if (!resultado.ok) {
                console.log(resultado.mensagem)
                return res.sendStatus(400);
            }

            const existe = await CEPRepository.get(CEP.cep);
            
            let atualizadoInserido

            if (existe){
                 atualizadoInserido = await CEPRepository.update(CEP, CEP.cep); 
            } else{
                 atualizadoInserido = await CEPRepository.create(CEP);
            }  

            if (!atualizadoInserido) return res.sendStatus(400);

            res.sendStatus(201);
        } catch (error) {
            next(error)
        }
    })


    app.put('/cep/:cep', async (req, res, next) => {
        try {
            if (!req.params.cep) return res.sendStatus(400)

            const CEP = new CEPmodel(req.body.cep,
                req.body.uf,
                req.body.bairro,
                req.body.cidade,
                req.body.logradouro);

            const resultado = CEP.valida()

            if (!resultado.ok) {
                console.log(resultado.mensagem)
                return res.sendStatus(400);
            }

            const atualizado = await CEPRepository.update(CEP, req.params.cep);

            if (!atualizado) return res.sendStatus(400);

            res.sendStatus(200);

        } catch (error) {
            next(error)
        }
    })

    app.delete('/cep/:cep', async (req, res, next) => {
        try {
            if (!req.params.cep) return res.sendStatus(404)

            const apagado = await CEPRepository.deleteCEP(req.params.cep);

            if (!apagado) return res.sendStatus(404);

            res.sendStatus(204);
        } catch (error) {
            next(error)
        }
    })
}

export default CEPController