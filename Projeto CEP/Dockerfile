
FROM node:16.16.0

# Cria diretório
WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY .env ./

COPY backend ./backend

# Instala o PostgreSQL
RUN apt-get update && \
    apt-get install -y postgresql postgresql-contrib

# Cria diretório PostgreSQL
RUN mkdir -p /var/lib/postgresql/data


EXPOSE 3000

#inicia a aplicação
CMD ["npm", "start"]
