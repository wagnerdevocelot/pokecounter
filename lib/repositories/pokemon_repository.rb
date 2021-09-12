# frozen_string_literal: true

module Repositories
  # O PokemonRepository é responsável por fazer a ligação entre a aplicação e a tabela Pokemon.
  class PokemonRepository
    def initialize
      @connection = PG.connect(dbname: 'pokecounter_development')
    end

    def get_all
      @connection.exec('SELECT * FROM pokemons')
    end

    def find_by_id(id)
      @connection.exec("SELECT * FROM pokemons WHERE id = #{id}").first
    end
  end
end
