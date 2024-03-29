const express = require('express');
const router = express.Router();

const cepController = require('./controllers/cepController');

router.get('/cep', cepController.getAll);
router.get('/cep/:cep', cepController.get);
router.post('/cep/:cep', cepController.createCep);
router.put('/cep/:cep', cepController.updateCep);
router.delete('/cep/:cep', cepController.deleteCep);

module.exports = router;