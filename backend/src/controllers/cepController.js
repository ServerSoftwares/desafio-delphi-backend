const axios = require('axios');
const cepModel = require('../models/cepModel');

const createCep = async (req, res) => {

  const { cep } = req.params; 
  const resjson = await axios
    .get(`https://viacep.com.br/ws/${cep}/json/`)
    .then((res) => {

      return res.data;    
    })
    .catch((err) => {
      console.log(err);
    });

  const createdCep = await cepModel.createCep(resjson);
  return res.status(201).json(createdCep);
};

const getAll = async (_req, res) => {
  const ceps = await cepModel.getAll();
  return res.status(200).json(ceps);
};

const get = async (req, res) => {

  const cep = await cepModel.get(req.params);
  return res.status(200).json(cep); 
};

const updateCep = async (req, res) => {

  const { cep } = req.params;

  const rescep = await cepModel.updateCep(cep, req.body);
  return res.status(200).json(rescep); 
};

const deleteCep = async (req, res) => {

  const cep = await cepModel.deleteCep(req.params);
  return res.status(200).json(cep); 
};

module.exports = {
  createCep,
  getAll,
  get,
  updateCep,
  deleteCep
};
