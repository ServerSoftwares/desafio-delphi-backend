FROM node:16-alpine

WORKDIR /api

COPY package*.json ./

RUN rm -rf node_modules
RUN npm install

COPY . .

EXPOSE 3000

CMD [ "npm", "start" ]
