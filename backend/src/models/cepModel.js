const connection = require('./connection');

const createCep = async (resjson) => {

  const { cep, logradouro, bairro, localidade, uf } = resjson;
  
  const query = 'INSERT INTO CONSULTACEP.CEP (cep, logradouro, bairro, localidade, uf) VALUES (?, ?, ?, ?, ?)';
  
  const [createdCep] = await connection.execute(query, [cep, logradouro, bairro, localidade, uf]);
  return createdCep;
};

const getAll = async () => {
  const [ceps] = await connection.execute('SELECT * FROM CONSULTACEP.CEP');
  return ceps;
};

const get = async (reqcep) => {
  
  const { cep } = reqcep;
  const query = 'SELECT * FROM CONSULTACEP.CEP WHERE CEP = ?';
  const rescep = await connection.execute(query, [cep]);
  
  return rescep;
};

const updateCep = async (cep, reqcep) => {
  
  const { logradouro, bairro, localidade, uf } = reqcep;
  const query = 'UPDATE CONSULTACEP.CEP SET LOGRADOURO = ?, BAIRRO = ?, LOCALIDADE = ?, UF = ? WHERE CEP = ?';
  const [rescep] = await connection.execute(query, [logradouro, bairro, localidade, uf, cep]);
  return rescep;
};

const deleteCep = async (reqcep) => {
  
  const { cep } = reqcep;
  const query = 'DELETE FROM CONSULTACEP.CEP WHERE CEP = ?';
  const [rescep] = await connection.execute(query, [cep]);
  return rescep;
};

module.exports = {
  createCep,
  getAll,
  get,
  updateCep,
  deleteCep
};
