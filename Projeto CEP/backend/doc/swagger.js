import swaggerJSDoc from 'swagger-jsdoc';
import swaggerUi from 'swagger-ui-express';

const swaggerOptions = {
  swaggerDefinition: {
    info: {
      title: 'API de CEP',
      description: 'Gerência Código de Endereçamento Postal',
      version: '1.0.0',
    },
    components: {
      CEP: {
        type: 'object',
        properties: {
          cep: { type: 'string' },
          uf: { type: 'string' },
          cidade: { type: 'string' },
          logradouro: { type: 'string' },
          bairro: { type: 'string' }
        }
      },
    }
  },
  apis: ['backend/src/controller/CEPController.js']
};

const swaggerSpec = swaggerJSDoc(swaggerOptions);


export default (app) => {
  app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerSpec));
};