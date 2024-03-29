const app = require('./app');
require('dotenv').config();
const swaggerUi = require('swagger-ui-express');
const swaggerDocs = require('../src/swagger.json');

const PORT = process.env.PORT || 3000;

app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerDocs));

app.listen(PORT, () => console.log(`server running on port ${PORT}`));