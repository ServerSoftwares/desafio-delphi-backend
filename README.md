*  Comecei esse pojeto no dia 27/03/2024 até o dia 03/04/2024, dedicando em torno duas horas por dia nele.
# Projeto CEP

## Como compilar e executar o backend e frontend.
### Video demostrativo: https://share.vidyard.com/watch/2Bgq22sG7kfY781pBvxRbD?
- Clone o repositório : git clone https://github.com/gittiagohub/desafio-delphi-backend.git
- Baixe e instale o gerenciador de denpendêcias boss: https://github.com/hashload/boss/releases
- Baixe e instale o node.js v16.16.0
- Baixe e instale o docker
- Abra o terminal na pasta  "desafio-delphi-backend\Projeto CEP" e execute "npm i" para instalar todas as dependências do backend em node.js.
  Na mesma pasta execute "boss i" para instalar as dependências do frontend em delphi

  ### - Para o backend
- Caso for rodar local, crie o banco de dados com o nome escolhido na propriedade database abaixo e
renomeio o arquivo ".env.example" para ".env" que esta na pasta "desafio-delphi-backend\Projeto CEP" que possui as seguintes propriedades:
  - port= Porta que vai rodar o backend
  - database= Nome do banco de dados
  - username= Usuário do banco de dados
  - password= Senha do banco de dados
  - host= Local onde esta rodando o banco de dados
  - dialect= Banco de dados "postgres"
  - dbport= Porta que esta rodando o banco de dados
   
  - Agora abra o terminal na pasta "desafio-delphi-backend\Projeto CEP" execute "npm run start"
- Caso for rodar o container:
  -  renomeio o arquivo ".env.ContainerExample" para ".env" que esta na pasta "desafio-delphi-backend\Projeto CEP"
  -  abra o terminal na pasta "desafio-delphi-backend\Projeto CEP" e execute "docker-compose up --build"
 
   ### - Para o frontend
  - abra o delphi e abra o projeto "ProjectCEP.dproj" que esta na pasta "desafio-delphi-backend\Projeto CEP"
  - Build o projeto e execute.
  - na pasta do exe será criado o arquivo "config.ini" que contém a propriedade "BackEndHost" para definir onde o backend esta rodando
 
  ## Falando um pouco sobre o projeto e demonstrando.
  - https://share.vidyard.com/watch/mMNXQursZdRigaZpPvVABv?
  


