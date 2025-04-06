# PokéCounter

PokéCounter é uma aplicação desenvolvida para gerenciar e consultar informações relacionadas ao universo Pokémon, como habilidades, movimentos, tipos e estatísticas. Este projeto é ideal para jogadores e entusiastas que desejam explorar estratégias e vantagens entre Pokémon, com foco em criar times otimizados para batalhas competitivas.

## Requisitos

- **Ruby versão:** 2.7.2 ou superior
- **Rails versão:** 6.0.4 ou superior
- **Dependências do sistema:**
  - PostgreSQL
  - Node.js
  - npm

## Configuração

1. Clone o repositório:
   ```bash
   git clone https://github.com/seu-usuario/pokecounter.git
   cd pokecounter
   ```

2. Instale as dependências:
   ```bash
   # Instale as dependências Ruby
   bundle install

   # Instale as dependências JavaScript com npm
   npm install
   ```

3. Configure o banco de dados:
   - Crie o banco de dados:
     ```bash
     rails db:create
     ```
   - Execute as migrações:
     ```bash
     rails db:migrate
     ```
   - Popule o banco com os dados iniciais:
     ```bash
     rails db:seed
     ```

   Se precisar reiniciar o banco de dados:
   ```bash
   rails db:drop
   rails db:create
   rails db:migrate
   rails db:seed
   ```

4. Desabilite a verificação de integridade do Yarn:
   - Se você encontrar erros relacionados ao Yarn, edite o arquivo `config/webpacker.yml` e altere:
     ```yaml
     development:
       <<: *default
       compile: true
       check_yarn_integrity: false
     ```

## Inicialização

Para iniciar o servidor local, execute:
```bash
rails server
```
O servidor estará disponível em [http://localhost:3000](http://localhost:3000).

## Testes

Para executar a suíte de testes, use:
```bash
rspec
```

## Estrutura do Projeto

- **`app/models`**: Contém os modelos principais, como `Pokemon` e `Type`, que representam os Pokémon e seus tipos.
- **`app/controllers`**: Inclui controladores como `HomeController` e controladores da API.
- **`lib/services`**: Contém serviços como `PokemonService` e `TypeService`, que implementam a lógica de negócios, incluindo a análise de fraquezas e fortalezas de times.
- **`lib/repositories`**: Inclui repositórios como `PokemonRepository` e `TypeRepository`, responsáveis pela interação com o banco de dados.
- **`db/migrate`**: Contém as migrações do banco de dados para criar e modificar tabelas.
- **`spec`**: Contém os testes automatizados organizados por controladores, modelos, serviços e repositórios.
- **`features`**: Contém testes de aceitação escritos com Cucumber.

## Funcionalidades

- **Pokédex Interativa**: Permite buscar Pokémon e visualizar suas informações detalhadas.
- **Análise de Counters**: Identifica Pokémon que têm vantagem contra outros com base em tipos e estatísticas.
- **Classificação de Counters**: Ordena counters com base em atributos como ataque, defesa e velocidade.
- **Criação de Times Otimizados**: Envia um time e recebe como resposta um time que countera as fraquezas e fortalezas do time oponente, com foco em batalhas competitivas.
- **Suporte a Múltiplos Papéis**: Define papéis como "Physical Sweeper" ou "Special Tank" para Pokémon.
- **Suporte a Múltiplos Idiomas**: Inclui traduções para nomes e descrições de Pokémon e movimentos.

## Exemplos de uso dos endpoints

### Retorna toda a Pokédex
```bash
curl --location 'http://localhost:3000/api/v1/home/pokedex'
```

### Retorna todos os Pokémon que dão counter no Pokémon do ID especificado
```bash
curl --location 'http://localhost:3000/api/v1/home/counters/1'
```

### Retorna todos os Pokémon que dão counter no Pokémon do ID especificado, incluindo os lendários
```bash
curl --location 'http://localhost:3000/api/v1/home/counters/2&legendary=true'
```

## Exemplos de Retorno dos Endpoints

### Retorna toda a Pokédex
```json
[
    {
        "id": 1,
        "name": "Bulbasaur",
        "type_a_id": 5,
        "type_b_id": 8,
        "created_at": "2025-04-06T20:03:06.478Z",
        "updated_at": "2025-04-06T20:03:06.478Z",
        "hp": 45,
        "attack": 49,
        "defense": 49,
        "special_attack": 65,
        "special_defense": 65,
        "speed": 45,
        "form": " ",
        "total": 318,
        "generation": 1,
        "learned_moves": []
    },
    {
        "id": 2,
        "name": "Ivysaur",
        "type_a_id": 5,
        "type_b_id": 8,
        "created_at": "2025-04-06T20:03:06.483Z",
        "updated_at": "2025-04-06T20:03:06.483Z",
        "hp": 60,
        "attack": 62,
        "defense": 63,
        "special_attack": 80,
        "special_defense": 80,
        "speed": 60,
        "form": " ",
        "total": 405,
        "generation": 1,
        "learned_moves": []
    }
    ...
]
```

### Retorna todos os Pokémon que dão counter no Pokémon do ID especificado
```json
[
    {
        "id": 716,
        "name": "Rayquaza",
        "type_a_id": 15,
        "type_b_id": 10,
        "created_at": "2025-04-06T20:03:09.706Z",
        "updated_at": "2025-04-06T20:03:09.706Z",
        "hp": 105,
        "attack": 180,
        "defense": 100,
        "special_attack": 180,
        "special_defense": 100,
        "speed": 115,
        "form": "Mega Rayquaza",
        "total": 780,
        "generation": 6,
        "learned_moves": []
    },
    {
        "id": 687,
        "name": "Mewtwo",
        "type_a_id": 11,
        "type_b_id": 7,
        "created_at": "2025-04-06T20:03:09.572Z",
        "updated_at": "2025-04-06T20:03:09.572Z",
        "hp": 106,
        "attack": 190,
        "defense": 100,
        "special_attack": 154,
        "special_defense": 100,
        "speed": 130,
        "form": "Mega Mewtwo X",
        "total": 780,
        "generation": 6,
        "learned_moves": []
    }
    ...
]
```

## Contribuição

Contribuições são bem-vindas! Para contribuir:

1. Faça um fork do repositório.
2. Crie uma branch para sua feature ou correção:
   ```bash
   git checkout -b minha-feature
   ```
3. Faça commit das suas alterações:
   ```bash
   git commit -m "Adiciona minha nova feature"
   ```
4. Envie para o repositório remoto:
   ```bash
   git push origin minha-feature
   ```
5. Abra um Pull Request.

## Licença

Este projeto está licenciado sob a [MIT License](LICENSE).

## Contato

Para dúvidas ou sugestões, entre em contato pelo e-mail: [seu-email@example.com].
