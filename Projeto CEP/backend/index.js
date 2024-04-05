
import CEPmodel from './src/model/CEP.js'

import { Connection, DataTypes } from './src/database/connection.js';

import CEPdb from './src/model/CEPdb.js';

import CEPRepository from './src/repository/CEPRepository.js';

import CEPController from './src/controller/CEPController.js';

import express from 'express';

import bodyParser  from 'body-parser';

import Swagger  from './doc/swagger.js';

import dotenv from 'dotenv';

const app = express();

app.use(bodyParser.json());

//Tratar erros na API inteira
app.use((err, req, res, next) => {
    console.log(err.stack);
    res.status(500);
  });

const {parsed :parametrosIniciar } = dotenv.config();

const sequelize = await Connection(parametrosIniciar.database,
                                   parametrosIniciar.username,
                                   parametrosIniciar.password,
                                   parametrosIniciar.host,
                                   parametrosIniciar.dialect,
                                   parseInt(parametrosIniciar.dbport));

const cepdb = await CEPdb(sequelize, DataTypes);

const cepRepository = CEPRepository(cepdb);

CEPController(app,cepRepository,CEPmodel);

Swagger(app);

app.listen(parseInt(parametrosIniciar.port),()=>{
    console.log('Backend iniciado na porta '+parametrosIniciar.port);
})
 




