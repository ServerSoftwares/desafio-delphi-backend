# Desafio Front Delphi + Backend

## Projeto do processo seletivo da empresa Server Software

# Descritivo do desafio

O desafio é implementar um backend REST para uma aplicação de consulta de CEPS.

Foi utilizado C# para a criação de uma API .NET

## Banco de dados
Utilize o banco de dados que tiver maior facilidade e que atenda as necessidades do desafio. Não é obrigatório o uso de banco de dados, podendo ser utilizado uma estrutura em memoria ou de arquivo para obter os ceps.

Foi utilizado um banco de dados Firebird.

# Observações
- Verificar o uso de Verbos HTTP para construção da API
- **Opcional**: Utilização de Swagger ou semelhante para documentação da API - Realizado
- **Opcional**: Separar a camada de comunicação com o banco da camada da API - Realizado
- **Opcional**: Rodar o backend e o banco de dados em um container. - Realizado para o backend

## Front Aplicativo Consulta de CEPs em Delphi

O desenvolvimento do aplicativo consiste em consumir a API de consulta de CEP. Ao contrário do Backend, o Front precisa ser desenvolvido em Delphi.

Seu objetivo é realizar o consumo desta API, seguindo o escopo abaixo:

- Tela inicial deve conter um campo para o usuário informar um código de CEP, com uma máscara apropriada para CEPs.
- Deve possuir um botão "Consultar" que após clicado, deverá executar a rotina de consulta de CEP e exibir na tela TODOS os dados retornados da consulta, como UF, Endereço, Bairro, etc...
- Implementar tratamentos de erros e de time-out. Caso a API não responda em até 5 segundos, uma mensagem deverá ser retornada para o usuário que o serviço de CEP está indisponível no momento e que ele deverá tentar novamente mais tarde. 
- Caso o usuário informe um CEP com formato ou conteúdo inválido o tratamento deverá ser realizado pela aplicação antes de realizar a consulta na API e a mensagem adequada exibida para o usuário.
- A rotina de consulta de CEP deverá ser encapsulada em uma Classe TConsultaCEP, onde tudo que seja necessário para realizar o acesso a API esteja auto contido na classe de maneira que essa consulta de CEP possa ser utilizada numa outra tela ou até mesmo numa outra aplicação apenas instanciando a classe e chamando um método "ConsultarCEP(xxx)", que deverá encapsular o retorno dos dados também numa classe. Ex: TRetornoCEP.

Todos os requisitos do escopo foram realizados.

## Adicionais 

Os adicionais não são obrigatórios, mas considere implementa-los. Lembre-se de que o desafio é um "showcase" dos seus skills, então quanto mais skills você nos mostrar, mais chance terá de receber uma boa proposta.

- Adicional 1: Utilizar threads ou tasks para que a tela não fique trancada no momento da consulta
- Adicional 2: Fazer um comando no programa para a cada X minutos (configurado no proprio aplicativo) consultar uma faixa de ceps (Ex: do 93336-999 ao 93336-999).. essa faixa tambem tem que ser configurada, acessar os ceps e salvar eles no banco de dados de cache de ceps ou atualizar caso já exista.  Detalhe: cuidar para não dar erro de uso indevido da api (não fazer milhares de acessos em sequencia, colocar um intervalo de tempo). Essa busca deverá ser realizada de forma que não trave a tela (em thread ou task)... e cuidar para que os erros de acesso sejam tratados e salvos em arquivo de log (não pode subir erros na tela para o usuario durante a execução automatica).. quando a task tiver em execução, colocar um aviso em tela para o usuario de que a mesma está rodando (por exemplo, num status bar) a consulta normal tem que continua funcionando durante o processamento das faixas de CEP. Colocar um botão na tela para disparar manualmente, caso o usuario não queria esperar os minutos configurados para rodar automaticamente. Cuidar para não deixar o programa disparar em duplicidade a rotina de busca de faixas (ex: se configurar para disparar a cada poucos minutos, quando chegar o tempo do novo disparo, se a execução anterior ainda tiver em andamento, tem que tratar para não ter duas rodando ao mesmo tempo, ou se o usuario clicar no botão pra disparar manualmente e ja tiver uma automatica sendo executada, tem que parar a que esta rodando ou dar uma mensagem de que ja tem um processamento em execução)
- Adicional 3: Ao consultar um CEP, os dados retornados devem ser gravados num banco de dados (Postgres de preferencia, mas pode ser outro). Ao consultar um cep, antes de acessar a API, deverá consultar no banco e retornar do banco caso o CEP já exista. Para isso, deverá ser criado a logica de acesso banco numa classe DAO separada da classe de consulta na API (não misturar responsabilidade das classes, pois a classe TConsultaCEP deve continuar sendo possivel obter os CEPs sem que seja necessario acesso a banco de dados)

O adicional 3 foi realizado.

## Prazo: 
O prazo deverá ser calculado pelo candidato antes de iniciar o trabalho e informado.

O projeto foi realizado de 20/03 à 24/03 - 5 dias.
